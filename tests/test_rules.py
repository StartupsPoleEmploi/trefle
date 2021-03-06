import pytest

from trefle.exceptions import NoStepError, WrongPointerError, ParsingError
from trefle.rules import Rule, Condition


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
        'label': 'formation éligible CPF',
    },
    'permis_b': {
        'type': 'boolean',
        'label': 'permis B',
    },
}


def test_rules_load():
    data = """
Si c'est un demandeur d'emploi
    Si la région du bénéficiaire vaut «Bretagne»
        Alors la rémunération applicable vaut 2000
        Et le prix horaire applicable vaut 80
    Si c'est une formation éligible CPF
        Si le solde CPF du bénéficiaire est supérieur à 0
            Alors la rémunération applicable vaut 1000
            Et le prix horaire applicable vaut 60
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    print(root)
    assert len(root.actions) == 0
    assert root.raw == "c'est un demandeur d'emploi"
    assert len(root.children) == 2
    assert root.children[0].raw == ("la région du bénéficiaire vaut «Bretagne»")
    assert root.children[0].actions[0].raw == (
        'la rémunération applicable vaut 2000')
    assert root.children[0].actions[1].raw == (
        'le prix horaire applicable vaut 80')
    assert len(root.children[0].children) == 0
    assert root.children[1].raw == "c'est une formation éligible CPF"
    assert len(root.children[1].children) == 1
    assert root.children[1].children[0].raw == (
        "le solde CPF du bénéficiaire est supérieur à 0")
    assert root.children[1].children[0].actions[0].raw == (
        'la rémunération applicable vaut 1000')
    assert root.children[1].children[0].actions[1].raw == (
        'le prix horaire applicable vaut 60')


def test_mixing_SI_and_ALORS_with_same_indent():
    data = """
Si l'organisme paritaire est «BLAH»
    Alors le plafond horaire applicable vaut 150
    Si c'est une formation éligible CPF
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
    assert root.raw == "l'organisme paritaire est «BLAH»"
    assert root.actions[0].raw == 'le plafond horaire applicable vaut 150'
    assert len(root.children[0].children) == 0
    assert root.children[0].raw == "c'est une formation éligible CPF"
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
Si l'organisme paritaire est «BLAH»
    Alors le plafond horaire applicable vaut 150
    Si c'est une formation éligible CPF
    Et c'est un bénéficiaire de droit privé
        Alors le prix horaire applicable vaut 60
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    print(root)
    assert len(root.children) == 1
    assert len(root.actions) == 1
    assert root.raw == "l'organisme paritaire est «BLAH»"
    assert root.actions[0].raw == 'le plafond horaire applicable vaut 150'
    assert root.children[0].connective == Condition.AND
    assert root.children[0].raw == ("c'est une formation éligible CPF ET "
                                    "c'est un bénéficiaire de droit privé")
    assert root.children[0].actions[0].raw == \
        'le prix horaire applicable vaut 60'


def test_mixing_Si_and_Ou():
    data = """
Si l'organisme paritaire est «BLAH»
    Alors le plafond horaire applicable vaut 150
    Si c'est une formation éligible CPF
    Ou c'est un bénéficiaire de droit privé
        Alors le prix horaire applicable vaut 60
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    print(root)
    assert len(root.children) == 1
    assert len(root.actions) == 1
    assert root.raw == "l'organisme paritaire est «BLAH»"
    assert root.actions[0].raw == 'le plafond horaire applicable vaut 150'
    assert root.children[0].connective == Condition.OR
    assert root.children[0].raw == ("c'est une formation éligible CPF OU "
                                    "c'est un bénéficiaire de droit privé")
    assert root.children[0].actions[0].raw == \
        'le prix horaire applicable vaut 60'


def test_mixing_Si_and_Ou_and_Et():
    data = """
