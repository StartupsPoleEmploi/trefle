import asyncio
from math import ceil

import requests
from lxml import etree

from .config import (CONSTANTS, DEP_TO_REG, ELIGIBILITE, ELIGIBILITE_URL,
                     FINANCEMENTS, IDCC, INTERCARIF_URL, MODALITES, ORGANISMES,
                     SCHEMA)
from .exceptions import UpstreamError
from .rules import Rule
from .validators import format_naf, validate_format


# TODO: move to utils.py?
def diff_month(start, end):
    return ((end.year - start.year) * 12
            + (end.month - start.month)
            + round((end.day - start.day) / 30))


def diff_week(start, end):
    # Ceil: we count a week even for a day
    # +1: the end bound is inclusive
    return ceil(((end - start).days + 1) / 7)


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
    idcc = context['beneficiaire.entreprise.idcc']
    # Allow to force value in input data.
    if 'beneficiaire.entreprise.opca' not in context:
        context['beneficiaire.entreprise.opca'] = IDCC[idcc]['OPCA']
    if 'beneficiaire.entreprise.opacif' not in context:
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


async def get_formation_xml(formation_id):
    return (await http_get(f'{INTERCARIF_URL}?num={formation_id}')).content


async def populate_formation(context):
    if not context.get('formation.numero'):
        return

    formation_id = context['formation.numero']
    xml = await get_formation_xml(formation_id)

    try:
        await populate_formation_from_bytes(context, xml)
    except ValueError as err:
        # Give more context.
        err.args = (f'Error with id `{formation_id}`: `{err}`',)
        raise


async def http_get(url):
    loop = asyncio.get_event_loop()
    response = await loop.run_in_executor(None, requests.get, url)
    if response.status_code >= 500:
        raise UpstreamError(f"UPSTREAM_ERROR: {url} {response.status_code}")
    return response


async def retrieve_codes_naf(ids):
    params = ''.join(f'&id[]={id}' for id in ids)
    url = f'{ELIGIBILITE_URL}{params}'
    response = await http_get(url)
    tree = etree.fromstring(response.content)
    return set(format_naf(c) for c in tree.xpath('//branche/child::text()'))


async def populate_formation_from_bytes(context, content):
    # Doc for leoh: http://lheo.gouv.fr/langage
    # TODO: deal with action or session optional ids.
    content = content.replace(b' xmlns="http://www.lheo.org/2.2"', b'')
    tree = etree.fromstring(content)
    root = tree.find('offres/formation')
    if root is None:
        raise ValueError('No formation found')

    for key, schema in SCHEMA.items():
        if schema.get('source') == 'catalogue' and schema.get('xpath'):
            value = root.xpath(schema['xpath'])
            try:
                value = validate_format(schema, value)
            except ValueError:
                if 'default' in schema:
                    value = schema['default']
                else:
                    continue  # Should we raise/validate required?
            if schema.get('format') == 'set':
                value = set(value)
            context[key] = value

    if not context['formation.codes_naf']:
        ids = set(root.xpath('//extras[@info="eligibilite-cpf"]/extra[@info="france-entiere"][text()="1"]/../extra[@info="inter-branche"][text()="0"]/../@numero'))
        if ids:
            context['formation.codes_naf'] = await retrieve_codes_naf(ids)

    extrapolate_formation_context(context)


def extrapolate_formation_context(context):
    # CERTIFINFO matches
    code_certifinfo = context['formation.code_certifinfo']
    context['formation.toeic'] = (
        code_certifinfo in context['constante.codes_toeic'])
    context['formation.bulats'] = (
        code_certifinfo in context['constante.codes_bulats'])
    context['formation.caces'] = (
        code_certifinfo in context['constante.codes_caces'])
    context['formation.bec'] = (
        code_certifinfo in context['constante.codes_bec'])
    context['formation.bilan_de_competences'] = (
        code_certifinfo in context['constante.codes_bilan_de_competences'])
    context['formation.permis_b'] = (
        code_certifinfo in context['constante.codes_permis_b'])

    # CPF subsets
    codes_cpf = context['formation.codes_cpf']
    context['formation.clea'] = bool(
        set(context['constante.codes_cpf_clea']) & codes_cpf)
    context['formation.vae'] = bool(
        set(context['constante.codes_cpf_vae']) & codes_cpf)

    # http://lheo.gouv.fr/langage#dict-AIS
    context['formation.qualifiante'] = (
        context['formation.objectif_general_formation'] in [6, 7])

    # Compute durations.
    if 'formation.debut' in context and 'formation.fin' in context:
        mois = diff_month(context['formation.debut'], context['formation.fin'])
        semaines = diff_week(context['formation.debut'],
                             context['formation.fin'])
        duree_hebdo = round(context['formation.heures'] / semaines)
    else:
        mois = SCHEMA['formation.mois']['default']
        semaines = SCHEMA['formation.semaines']['default']
        duree_hebdo = SCHEMA['formation.duree_hebdomadaire']['default']
    context['formation.semaines'] = semaines
    context['formation.mois'] = mois
    context['formation.duree_hebdomadaire'] = duree_hebdo


def financement_to_organisme(context, financement):
    tags = financement['tags']
    # TODO: add an "organisme_type" key in financements.yml instead?
    if 'CPF' in tags or "période de professionnalisation" in tags:
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
    return ORGANISMES[nom]


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
    prise_en_charge = context.get('financement.prise_en_charge', None)
    if not prise_en_charge:
        if prix_horaire > 0:  # We can deal with a real prise_en_charge.
            if plafond_prix_horaire and plafond_prix_horaire < prix_horaire:
                prix_horaire = plafond_prix_horaire
            prise_en_charge = prix_horaire * heures
            if plafond_financier and plafond_financier < prise_en_charge:
                prise_en_charge = plafond_financier
            prise_en_charge = prise_en_charge - reste_a_charge
            financement['prix_horaire'] = prix_horaire
    financement['prise_en_charge'] = prise_en_charge
    # If we have heures AND plafond_prix_horaire we have the real plafond.
    plafond_effectif = heures * plafond_prix_horaire
    if not plafond_financier or (plafond_effectif
                                 and plafond_effectif < plafond_financier):
        plafond_financier = heures * plafond_prix_horaire
    financement['plafond_prix_horaire'] = plafond_prix_horaire
    financement['plafond_prise_en_charge'] = plafond_financier - reste_a_charge
    # FIXME: should we define default remuneration in common rules instead?
    remuneration = context.get('financement.remuneration', 0)
    plafond_remuneration = context.get('financement.plafond_remuneration', 0)
    if plafond_remuneration and plafond_remuneration < remuneration:
        remuneration = plafond_remuneration
    financement['remuneration'] = remuneration


def populate_financement(context, financement):
    if not financement.get('eligible'):
        return
    # TODO: use flatten() instead?
    context['financement.nom'] = financement['nom']
    context['financement.tags'] = financement['tags']
    financement_to_organisme(context, financement)
    compute_modalites(context, financement)
    load_organisme_contact_details(context, financement)
