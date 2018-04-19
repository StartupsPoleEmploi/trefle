from behave import *

from pff.core import simulate
from pff.rules import LABELS

use_step_matcher('re')


@given('un bénéficiaire et une formation')
def setup(context):
    context.data = {}


@given("(?:le |la |l')(?P<key>.+) vaut (?P<value>.+)")
def step_impl(context, key, value):
    context.data[LABELS[key]] = value


@given("c'est une? (?P<key>.+)")
def step_impl(context, key):
    context.data[LABELS[key]] = True


@given("ce n'est pas une? (?P<key>.+)")
def step_impl(context, key):
    context.data[LABELS[key]] = False


@when('je demande un calcul de financement')
def step_impl(context):
    context.passed, _ = list(simulate(**context.data))


@when('je sélectionne le financement "(?P<name>.+)"')
def step_impl(context, name):
    assert context.passed, "No result found"
    for result in context.passed:
        if result.name == name:
            context.result = result
            break
    else:
        raise AssertionError(f'No result found with name {name}')


@then("l'organisme tutelle est (?P<name>.+)")
def step_impl(context, name):
    assert context.result.organisme == name


@then('le montant de prise en charge vaut (?P<value>\d+)')
def step_impl(context, value):
    assert context.result.prise_en_charge == int(value),\
        f'{context.result.prise_en_charge} != {value}'


@then('la rémunération vaut (?P<value>\d+)')
def step_impl(context, value):
    assert context.result.remuneration == int(value)


@then("aucun financement n'est proposé")
def step_impl(context):
    assert not context.passed, f"Results found: {context.passed}"