Si l'organisme paritaire est «BLAH»
    Alors le plafond horaire applicable vaut 150
    Si c'est une formation éligible CPF
    Et c'est un permis B
    Ou c'est un bénéficiaire de droit privé
    Et c'est un parent isolé
        Alors le prix horaire applicable vaut 60
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    assert len(root.children) == 1
    assert len(root.actions) == 1
    assert root.raw == "l'organisme paritaire est «BLAH»"
    assert root.actions[0].raw == 'le plafond horaire applicable vaut 150'
    assert root.children[0].connective == Condition.OR
    assert root.children[0].raw == ("c'est une formation éligible CPF "
                                    "ET c'est un permis B OU "
                                    "c'est un bénéficiaire de droit privé "
                                    "ET c'est un parent isolé")
    assert root.children[0].actions[0].raw == \
        'le prix horaire applicable vaut 60'
    assert len(root.children[0].terms) == 2
    assert root.children[0].terms[0].raw == ("c'est une formation éligible "
                                             "CPF ET c'est un permis B")
    assert root.children[0].terms[1].raw == ("c'est un bénéficiaire de droit "
                                             "privé ET c'est un parent isolé")


def test_mixing_Si_and_Ou_and_Et_and_inline():
    data = """
Si l'organisme paritaire est «BLAH»
    Si c'est une formation certifiante
    Et c'est une formation éligible à la RFF, ou c'est une formation éligible CPF
    Et la durée en heures de la formation n'est pas supérieure à 1600

    Ou c'est une formation professionnalisante
    Et la durée en heures de la formation n'est pas supérieure à 600
    Et la durée hebdomadaire de la formation n'est pas inférieure à 20
        Alors le prix horaire applicable vaut 99
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    assert len(root.children) == 1
    assert len(root.actions) == 0
    assert root.raw == "l'organisme paritaire est «BLAH»"
    child = root.children[0]
    assert len(child.terms) == 2
    assert len(child.actions) == 1
    assert child.actions[0].raw == 'le prix horaire applicable vaut 99'
    assert child.connective == Condition.OR
    assert child.raw == ("c'est une formation certifiante "
                         "ET c'est une formation éligible à la RFF "
                         "OU c'est une formation éligible CPF "
                         "ET la durée en heures de la formation "
                         "n'est pas supérieure à 1600 OU c'est "
                         "une formation professionnalisante ET la durée en "
                         "heures de la formation n'est pas supérieure à 600 "
                         "ET la durée hebdomadaire de la formation n'est pas "
                         "inférieure à 20")
    term = child.terms[0]
    assert len(term.terms) == 3
    assert term.terms[0].raw == "c'est une formation certifiante"
    term = term.terms[1]
    assert len(term.terms) == 2
    assert term.connective == Condition.OR
    assert term.raw == ("c'est une formation éligible à la RFF "
                        "OU c'est une formation éligible CPF")


def test_inline_conditions():
    data = """
Si l'organisme paritaire est «BLAH»
    Si c'est une formation éligible CPF, et c'est un bénéficiaire de droit privé
        Alors le plafond horaire applicable vaut 99
"""
    root = Rule.load(data.splitlines(), name='foo')[0].root
    assert len(root.children) == 1
    assert len(root.actions) == 0
    assert root.raw == "l'organisme paritaire est «BLAH»"
    assert root.children[0].connective == Condition.AND
    assert root.children[0].terms[0].raw == \
        "c'est une formation éligible CPF"
    assert root.children[0].terms[1].raw == \
        "c'est un bénéficiaire de droit privé"
    assert root.children[0].raw == ("c'est une formation éligible CPF ET "
                                    "c'est un bénéficiaire de droit privé")
    assert root.children[0].actions[0].raw == \
        'le plafond horaire applicable vaut 99'


def test_with_two_steps_up():
    data = """
Si l'organisme paritaire est «BLAH»
    Si c'est une formation éligible CPF
        Alors la rémunération applicable est égale à 1
Si l'organisme paritaire est «BLOOH»
    Alors la rémunération applicable est égale à 2
"""
    rules = list(Rule.load(data.splitlines(), name='foo'))
    print(rules)
    assert len(rules) == 2
    root = rules[0].root
    assert len(root.children) == 1
    assert len(root.actions) == 0
    assert root.raw == "l'organisme paritaire est «BLAH»"
    assert root.children[0].raw == "c'est une formation éligible CPF"
    assert len(root.children[0].actions) == 1
    assert root.children[0].actions[0].raw == \
        'la rémunération applicable est égale à 1'
    root = rules[1].root
    assert len(root.children) == 0
    assert len(root.actions) == 1
    assert root.raw == "l'organisme paritaire est «BLOOH»"
    assert root.actions[0].raw == 'la rémunération applicable est égale à 2'


def test_should_raise_if_no_pattern_match_condition():
    data = """
