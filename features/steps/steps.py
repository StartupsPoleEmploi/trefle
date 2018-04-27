from behave import given, when, then, use_step_matcher

from trefle.core import simulate
from trefle.rules import LABELS

use_step_matcher('re')


@given('un bénéficiaire et une formation')
def setup(context):
    context.data = {}


@given("(?:le |la |l')(?P<key>.+) vaut (?P<value>.+)")
def given_set_value(context, key, value):
    context.data[LABELS[key]] = value


@given("c'est une? (?P<key>.+)")
def given_set_true(context, key):
    context.data[LABELS[key]] = True


@given("ce n'est pas une? (?P<key>.+)")
def given_set_false(context, key):
    context.data[LABELS[key]] = False


@when('je demande un calcul de financement')
def when_simulate(context):
    context.passed, _ = list(simulate(**context.data))


@when('je sélectionne le financement «(?P<nom>.+)»')
def when_select_one(context, nom):
    assert context.passed, "No result found"
    for result in context.passed:
        if result.nom == nom:
            context.result = result
            break
    else:
        raise AssertionError(f'No result found with name {nom}')


@then("l'organisme tutelle est «(?P<name>.+)»")
def then_check_organisme(context, name):
    assert context.result.organisme == name,\
        f'{context.result.organisme} != {name}'


@then(r'le montant de prise en charge vaut (?P<value>\d+)')
def then_check_prise_en_charge(context, value):
    assert context.result.prise_en_charge == int(value),\
        f'{context.result.prise_en_charge} != {value}'


@then(r'la rémunération vaut (?P<value>\d+)')
def then_check_remuneration(context, value):
    assert context.result.remuneration == int(value)


@then("aucun financement n'est proposé")
def then_no_results(context):
    assert not context.passed, f"Results found: {context.passed}"
