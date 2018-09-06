from datetime import timedelta

from lxml import etree

from .config import (CONSTANTS, ELIGIBILITE_URL, INTERCARIF_URL, ORGANISMES,
                     RULES, SCHEMA)
from .exceptions import DataError, UpstreamError
from .helpers import (diff_month, diff_week, http_get,
                      insee_commune_to_departement, insee_commune_to_region)
from .rules import Rule
from .validators import format_naf


def extrapolate_context(context):
    context.update(CONSTANTS)
    insee_commune_to_region(context, 'beneficiaire.entreprise.commune',
                            'beneficiaire.entreprise.region')
    insee_commune_to_region(context, 'beneficiaire.commune',
                            'beneficiaire.region')
    insee_commune_to_departement(context, 'beneficiaire.commune',
                                 'beneficiaire.departement')
    # FIXME remove me when LBF sends INSEE code even for DE.
    # (this is a postcode).
    insee_commune_to_region(context, 'beneficiaire.location',
                            'beneficiaire.region')
    if context.get('beneficiaire.allocation_type') == 'non':
        del context['beneficiaire.allocation_type']


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
        raise DataError(f'Error with id `{formation_id}`: `{err}`')


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
    try:
        tree = etree.fromstring(content)
    except etree.XMLSyntaxError:
        raise UpstreamError('UPSTREAM_ERROR: Invalid INTERCARIF XML')
    root = tree.find('offres/formation')
    if root is None:
        raise ValueError('No formation found')

    for key, schema in SCHEMA.items():
        if schema.get('source') == 'catalogue' and schema.get('xpath'):
            value = root.xpath(schema['xpath'])
            if value == []:  # Empty resultset.
                value = None
            context[key] = value

    if not context['formation.codes_naf']:
        ids = set(root.xpath('//extras[@info="eligibilite-cpf"]/extra[@info="france-entiere"][text()="1"]/../extra[@info="inter-branche"][text()="0"]/../@numero'))
        if ids:
            context['formation.codes_naf'] = await retrieve_codes_naf(ids)

    extrapolate_formation_context(context)


def extrapolate_formation_context(context):
    # Compute durations.
    if 'formation.debut' in context and 'formation.fin' in context:
        mois = diff_month(context['formation.debut'], context['formation.fin'])
        semaines = diff_week(context['formation.debut'],
                             context['formation.fin'])
        context['formation.semaines'] = semaines
        context['formation.mois'] = mois
        if not context.get('formation.duree_hebdo'):
            context['formation.duree_hebdo'] = round(
                context['formation.heures'] / semaines)

    # Weird hack: Intercarif adds the `16` code in some situations and we need
    # to remove it otherwise the formation is unavailable (`16` is a code
    # financeur collectif).
    if context['formation.codes_financeur'] & {0, 5, 10}:
        context['formation.codes_financeur'].discard(16)


def preprocess(context):
    for rule in RULES['rules/preprocess.rules']:
        Rule.process(rule, context)


def load_organisme_contact_details(context, financement):
    nom = context.get('financement.organisme.agence',
                      context.get('financement.organisme.nom'))
    if nom not in ORGANISMES:  # A DE financement?
        return
    financement['organisme'] = ORGANISMES[nom]
    # Q&D way to display the organisme details on LBF.
    # TODO clean me.
    financement['demarches'] = financement['demarches'].format(
        **financement['organisme'])


def compute_modalites(context, financement):
    # TODO: HT vs TTC everywhere
    heures = context['formation.heures']
    heures = min(context['formation.heures'],
                 context.get('financement.plafond_horaire', heures))
    prix_horaire = context.get('formation.prix_horaire', 0)
    plafond_financier = context.get('financement.plafond_financier')
    reste_a_charge = context.get('financement.reste_a_charge', 0)
    plafond_prix_horaire = context.get('financement.plafond_prix_horaire', 0)
    indemnite_conges_payes = context.get('financement.indemnite_conges_payes',
                                         0)
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
    financement['indemnite_conges_payes'] = indemnite_conges_payes
    financement['heures'] = heures
    keys = ['remuneration_texte', 'prise_en_charge_texte', 'demarches', 'rff',
            'description', 'remuneration_annee_2', 'remuneration_annee_3']
    for key in keys:
        name = f'financement.{key}'
        if name in context:
            financement[key] = context[name]
    if financement.get('demarches'):
        financement['demarches'] = financement['demarches'].replace('⏎', '\n')
    if financement.get('rff'):
        financement['fin_remuneration'] = context.get(
            'beneficiaire.fin_allocation')
        financement['debut_rff'] = (financement['fin_remuneration']
                                    + timedelta(days=1))
        financement['fin_rff'] = context.get('formation.fin')


def check_financement(context, financement):
    statuses = []
    financement['status'] = []
    context['financement.nom'] = financement['nom']
    context['financement.tags'] = financement['tags']
    context['financement.eligible'] = False
    for rule in RULES[f'rules/{financement["rules"]}.rules']:
        status = Rule.process(rule, context)
        if status is not None:  # Root is a no_status condition.
            statuses.append(status)
    financement['status'] = statuses
    if context['financement.eligible']:
        compute_modalites(context, financement)
        load_organisme_contact_details(context, financement)
    financement['eligible'] = context['financement.eligible']
    for key in list(financement.keys()):
        if key == 'organisme':
            continue  # reference
        name = f'financement.{key}'
        if name not in SCHEMA or not SCHEMA[name].get('public'):
            del financement[key]
