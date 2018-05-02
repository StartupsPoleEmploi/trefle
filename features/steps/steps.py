from behave import given, when, then, use_step_matcher

from trefle.core import simulate
from trefle.rules import LABELS, VARIABLES

use_step_matcher('re')


def revert(d):
    """Revert a dict."""
    return {v: k for k, v in d.items()}


@given('un bénéficiaire et une formation')
def setup(context):
    context.data = {}


@given(r"(?:le |la |l')(?P<label>.+) vaut «?(?P<value>[^»]+)»?")
def given_set_value(context, label, value):
    key = LABELS[label]
    schema = VARIABLES[key]
    if 'enum' in schema:
        # Allow to use enum label in scenario description.
        labels = revert(schema['enum'])
        value = labels[value]
    context.data[key] = value


@given(r"c'est une formation éligible région «(?P<label>.+)»")
def given_set_coparef(context, label):
    regions = revert(VARIABLES['beneficiaire.entreprise.region']['enum'])
    ref = regions[label]
    context.data['formation.regions_coparef'] = [ref]


@given(r"c'est une? (?P<key>.+)")
def given_set_true(context, key):
    context.data[LABELS[key]] = True


@given(r"ce n'est pas une? (?P<key>.+)")
def given_set_false(context, key):
    context.data[LABELS[key]] = False


@when('je demande un calcul de financement')
def when_simulate(context):
    context.passed = [f for f in simulate(**context.data) if f.get('eligible')]


@when(r'je sélectionne le financement «(?P<nom>.+)»')
def when_select_one(context, nom):
    assert context.passed, "No result found"
    for result in context.passed:
        if result['nom'] == nom:
            context.result = result
            break
    else:
        raise AssertionError(f'No result found with name {nom}')


@then(r"l'organisme tutelle est «(?P<name>.+)»")
def then_check_organisme(context, name):
    assert context.result['organisme']['nom'] == name,\
        f'{context.result["organisme"]["nom"]} != {name}'


@then(r'le montant de prise en charge vaut (?P<value>\d+)')
def then_check_prise_en_charge(context, value):
    assert context.result['prise_en_charge'] == int(value),\
        f'{context.result["prise_en_charge"]} != {value}'


@then(r'la rémunération vaut (?P<value>\d+)')
def then_check_remuneration(context, value):
    assert context.result['remuneration'] == int(value),\
        f'{context.result["remuneration"]} != {value}'



@then("aucun financement n'est proposé")
def then_no_results(context):
    assert not context.passed, f"Results found: {context.passed}"
