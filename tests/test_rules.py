import pytest

from trefle.exceptions import NoStepError, WrongPointerError
from trefle.rules import Rule, count_indent, Condition


SCHEMA = {
    'droit_prive': {
        'type': 'bool',
        'label': 'bénéficiaire de droit privé',
    },
    'remuneration': {
        'type': 'integer',
        'label': "rémunération applicable",
    },
    'prix': {
        'type': 'integer',
        'label': "prix horaire applicable",
    },
    'copanef': {
        'type': 'boolean',
        'label': 'formation éligible COPANEF',
    },
    'permis_b': {
        'type': 'boolean',
        'label': 'permis B',
    },
}


@pytest.mark.parametrize('input,expected', [
    ('', 0),
    ('    ', 4),
    ('    x', 4),
])
def test_count_indent(input, expected):
    assert count_indent(input) == expected


def test_rules_load():
    data = """
Si c'est un bénéficiaire de droit privé
    Si la région de l'établissement du bénéficiaire fait partie des régions éligibles COPAREF
        Alors la rémunération possible vaut 2000
        Et le prix horaire applicable vaut 80
    Si c'est une formation éligible COPANEF
        Si le solde CPF du bénéficiaire est supérieur à 0
            Alors la rémunération possible vaut 1000
            Et le prix horaire applicable vaut 60
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    print(root)
    assert len(root.actions) == 0
    assert root.raw == "c'est un bénéficiaire de droit privé"
    assert len(root.children) == 2
    assert root.children[0].raw == (
        "la région de l'établissement du bénéficiaire fait partie des régions "
        "éligibles COPAREF")
    assert root.children[0].actions[0].raw == (
        'la rémunération possible vaut 2000')
    assert root.children[0].actions[1].raw == (
        'le prix horaire applicable vaut 80')
    assert len(root.children[0].children) == 0
    assert root.children[1].raw == "c'est une formation éligible COPANEF"
    assert len(root.children[1].children) == 1
    assert root.children[1].children[0].raw == (
        "le solde CPF du bénéficiaire est supérieur à 0")
    assert root.children[1].children[0].actions[0].raw == (
        'la rémunération possible vaut 1000')
    assert root.children[1].children[0].actions[1].raw == (
        'le prix horaire applicable vaut 60')


def test_mixing_SI_and_ALORS_with_same_indent():
    data = """
Si le nom de l'organisme est «BLAH»
    Alors le plafond horaire applicable vaut 150
    Si c'est une formation éligible COPANEF
        Alors le prix horaire applicable vaut 60
    Si le solde CPF du bénéficiaire est supérieur à 0
        Alors le prix horaire applicable vaut 50
    Si c'est un bénéficiaire de droit privé
        Alors le prix horaire applicable vaut 40
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    print(root)
    assert len(root.children) == 3
    assert len(root.actions) == 1
    assert root.raw == "le nom de l'organisme est «BLAH»"
    assert root.actions[0].raw == 'le plafond horaire applicable vaut 150'
    assert len(root.children[0].children) == 0
    assert root.children[0].raw == "c'est une formation éligible COPANEF"
    assert len(root.children[0].actions) == 1
    assert root.children[0].actions[0].raw == \
        'le prix horaire applicable vaut 60'
    assert len(root.children[1].actions) == 1
    assert root.children[1].raw == ("le solde CPF du bénéficiaire est "
                                    "supérieur à 0")
    assert root.children[1].actions[0].raw == \
        'le prix horaire applicable vaut 50'
    assert len(root.children[2].actions) == 1
    assert root.children[2].raw == "c'est un bénéficiaire de droit privé"
    assert root.children[2].actions[0].raw == \
        'le prix horaire applicable vaut 40'


def test_mixing_Si_and_Et():
    data = """
Si le nom de l'organisme est «BLAH»
    Alors le plafond horaire applicable vaut 150
    Si c'est une formation éligible COPANEF
    Et c'est un bénéficiaire de droit privé
        Alors le prix horaire applicable vaut 60
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    print(root)
    assert len(root.children) == 1
    assert len(root.actions) == 1
    assert root.raw == "le nom de l'organisme est «BLAH»"
    assert root.actions[0].raw == 'le plafond horaire applicable vaut 150'
    assert root.children[0].connective == Condition.AND
    assert root.children[0].raw == ("c'est une formation éligible COPANEF ET "
                                    "c'est un bénéficiaire de droit privé")
    assert root.children[0].actions[0].raw == \
        'le prix horaire applicable vaut 60'


def test_mixing_Si_and_Ou():
    data = """
Si le nom de l'organisme est «BLAH»
    Alors le plafond horaire applicable vaut 150
    Si c'est une formation éligible COPANEF
    Ou c'est un bénéficiaire de droit privé
        Alors le prix horaire applicable vaut 60
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    print(root)
    assert len(root.children) == 1
    assert len(root.actions) == 1
    assert root.raw == "le nom de l'organisme est «BLAH»"
    assert root.actions[0].raw == 'le plafond horaire applicable vaut 150'
    assert root.children[0].connective == Condition.OR
    assert root.children[0].raw == ("c'est une formation éligible COPANEF OU "
                                    "c'est un bénéficiaire de droit privé")
    assert root.children[0].actions[0].raw == \
        'le prix horaire applicable vaut 60'


