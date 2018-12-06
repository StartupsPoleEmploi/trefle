import json
import hashlib
import hmac
import datetime
from urllib.parse import urlencode

from . import config  # allow to monkeypatch test
from .config import (CONSTANTS, ELIGIBILITE_URL, INTERCARIF_URL, LABELS, ORGANISMES,
                     RULES, SCHEMA, Organisme)

from .exceptions import DataError, UpstreamError, NoDataError
from .helpers import (
    diff_month,
    diff_week,
    fold_name,
    http_get,
    insee_commune_to_departement,
    insee_departement_to_region,
    calculate_age,
    json_path,
)
from .rules import Rule
from .validators import format_naf


def extrapolate_context(context):
    context.update(CONSTANTS)
    insee_commune_to_departement(context, 'beneficiaire.commune',
                                 'beneficiaire.departement')
    insee_commune_to_departement(context, 'beneficiaire.entreprise.commune',
                                 'beneficiaire.entreprise.departement')
    # FIXME remove me when LBF sends INSEE code even for DE.
    # (this is a postcode).
    insee_commune_to_departement(
        context, "beneficiaire.location", "beneficiaire.departement"
    )
    insee_departement_to_region(
        context, "beneficiaire.entreprise.departement", "beneficiaire.entreprise.region"
    )
    insee_departement_to_region(
        context, "beneficiaire.departement", "beneficiaire.region"
    )
    if context.get("beneficiaire.allocation_type") == "non":
        del context["beneficiaire.allocation_type"]
    if "beneficiaire.age" not in context and context.get("beneficiaire.naissance"):
        context["beneficiaire.age"] = calculate_age(context["beneficiaire.naissance"])

    _extrapolate_formation_context(context)


def _extrapolate_formation_context(context):
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
    if context.get('formation.codes_financeur', set()) & {0, 5, 10}:
        context['formation.codes_financeur'].discard(16)

    context['formation.intitule_norme'] = fold_name(
        context.get('formation.intitule', ''))

    if context.get('formation.heures_centre') is None:
        total = context.get('formation.heures')
        entreprise = context.get('formation.heures_entreprise')
        if total and entreprise:
            context['formation.heures_centre'] = total - entreprise

    insee_commune_to_departement(
        context, "formation.commune", "formation.departement"
    )

    insee_departement_to_region(
        context, "formation.departement", "formation.region"
    )

    # TODO logic to move in LBF catalog
    old_new_region = {'26': '27', '43': '27', '23': '28', '25': '28',
                      '31': '32', '22': '32', '41': '44', '42': '44',
                      '21': '44', '72': '75', '54': '75', '74': '75',
                      '73': '76', '91': '76', '82': '84', '83': '84'}

    if context.get('formation.region') in old_new_region:
        context["formation.region"] = old_new_region[context["formation.region"]]

    context["formation.regions_coparef"] = set(
            old_new_region.get(r, r)
            for r in context.get("formation.regions_coparef", []))


def build_catalog_url(formation_id):
    now = datetime.datetime.utcnow().replace(microsecond=0).isoformat()
    # (alphabetical) order of parameters is important.
    params = (
        ('user', config.LBF_USER),
        ('uid', formation_id),
        ('timestamp', now),
    )
    query_string = urlencode(params)
    signature = hmac.new(config.LBF_KEY.encode(), query_string.encode(), hashlib.md5).hexdigest()
    return f"{config.LBF_URL}?{query_string}&signature={signature}"


async def get_formation_json(formation_id):
    url = build_catalog_url(formation_id)
    try:
        data = (await http_get(url)).json()
    except ValueError as err:
        err.args = ('Invalid formation data',)
        raise

    if not data:
        raise ValueError('No formation found')
    return data


async def populate_formation(context):
    if not context.get('formation.numero'):
        return

    formation_id = context['formation.numero']

    try:
        data = await get_formation_json(formation_id)
        await populate_formation_from_json(context, data)
    except ValueError as err:
        # Give more context.
        raise DataError(f'Error with id `{formation_id}`: `{err}`')


