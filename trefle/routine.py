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
    return data


def add_constants(context):
    context.update(CONSTANTS)


def preload_financements(context):
    # Copy.
    context['financements'] = {k: dict(v) for k, v in FINANCEMENTS.items()}


def idcc_to_organismes(context):
    key = 'beneficiaire.entreprise.idcc'
    idcc = context[key]
    if idcc not in IDCC:
        # TODO move this check to validators
        raise ValueError({key: f"Valeur d'IDCC inconnue: `{idcc}`"})
    context['beneficiaire.entreprise.opca'] = IDCC[idcc]['OPCA']
    context['beneficiaire.entreprise.opacif'] = IDCC[idcc]['OPACIF']


def insee_commune_to_region(context):
    if 'beneficiaire.entreprise.region' in context:
        return
    key = 'beneficiaire.entreprise.commune'
    if key not in context:
        return
    dep = context[key][:2]
    if dep not in DEP_TO_REG:
        raise ValueError({key: f'Valeur invalide: `{context[key]}`'})
    context['beneficiaire.entreprise.region'] = DEP_TO_REG[dep]


def check_eligibilite(context):
    Rule.process(ELIGIBILITE, context)


async def populate_formation(context):
    if not context.get('formation.numero'):
        return

    formation_id = context['formation.numero']
    response = await http_get(f'{INTERCARIF_URL}?num={formation_id}')
    if response.status_code >= 500:
        raise UpstreamError(f"UPSTREAM_ERROR: {response.status_code}")

    try:
        populate_formation_from_bytes(context, response.content)
    except ValueError as err:
        # Give more context.
        err.args = (f'Error with id `{formation_id}`: `{err}`',)
        raise


async def http_get(url):
    loop = asyncio.get_event_loop()
    return await loop.run_in_executor(None, requests.get, url)


def populate_formation_from_bytes(context, content):
    # Doc for leoh: http://lheo.gouv.fr/langage
    # TODO: deal with action or session optional ids.
    content = content.replace(b' xmlns="http://www.lheo.org/2.2"', b'')
    tree = etree.fromstring(content)
    root = tree.find('offres/formation')
    if root is None:
        raise ValueError('No formation found')

    # TODO: move xpath definitions in the schema?
    context['formation.eligible_copanef'] = bool(root.xpath(
        '//extras[@info="eligibilite-cpf"]/extra[@info="france-entiere"][text()="1"]/../extra[@info="inter-branche"][text()="1"]'
    ))
    context['formation.codes_naf'] = set(root.xpath(
        '//extras[@info="eligibilite-cpf"]/extra[@info="branche"]/child::text()'))
    context['formation.regions_coparef'] = set(root.xpath(
        '//extras[@info="eligibilite-cpf"]/extra[@info="region"]/child::text()'))
    context['formation.codes_formacode'] = root.xpath('//domaine-formation/code-FORMACODE/child::text()')
    context['formation.niveau_sortie'] = root.xpath('number(//code-niveau-sortie/child::text())')
    context['formation.heures'] = root.xpath('number(//nombre-heures-total/child::text())')
    try:
        context['formation.prix_horaire'] = float(root.xpath('//prix-horaire-TTC/child::text()'))
    except (TypeError, ValueError):
        pass
    try:
        context['formation.prix_total'] = float(root.xpath('//prix-total-TTC/child::text()'))
    except (TypeError, ValueError):
        pass
    context['formation.codes_certifinfo'] = [
        int(c) for c in root.xpath('//certification/code-CERTIFINFO/child::text()')]
    context['formation.domaines_formacode'] = set([
        c[:3] for c in context['formation.codes_formacode']])
    context['formation.foad'] = bool(
        root.xpath('//modalites-enseignement[text()="2"]'))
    context['formation.toeic'] = bool(set(context['constante.codes_certifinfo_toeic']) & set(context['formation.codes_certifinfo']))
    context['formation.bulats'] = bool(set(context['constante.codes_certifinfo_bulats']) & set(context['formation.codes_certifinfo']))
    context['formation.caces'] = bool(set(context['constante.codes_certifinfo_caces']) & set(context['formation.codes_certifinfo']))
    context['formation.bec'] = bool(set(context['constante.codes_certifinfo_bec']) & set(context['formation.codes_certifinfo']))
    context['formation.bilan_de_competences'] = bool(set(context['constante.codes_certifinfo_bilan_de_competences']) & set(context['formation.codes_certifinfo']))
    context['formation.permis_b'] = bool(set(context['constante.codes_certifinfo_permis_b']) & set(context['formation.codes_certifinfo']))
    context['formation.codes_financeur'] = set([
        int(c) for c in root.xpath('//organisme-financeur/code-financeur/child::text()')])
    # http://lheo.gouv.fr/langage#dict-AIS
    context['formation.qualifiante'] = root.xpath('number(//objectif-general-formation/child::text())') in [6, 7]
    # Compute duration in months.
    debut = datetime.strptime(root.xpath('//periode/debut/child::text()')[0],
                              '%Y%m%d')
    fin = datetime.strptime(
        root.xpath('//periode/fin/child::text()')[0], '%Y%m%d')
    context['formation.mois'] = diff_month(debut, fin)