def test_inline_conditions():
    data = """
Si le nom de l'organisme est «BLAH»
    Si c'est une formation éligible COPANEF, et c'est un bénéficiaire de droit privé
        Alors le plafond horaire applicable vaut 99
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    print(root)
    assert len(root.children) == 1
    assert len(root.actions) == 0
    assert root.raw == "le nom de l'organisme est «BLAH»"
    assert root.children[0].connective == Condition.AND
    assert root.children[0].terms[0].raw == \
        "c'est une formation éligible COPANEF"
    assert root.children[0].terms[1].raw == \
        "c'est un bénéficiaire de droit privé"
    assert root.children[0].raw == ("c'est une formation éligible COPANEF ET "
                                    "c'est un bénéficiaire de droit privé")
    assert root.children[0].actions[0].raw == \
        'le plafond horaire applicable vaut 99'


def test_with_two_steps_up():
    data = """
Si le nom de l'organisme est «BLAH»
    Si c'est une formation éligible COPANEF
        Alors la rémunération possible est égale à 1
Si le nom de l'organisme est «BLOOH»
    Alors la rémunération possible est égale à 2
"""
    rules = list(Rule.load(data.splitlines(), name='foo'))
    print(rules)
    assert len(rules) == 2
    root = rules[0].root
    assert len(root.children) == 1
    assert len(root.actions) == 0
    assert root.raw == "le nom de l'organisme est «BLAH»"
    assert root.children[0].raw == "c'est une formation éligible COPANEF"
    assert len(root.children[0].actions) == 1
    assert root.children[0].actions[0].raw == \
        'la rémunération possible est égale à 1'
    root = rules[1].root
    assert len(root.children) == 0
    assert len(root.actions) == 1
    assert root.raw == "le nom de l'organisme est «BLOOH»"
    assert root.actions[0].raw == 'la rémunération possible est égale à 2'


def test_should_raise_if_no_pattern_match_condition():
    data = """
Si le nom de l'organisme pourrait bien être «BLAH»
    Alors le plafond horaire applicable vaut 150
"""
    with pytest.raises(NoStepError):
        Rule.load(data.splitlines(), name='foo')


def test_should_raise_if_no_pattern_match_action():
    data = """
Si le nom de l'organisme est «BLAH»
    Alors le plafond horaire applicable pourrait bien être 150
"""
    with pytest.raises(NoStepError):
        Rule.load(data.splitlines(), name='foo')


def test_should_raise_with_a_wrong_pointer_in_condition():
    data = """
Si le prénom de l'organisme est «BLAH»
    Alors le plafond horaire applicable vaut 150
"""
    with pytest.raises(WrongPointerError):
        Rule.load(data.splitlines(), name='foo')


def test_should_raise_with_a_wrong_pointer_in_action():
    data = """
Si le nom de l'organisme est «BLAH»
    Alors le plafond de verre applicable vaut 150
"""
    with pytest.raises(WrongPointerError):
        Rule.load(data.splitlines(), name='foo')


def test_process_with_simple_condition(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Alors la rémunération applicable vaut 40
"""
    trees = Rule.load(data.splitlines(), name='foo')
    context = {'droit_prive': True}
    Rule.process(trees, context)
    assert context['remuneration'] == 40


def test_process_with_false_condition(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Alors la rémunération applicable vaut 40
"""
    trees = Rule.load(data.splitlines(), name='foo')
    context = {'droit_prive': False}
    Rule.process(trees, context)
    assert 'remuneration' not in context


def test_process_with_indentend_condition(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Si c'est une formation éligible COPANEF
        Alors la rémunération applicable vaut 40
"""
    trees = Rule.load(data.splitlines(), name='foo')
    context = {'droit_prive': True, 'copanef': True}
    Rule.process(trees, context)
    assert context['remuneration'] == 40


def test_process_with_indentend_false_condition(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Si c'est une formation éligible COPANEF
        Alors la rémunération applicable vaut 40
"""
    trees = Rule.load(data.splitlines(), name='foo')
    context = {'droit_prive': True, 'copanef': False}
    Rule.process(trees, context)
    assert 'remuneration' not in context


def test_process_with_siblings(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Si c'est une formation éligible COPANEF
        Alors la rémunération applicable vaut 40
    Si c'est un permis B
        Alors le prix horaire applicable vaut 20
"""
    trees = Rule.load(data.splitlines(), name='foo')
    context = {'droit_prive': True, 'copanef': True, 'permis_b': True}
    Rule.process(trees, context)
    assert context['remuneration'] == 40
    assert context['prix'] == 20


def test_process_with_false_sibling(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Si c'est une formation éligible COPANEF
        Alors la rémunération applicable vaut 40
    Si c'est un permis B
        Alors le prix horaire applicable vaut 20
"""
    trees = Rule.load(data.splitlines(), name='foo')
    context = {'droit_prive': True, 'copanef': False, 'permis_b': True}
    Rule.process(trees, context)
    assert 'remuneration' not in context
    assert context['prix'] == 20
