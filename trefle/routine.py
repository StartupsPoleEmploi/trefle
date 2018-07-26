from lxml import etree

from .config import (CONSTANTS, DEP_TO_REG, ELIGIBILITE_URL, IDCC,
                     INTERCARIF_URL, ORGANISMES, PREPROCESS, RULES, SCHEMA)
from .exceptions import UpstreamError
from .helpers import diff_month, diff_week, http_get
from .rules import Rule
from .validators import format_naf, validate_format


def add_constants(context):
    context.update(CONSTANTS)


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
    # Weird hack: Intercarif adds the `16` code in some situations and we need
    # to remove it otherwise the formation is unavailable (`16` is a code
    # financeur collectif).
    if context['formation.codes_financeur'] & {0, 5, 10}:
        context['formation.codes_financeur'].discard(16)


def preprocess(context):
    for rules in PREPROCESS.values():
        Rule.process(rules, context)


def financement_to_organisme(context, financement):
    tags = financement['tags']
    # TODO: add an "organisme_type" key in financements.yml instead?
    if {'CPF', 'période de professionnalisation', 'plan de formation'} & set(tags):
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


def check_financement(context, financement):
    # TODO: use flatten() instead?
    context['status'] = []
    context['financement.nom'] = financement['nom']
    context['financement.tags'] = financement['tags']
    context['financement.eligible'] = False
    financement_to_organisme(context, financement)
    id_ = f'rules/{financement["tags"][0]}.rules'
    status = Rule.process(RULES[id_], context)
    financement['status'] = [status] + context['status']
    if context['financement.eligible']:
        compute_modalites(context, financement)
        load_organisme_contact_details(context, financement)
    financement['eligible'] = context['financement.eligible']