def financement_to_organisme(context, financement):
    tags = financement['tags']
    if 'CPF' in tags:
        nom = context['beneficiaire.entreprise.opca']
    elif 'CIF' in tags:
        nom = context['beneficiaire.entreprise.opacif']
    else:
        raise NotImplementedError(f'Unknown financement type {tags}')
    context['financement.organisme.nom'] = nom


def load_organisme_contact_details(context, financement):
    nom = context.get('financement.organisme.agence',
                      context['financement.organisme.nom'])
    organisme = load_organisme(nom)
    financement['organisme'] = organisme
    # Q&D way to display the organisme details on LBF.
    # TODO clean me.
    financement['demarches'] = financement['demarches'].format(**organisme)


def load_organisme(nom):
    data = {'nom': nom}
    data.update(ORGANISMES[nom])
    return data


def compute_modalites(context, financement):
    Rule.process(MODALITES, context)
    # TODO: HT vs TTC everywhere
    heures = context['formation.heures']
    heures = min(context['formation.heures'],
                 context.get('financement.plafond_horaire', heures))
    prix_horaire = context.get('formation.prix_horaire', 0)
    plafond_financier = context.get('financement.plafond_financier')
    reste_a_charge = context.get('financement.reste_a_charge', 0)
    plafond_prix_horaire = context.get('financement.plafond_prix_horaire', 0)
    financement['reste_a_charge'] = reste_a_charge
    if prix_horaire > 0:  # We can deal with a real prise_en_charge.
        if plafond_prix_horaire and plafond_prix_horaire < prix_horaire:
            prix_horaire = plafond_prix_horaire
        prise_en_charge = prix_horaire * heures
        if plafond_financier and plafond_financier < prise_en_charge:
            prise_en_charge = plafond_financier
        financement['prise_en_charge'] = prise_en_charge - reste_a_charge
        financement['prix_horaire'] = prix_horaire
    else:
        financement['prise_en_charge'] = None  # Means unknown.
    if not plafond_financier:
        plafond_financier = heures * plafond_prix_horaire
    financement['plafond_prise_en_charge'] = plafond_financier - reste_a_charge
    # FIXME: should we define default remuneration in common rules instead?
    remuneration = context.get('financement.remuneration', 0)
    plafond_remuneration = context.get('financement.plafond_remuneration', 0)
    if plafond_remuneration and plafond_remuneration < remuneration:
        remuneration = plafond_remuneration
    financement['remuneration'] = remuneration
    if not remuneration and 'hors temps de travail' in financement['tags']:
        financement['remuneration_details'] = \
            context['constante.wording.remuneration_hors_temps_de_travail']


def populate_financement(context, financement):
    if not financement.get('eligible'):
        return
    # TODO: use flatten() instead?
    context['financement.nom'] = financement['nom']
    context['financement.tags'] = financement['tags']
    financement_to_organisme(context, financement)
    compute_modalites(context, financement)
    load_organisme_contact_details(context, financement)
