import asyncio
from pathlib import Path
from datetime import datetime

import requests
import yaml
from lxml import etree

from .config import (CONSTANTS, DEP_TO_REG, ELIGIBILITE, FINANCEMENTS,
                     INTERCARIF_URL, MODALITES, ORGANISMES)
from .exceptions import UpstreamError
from .rules import Rule

with (Path(__file__).parent / 'config/idcc.yml').open() as f:
    IDCC = yaml.safe_load(f.read())


def diff_month(start, end):
    return ((end.year - start.year) * 12
            + (end.month - start.month)
            + round((end.day - start.day) / 30))


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
    idcc = data[key]
    if idcc not in IDCC:
        # TODO move this check to validators
        raise ValueError({key: f"Valeur d'IDCC inconnue: `{idcc}`"})
    data['beneficiaire.entreprise.opca'] = IDCC[idcc]['OPCA']
    data['beneficiaire.entreprise.opacif'] = IDCC[idcc]['OPACIF']


def insee_commune_to_region(data):
    if 'beneficiaire.entreprise.region' in data:
        return
    key = 'beneficiaire.entreprise.commune'
    if key not in data:
        return
    dep = data[key][:2]
    if dep not in DEP_TO_REG:
        raise ValueError({key: f'Valeur invalide: `{data[key]}`'})
    data['beneficiaire.entreprise.region'] = DEP_TO_REG[dep]


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
    # Doc for leoh: http://lheo.gouv.fr/langage
    # TODO: deal with action or session optional ids.
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
    data['formation.regions_coparef'] = set(root.xpath(
        '//extras[@info="eligibilite-cpf"]/extra[@info="region"]/child::text()'))
    data['formation.codes_formacode'] = root.xpath('//domaine-formation/code-FORMACODE/child::text()')
    data['formation.niveau_sortie'] = root.xpath('number(//code-niveau-sortie/child::text())')
    data['formation.heures'] = root.xpath('number(//nombre-heures-total/child::text())')
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
    data['formation.bilan_de_competences'] = (
        'constante.codes_certifinfo_bilan_de_competences'
        in set(data['formation.codes_certifinfo']))
    data['formation.permis_b'] = ('constante.codes_certifinfo_permis_b'
                                  in set(data['formation.codes_certifinfo']))
    data['formation.codes_financeur'] = set([
        int(c) for c in root.xpath('//organisme-financeur/code-financeur/child::text()')])

    # Compute duration in months.
    debut = datetime.strptime(root.xpath('//periode/debut/child::text()')[0], '%Y%m%d')
    fin = datetime.strptime(
        root.xpath('//periode/fin/child::text()')[0], '%Y%m%d')
    data['formation.mois'] = diff_month(debut, fin)


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
    # Q&D way to display the organisme details on LBF.
    # TODO clean me.
    financement['demarches'] = financement['demarches'].format(**organisme)


def load_organisme(name):
    # TODO load organisme details (email, phone…)
    data = {'nom': name}
    data.update(ORGANISMES[name])
    return data


def compute_modalites(data, financement):
    # TODO: return more details (taux horaire, plafond, etc.)
    Rule.process(MODALITES, data)
    heures = data['beneficiaire.solde_cpf']
    if ('financement.plafond_horaire' in data
       and int(data['financement.plafond_horaire']) < heures):
        heures = int(data['financement.plafond_horaire'])
    # TODO: deal with financement.taux_horaire empty
    prise_en_charge = int(data.get('financement.taux_horaire', 0)) * heures
    if ('financement.plafond_financier' in data
       and int(data['financement.plafond_financier']) < prise_en_charge):
        prise_en_charge = int(data['financement.plafond_financier'])
    financement['prise_en_charge'] = prise_en_charge
    # Outside of CPF, remuneration is not defined (for now)
    financement['remuneration'] = data['financement.remuneration']


def populate_financement(data, financement):
    if not financement.get('eligible'):
        return
    data['financement.nom'] = financement['nom']
    financement_to_organisme(data, financement)
    compute_modalites(data, financement)
