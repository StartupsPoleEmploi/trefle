from behave import given, when, then, use_step_matcher
from behave.api.async_step import async_run_until_complete

from trefle.core import simulate
from trefle.rules import LABELS, SCHEMA

use_step_matcher('re')


def revert(d):
    """Revert a dict."""
    return {v: k for k, v in d.items()}


@given('un bénéficiaire et une formation')
def setup(context):
    context.data = {}


@given(r"(?:les? |la |l')(?P<label>.+) (?:est|vaut|valent) «?(?P<value>[^»]+)»?")
def given_set_value(context, label, value):
    key = LABELS[label]
    schema = SCHEMA[key]
    if 'enum' in schema:
        # Allow to use enum label in scenario description.
        labels = revert(schema['enum'])
        value = str(labels[value])
    if value.startswith('['):
        value = value[1:-1].split(',')  # TODO: Merge with LazyValue?
        if (schema['type'] == 'array'
           and schema['items']['type'] == 'integer'):
            value = [int(v) for v in value]
    context.data[key] = value


@given(r"c'est une formation éligible région «(?P<label>.+)»")
def given_set_coparef(context, label):
    regions = revert(SCHEMA['beneficiaire.entreprise.region']['enum'])
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
    context.passed = [f for f in await simulate(context.data) if f['eligible']]


@then(r"il y a (?P<expected>\d+) financements? proposés?")
def then_check_count(context, expected):
    found = len(context.passed)
    assert found == int(expected), f'Found {found}'


@then(r"le financement «(?P<nom>.+)» n'est pas proposé")
def then_check_missing(context, nom):
    for financement in context.passed:
        if financement['nom'] == nom:
            raise AssertionError(f'{nom} was found')


@when(r'je sélectionne le financement «(?P<nom>.+)»')
def when_select_one(context, nom):
    assert context.passed, "No result found"
    for result in context.passed:
        if result['nom'] == nom:
            context.result = result
            break
    else:
        raise AssertionError(f'No result found with name {nom}')


@then(r"l'organisme à contacter est «(?P<name>.+)»")
def then_check_organisme(context, name):
    assert context.result['organisme']['nom'] == name,\
        f'{context.result["organisme"]["nom"]} != {name}'


@then(r"(?:le |la |l')(?P<label>.*) vaut (?P<value>[\d\.]+)")
def then_check_output(context, label, value):
    key = LABELS[label][12:]  # Remove "financement." namespace.
    assert context.result[key] == float(value),\
        f'{context.result[key]} != {value}'


@then("aucun financement n'est proposé")
def then_no_results(context):
    assert not context.passed, f"Results found: {context.passed}"
