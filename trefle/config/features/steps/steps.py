from behave import given, when, then, use_step_matcher
from behave.api.async_step import async_run_until_complete

from trefle import simulate, get_financements
from trefle.config import FINANCEMENTS
from trefle.helpers import revert_dict
from trefle.rules import LABELS, SCHEMA, Pointer

INTITULES_FINANCEMENTS = set(f["intitule"] for f in FINANCEMENTS)

use_step_matcher('re')


@given('un bénéficiaire et une formation')
def setup(context):
    context.data = {}


@given(r"(?:les? |la |l')(?P<label>.+) (?:est|vaut|valent) (?P<value>.+)")
def given_set_value(context, label, value):
    key = LABELS[label]
    pointer = Pointer(value)
    pointer.resolve_labels(key)
    context.data[key] = pointer.get({})


@given(r"c'est une formation éligible région «(?P<label>.+)»")
def given_set_coparef(context, label):
    regions = revert_dict(SCHEMA['beneficiaire.entreprise.region']['enum'])
    ref = regions[label]
    context.data['formation.regions_coparef'] = [ref]


@given(r"c'est une? (?P<key>.+)")
def given_set_true(context, key):
    context.data[LABELS[key]] = True


@given(r"ce n'est pas une? (?P<key>.+)")
def given_set_false(context, key):
    context.data[LABELS[key]] = False


@when('je demande un calcul de financement')
@async_run_until_complete
async def when_simulate(context):
    financements = get_financements()
    await simulate(context.data, financements)
    context.passed = [f for f in financements if f['eligible']]


@then(r"il y a (?P<expected>\d+) financements? proposés?")
def then_check_count(context, expected):
    found = len(context.passed)
    assert found == int(expected), f'Found {found}'


@then(r"le financement «(?P<intitule>.+)» n'est pas proposé")
def then_check_missing(context, intitule):
    if intitule not in INTITULES_FINANCEMENTS:
        raise ValueError(f'{intitule} is not a valid financement')
    for financement in context.passed:
        if financement['intitule'] == intitule:
            raise AssertionError(f'{intitule} was found')


@when(r'je sélectionne le financement «(?P<intitule>.+)»')
def when_select_one(context, intitule):
    assert context.passed, "No result found"
    for result in context.passed:
        if result['intitule'] == intitule:
            context.result = result
            # some rules change the intitule of financement so let's keep track of it for futur check
            INTITULES_FINANCEMENTS.add(result["intitule"])
            break
    else:
        raise AssertionError(f'No result found with name {intitule}')


@then(r"l'organisme à contacter est «(?P<name>.+)»")
def then_check_organisme(context, name):
    assert context.result['organisme']['nom'] == name,\
        f'{context.result["organisme"]["nom"]} != {name}'


@then(r"(?:le |la |l')(?P<label>.*) vaut (?P<value>.+)")
def then_check_output(context, label, value):
    value = Pointer(value).get({})
    key = LABELS[label][12:]  # Remove "financement." namespace.
    assert context.result[key] == value, (f'{context.result[key]} '
                                          f'({type(context.result[key])}) != '
                                          f'{value} ({type(value)})')


@then("aucun financement n'est proposé")
def then_no_results(context):
    assert not context.passed, f"Results found: {context.passed}"