async def populate_formation_from_json(context, content):
    # Doc for leoh: http://lheo.gouv.fr/langage
    # TODO: deal with action or session optional ids.

    for key, schema in SCHEMA.items():
        if schema.get("source") == "catalogue" and schema.get("path"):
            value = json_path(schema["path"], content)
            if value in ('', [], None):  # Empty resultset.
                continue
            try:
                context[key] = value
            except DataError as err:
                print(f'Warning: invalid data while processing {key} with {value} ({err})')
                continue


def preprocess(context):
    for rule in RULES['normalisation.rules']:
        Rule.process(rule, context)


def load_organisme_contact_details(context, financement):
    nom = context.get('financement.organisme.agence',
                      context.get('financement.organisme.nom'))
    if nom not in ORGANISMES:  # A DE financement?
        return
    financement.organisme = Organisme(ORGANISMES[nom])


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
    financement.reste_a_charge = reste_a_charge
    prise_en_charge = context.get('financement.prise_en_charge', None)
    if not prise_en_charge:
        if prix_horaire > 0:  # We can deal with a real prise_en_charge.
            if plafond_prix_horaire and plafond_prix_horaire < prix_horaire:
                prix_horaire = plafond_prix_horaire
            prise_en_charge = prix_horaire * heures
            if plafond_financier and plafond_financier < prise_en_charge:
                prise_en_charge = plafond_financier
            prise_en_charge = prise_en_charge - reste_a_charge
            financement.prix_horaire = prix_horaire
    financement.prise_en_charge = prise_en_charge
    # If we have heures AND plafond_prix_horaire we have the real plafond.
    plafond_effectif = heures * plafond_prix_horaire
    if not plafond_financier or (plafond_effectif
                                 and plafond_effectif < plafond_financier):
        plafond_financier = heures * plafond_prix_horaire
    financement.plafond_prix_horaire = plafond_prix_horaire
    financement.plafond_prise_en_charge = plafond_financier - reste_a_charge
    # FIXME: should we define default remuneration in common rules instead?
    remuneration = context.get('financement.remuneration', 0)
    plafond_remuneration = context.get('financement.plafond_remuneration', 0)
    if plafond_remuneration and plafond_remuneration < remuneration:
        remuneration = plafond_remuneration
    financement.remuneration = remuneration
    financement.indemnite_conges_payes = indemnite_conges_payes
    financement.heures = heures
    keys = ['remuneration_texte', 'prise_en_charge_texte', 'demarches', 'rff',
            'description', 'remuneration_annee_2', 'remuneration_annee_3',
            'intitule', 'en_savoir_plus']
    for key in keys:
        name = f'financement.{key}'
        if name in context:
            financement[key] = context[name]
    if financement.get('demarches'):
        financement.demarches = financement.demarches.replace('⏎', '\n')
    if financement.get('rff'):
        financement.fin_remuneration = context.get(
            'beneficiaire.fin_allocation')
        financement.debut_rff = (financement.fin_remuneration
                                 + datetime.timedelta(days=1))
        financement.fin_rff = context.get('formation.fin')


def get_root_rule(context, financement):
    name = financement.racine
    if name.endswith('.rules'):
        return name
    name = LABELS.get(name, name)
    if name in SCHEMA:
        schema = SCHEMA[name]
        name = context.get(name)
        # Rules have human friendly names, so revert the enum logic here
        enum = schema.get('enum')
        if enum:
            name = enum.get(name, name)
    if name:
        return f'{name}.rules'


def check_financement(context, financement):
    statuses = []
    financement.explain = []
    context['financement.intitule'] = financement.intitule
    context['financement.tags'] = financement.tags
    context['financement.eligible'] = False
    rule_name = get_root_rule(context, financement)
    if not rule_name:
        return
    for rule in RULES[rule_name]:
        statuses.extend(Rule.process(rule, context))
    financement.explain = statuses
    if context['financement.eligible']:
        compute_modalites(context, financement)
        load_organisme_contact_details(context, financement)
        financement.format()
    financement.eligible = context['financement.eligible']
    for key in list(financement.keys()):
        if key == 'organisme':
            continue  # reference
        name = f'financement.{key}'
        if name not in SCHEMA or not SCHEMA[name].get('public'):
            del financement[key]
