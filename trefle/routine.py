import asyncio
from pathlib import Path

from lxml import etree
import requests
import yaml

from .config import (CONSTANTS, ELIGIBILITE, FINANCEMENTS, PRISE_EN_CHARGE,
                     REMUNERATION)
from .exceptions import NoDataError, UpstreamError
from .rules import Rule

with (Path(__file__).parent / 'config/idcc.yml').open() as f:
    IDCC = yaml.safe_load(f.read())

INTERCARIF_URL = 'https://labonneformation.pole-emploi.fr/ws_intercarif'


def flatten(data, output=None, namespace=None):
    """Turn {'a': {'b': 'value'}} in {'a.b': 'value'}."""
    if output is None:
        output = {}
    if namespace is None:
        namespace = []
    for key, more in data.items():
        ns = namespace.copy()
        ns.append(key)
        if isinstance(more, dict):
            flatten(more, output, ns)
            continue
        name = '.'.join(ns)
        output[name] = more
    data.clear()
    data.update(output)


def add_constants(data):
    data.update(CONSTANTS)


def preload_financements(data):
    # Copy.
    data['financements'] = {k: dict(v) for k, v in FINANCEMENTS.items()}


def idcc_to_organismes(data):
    key = 'beneficiaire.entreprise.idcc'
    if key not in data:
        raise NoDataError('Missing idcc in data')
    try:
        idcc = int(data[key])
    except (ValueError, TypeError):
        raise ValueError(f'Invalid IDCC value {idcc}')
    if idcc not in IDCC:
        raise ValueError(f'Unknown IDCC {idcc}')
    data['beneficiaire.entreprise.opca'] = IDCC[idcc]['OPCA']
    data['beneficiaire.entreprise.opacif'] = IDCC[idcc]['OPACIF']


def check_eligibilite(data):
    Rule.process(ELIGIBILITE, data)


async def populate_formation(data):
    if not data.get('formation.numero'):
        return

    formation_id = data['formation.numero']
    response = await http_get(f'{INTERCARIF_URL}?num={formation_id}')
    if response.status_code >= 500:
        raise UpstreamError(f"UPSTREAM_ERROR: {response.status_code}")

    try:
        populate_formation_from_bytes(data, response.content)
    except ValueError as err:
        # Give more context.
        err.args = (f'Error with id `{formation_id}`: `{err}`',)
        raise


async def http_get(url):
    loop = asyncio.get_event_loop()
    return await loop.run_in_executor(None, requests.get, url)


def populate_formation_from_bytes(data, content):
    content = content.replace(b' xmlns="http://www.lheo.org/2.2"', b'')
    tree = etree.fromstring(content)
    root = tree.find('offres/formation')
    if root is None:
        raise ValueError('No formation found')

    # TODO: move xpath definitions in the schema?
    data['formation.eligible_copanef'] = bool(root.xpath(
        '//extras[@info="eligibilite-cpf"]/extra[@info="france-entiere"][text()="1"]/../extra[@info="inter-branche"][text()="1"]'
    ))
    data['formation.codes_naf'] = set(root.xpath(
        '//extras[@info="eligibilite-cpf"]/extra[@info="branche"]/child::text()'))
    data['formation.regions'] = set(root.xpath(
        '//extras[@info="eligibilite-cpf"]/extra[@info="region"]/child::text()'))
    data['formation.codes_formacode'] = root.xpath('//domaine-formation/code-FORMACODE/child::text()')
    data['formation.niveau_sortie'] = root.xpath('number(//code-niveau-sortie/child::text())')
    data['formation.codes_certifinfo'] = [
        int(c) for c in root.xpath('//certification/code-CERTIFINFO/child::text()')]
    data['formation.domaines_formacode'] = set([
        c[:3] for c in data['formation.codes_formacode']])
    data['formation.foad'] = bool(
        root.xpath('//modalites-enseignement[text()="2"]'))
    data['formation.toeic'] = bool(
        {'constante.codes_certifinfo_toeic'} & set(data['formation.codes_certifinfo']))
    data['formation.bulats'] = bool(
        {'constante.codes_certifinfo_bulats'} & set(data['formation.codes_certifinfo']))
    data['formation.caces'] = bool(
        {'constante.codes_certifinfo_caces'} & set(data['formation.codes_certifinfo']))
    data['formation.bec'] = bool(
        {'constante.codes_certifinfo_bec'} & set(data['formation.codes_certifinfo']))
    data['formation.bilan_de_competences'] = bool(
        {'constante.codes_certifinfo_bilan_de_competences'} & set(data['formation.codes_certifinfo']))
    data['formation.permis_b'] = bool(
        {'constante.codes_certifinfo_permis_b'} & set(data['formation.codes_certifinfo']))


def financement_to_organisme(data, financement):
    type_ = financement['genre']
    if type_ == 'CPF':
        organisme = load_organisme(data['beneficiaire.entreprise.opca'])
    elif type_ == 'CIF':
        organisme = load_organisme(data['beneficiaire.entreprise.opacif'])
    else:
        raise NotImplementedError(f'Unknown financement type {type_}')
    financement['organisme'] = organisme
    data['financement.organisme.nom'] = organisme['nom']


def load_organisme(name):
    # TODO load organisme details (email, phone…)
    return {
        'nom': name
    }


def compute_prise_en_charge(data, financement):
    Rule.process(PRISE_EN_CHARGE, data)
    heures = data['beneficiaire.solde_cpf']
    if ('financement.plafond_horaire' in data
       and int(data['financement.plafond_horaire']) < heures):
        heures = int(data['financement.plafond_horaire'])
    prise_en_charge = int(data['financement.taux_horaire']) * heures
    if ('financement.plafond_financier' in data
       and int(data['financement.plafond_financier']) < prise_en_charge):
        prise_en_charge = int(data['financement.plafond_financier'])
    financement['prise_en_charge'] = prise_en_charge


def compute_remuneration(data, financement):
    Rule.process(REMUNERATION, data)
    # Outside of CPF, remuneration is not defined (for now)
    financement['remuneration'] = data['financement.remuneration']


def populate_financement(data, financement):
    if not financement.get('eligible'):
        return
    data['financement.nom'] = financement['nom']
    financement_to_organisme(data, financement)
    compute_prise_en_charge(data, financement)
    compute_remuneration(data, financement)