Si l'organisme paritaire pourrait bien être «BLAH»
    Alors le plafond horaire applicable vaut 150
"""
    with pytest.raises(NoStepError):
        Rule.load(data.splitlines(), name='foo')


def test_should_raise_if_no_pattern_match_action():
    data = """
Si l'organisme paritaire est «BLAH»
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


def test_should_raise_with_a_wrong_label_in_condition():
    data = """
Si la région du bénéficiaire est «BLAH»
    Alors le plafond horaire applicable vaut 150
"""
    with pytest.raises(WrongPointerError):
        Rule.load(data.splitlines(), name='foo')


def test_can_use_raw_value_instead_of_label():
    data = """
# Guadeloupe
Si la région du bénéficiaire est «01»
    Alors le plafond horaire applicable vaut 150
"""
    Rule.load(data.splitlines(), name='foo')


def test_should_raise_with_a_wrong_pointer_in_action():
    data = """
Si l'organisme paritaire est «BLAH»
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
    tree = Rule.load(data.splitlines(), name='foo')[0]
    context = {'droit_prive': True}
    Rule.process(tree, context)
    assert context['remuneration'] == 40


def test_process_with_false_condition(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Alors la rémunération applicable vaut 40
"""
    tree = Rule.load(data.splitlines(), name='foo')[0]
    context = {'droit_prive': False}
    Rule.process(tree, context)
    assert 'remuneration' not in context


def test_process_with_indented_condition(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Si c'est une formation éligible CPF
        Alors la rémunération applicable vaut 40
"""
    tree = Rule.load(data.splitlines(), name='foo')[0]
    context = {'droit_prive': True, 'copanef': True}
    Rule.process(tree, context)
    assert context['remuneration'] == 40


def test_process_with_indented_false_condition(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Si c'est une formation éligible CPF
        Alors la rémunération applicable vaut 40
"""
    tree = Rule.load(data.splitlines(), name='foo')[0]
    context = {'droit_prive': True, 'copanef': False}
    Rule.process(tree, context)
    assert 'remuneration' not in context


def test_process_with_siblings(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Si c'est une formation éligible CPF
        Alors la rémunération applicable vaut 40
    Si c'est un permis B
        Alors le prix horaire applicable vaut 20
"""
    tree = Rule.load(data.splitlines(), name='foo')[0]
    context = {'droit_prive': True, 'copanef': True, 'permis_b': True}
    Rule.process(tree, context)
    assert context['remuneration'] == 40
    assert context['prix'] == 20


def test_process_with_false_sibling(patch_schema):
    patch_schema(SCHEMA)
    data = """
Si c'est un bénéficiaire de droit privé
    Si c'est une formation éligible CPF
        Alors la rémunération applicable vaut 40
    Si c'est un permis B
        Alors le prix horaire applicable vaut 20
"""
    tree = Rule.load(data.splitlines(), name='foo')[0]
    context = {'droit_prive': True, 'copanef': False, 'permis_b': True}
    Rule.process(tree, context)
    assert 'remuneration' not in context
    assert context['prix'] == 20


def test_should_raise_with_a_wrong_keyword():
    data = """
Si l'organisme paritaire est «BLAH»
    Et la rémunération applicable vaut 40
"""
    with pytest.raises(ParsingError):
        Rule.load(data.splitlines(), name='foo')


def test_should_raise_with_a_unknown_keyword():
    data = """
Si l'organisme paritaire est «BLAH»
    Foo la rémunération applicable vaut 40
"""
    with pytest.raises(ParsingError):
        Rule.load(data.splitlines(), name='foo')


def test_should_raise_with_a_wrong_indent():
    data = """
Si l'organisme paritaire est «BLAH»
  Alors la rémunération applicable vaut 40
"""
    with pytest.raises(ParsingError):
        Rule.load(data.splitlines(), name='foo')


def test_should_raise_with_a_condition_without_parent():
    data = """
Si l'organisme paritaire est «BLAH»
    Alors la rémunération applicable vaut 40
        Si l'organisme paritaire est «FOO»
            Alors la rémunération applicable vaut 40
"""
    with pytest.raises(ParsingError):
        Rule.load(data.splitlines(), name='foo')

