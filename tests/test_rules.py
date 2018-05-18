import pytest

from trefle.exceptions import NoStepError, WrongPointerError
from trefle.rules import Rule, count_indent, Condition


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
        Et le taux horaire applicable vaut 80
    Si c'est une formation éligible COPANEF
        Si le solde CPF du bénéficiaire est supérieur à 0
            Alors la rémunération possible vaut 1000
            Et le taux horaire applicable vaut 60
"""
    rules = Rule.load(data.split('\n'))
    print(rules)
    assert len(rules) == 2
    assert rules[0].conditions[0].raw == "c'est un bénéficiaire de droit privé"
    assert rules[0].conditions[1].raw == ("la région de l'établissement du "
                                          "bénéficiaire fait partie des "
                                          "régions éligibles COPAREF")
    assert rules[0].actions[0].raw == 'la rémunération possible vaut 2000'
    assert rules[0].actions[1].raw == 'le taux horaire applicable vaut 80'
    assert rules[1].conditions[0].raw == "c'est un bénéficiaire de droit privé"
    assert rules[1].conditions[1].raw == "c'est une formation éligible COPANEF"
    assert rules[1].conditions[2].raw == ("le solde CPF du bénéficiaire est "
                                          "supérieur à 0")
    assert rules[1].actions[0].raw == 'la rémunération possible vaut 1000'
    assert rules[1].actions[1].raw == 'le taux horaire applicable vaut 60'


def test_mixing_SI_and_ALORS_with_same_indent():
    data = """
Si le nom de l'organisme est «BLAH»
    Alors le plafond horaire applicable vaut 150
    Si c'est une formation éligible COPANEF
        Alors le taux horaire applicable vaut 60
    Si le solde CPF du bénéficiaire est supérieur à 0
        Alors le taux horaire applicable vaut 50
    Si c'est un bénéficiaire de droit privé
        Alors le taux horaire applicable vaut 40
"""
    rules = Rule.load(data.split('\n'))
    print(rules)
    assert len(rules) == 4
    assert len(rules[0].conditions) == 1
    assert rules[0].conditions[0].raw == "le nom de l'organisme est «BLAH»"
    assert rules[0].actions[0].raw == 'le plafond horaire applicable vaut 150'
    assert len(rules[1].conditions) == 2
    assert rules[1].conditions[0].raw == "le nom de l'organisme est «BLAH»"
    assert rules[1].conditions[1].raw == "c'est une formation éligible COPANEF"
    assert rules[1].actions[0].raw == 'le taux horaire applicable vaut 60'
    assert len(rules[2].conditions) == 2
    assert rules[2].conditions[0].raw == "le nom de l'organisme est «BLAH»"
    assert rules[2].conditions[1].raw == ("le solde CPF du bénéficiaire est "
                                          "supérieur à 0")
    assert rules[2].actions[0].raw == 'le taux horaire applicable vaut 50'
    assert len(rules[3].conditions) == 2
    assert rules[3].conditions[0].raw == "le nom de l'organisme est «BLAH»"
    assert rules[3].conditions[1].raw == "c'est un bénéficiaire de droit privé"
    assert rules[3].actions[0].raw == 'le taux horaire applicable vaut 40'


def test_mixing_Si_and_Et():
    data = """
Si le nom de l'organisme est «BLAH»
    Alors le plafond horaire applicable vaut 150
    Si c'est une formation éligible COPANEF
    Et c'est un bénéficiaire de droit privé
        Alors le taux horaire applicable vaut 60
"""
    rules = Rule.load(data.split('\n'))
    print(rules)
    assert len(rules) == 2
    assert len(rules[0].conditions) == 1
    assert rules[0].conditions[0].raw == "le nom de l'organisme est «BLAH»"
    assert rules[0].actions[0].raw == 'le plafond horaire applicable vaut 150'
    assert len(rules[1].conditions) == 2
    assert rules[1].conditions[0].raw == "le nom de l'organisme est «BLAH»"
    assert rules[1].conditions[1].connective == Condition.AND
    assert rules[1].conditions[1].raw == ("c'est une formation éligible "
                                          "COPANEF ET c'est un bénéficiaire "
                                          "de droit privé")
    assert rules[1].actions[0].raw == 'le taux horaire applicable vaut 60'


def test_mixing_Si_and_Ou():
    data = """
Si le nom de l'organisme est «BLAH»
    Alors le plafond horaire applicable vaut 150
    Si c'est une formation éligible COPANEF
    Ou c'est un bénéficiaire de droit privé
        Alors le taux horaire applicable vaut 60
"""
    rules = Rule.load(data.split('\n'))
    print(rules)
    assert len(rules) == 2
    assert len(rules[0].conditions) == 1
    assert rules[0].conditions[0].raw == "le nom de l'organisme est «BLAH»"
    assert rules[0].actions[0].raw == 'le plafond horaire applicable vaut 150'
    assert len(rules[1].conditions) == 2
    assert rules[1].conditions[0].raw == "le nom de l'organisme est «BLAH»"
    assert rules[1].conditions[1].connective == Condition.OR
    assert rules[1].conditions[1].raw == ("c'est une formation éligible "
                                          "COPANEF OU c'est un bénéficiaire "
                                          "de droit privé")
    assert rules[1].actions[0].raw == 'le taux horaire applicable vaut 60'


# TODO FIXME
@pytest.mark.xfail
def test_with_two_steps_up():
    data = """
Si le nom de l'organisme est «BLAH»
    Si c'est une formation éligible COPANEF
        Alors la rémunération possible est égale à 1
Si le nom de l'organisme est «BLOOH»
    Alors la rémunération possible est égale à 2
"""
    rules = Rule.load(data.split('\n'))
    print(rules)
    assert len(rules) == 2
    assert len(rules[0].conditions) == 2
    assert rules[0].conditions[0].raw == "le nom de l'organisme est «BLAH»"
    assert rules[0].conditions[1].raw == "c'est une formation éligible COPANEF"
    assert rules[0].actions[0].raw == 'la rémunération possible est égale à 1'
    assert len(rules[1].conditions) == 1
    assert rules[1].conditions[0].raw == "le nom de l'organisme est «BLOOH»"
    assert rules[1].actions[0].raw == 'la rémunération possible est égale à 2'


def test_should_raise_if_no_pattern_match_condition():
    data = """
Si le nom de l'organisme pourrait bien être «BLAH»
    Alors le plafond horaire applicable vaut 150
"""
    with pytest.raises(NoStepError):
        Rule.load(data.split('\n'))


def test_should_raise_if_no_pattern_match_action():
    data = """
Si le nom de l'organisme est «BLAH»
    Alors le plafond horaire applicable pourrait bien être 150
"""
    with pytest.raises(NoStepError):
        Rule.load(data.split('\n'))


def test_should_raise_with_a_wrong_pointer_in_condition():
    data = """
Si le prénom de l'organisme est «BLAH»
    Alors le plafond horaire applicable vaut 150
"""
    with pytest.raises(WrongPointerError):
        Rule.load(data.split('\n'))


def test_should_raise_with_a_wrong_pointer_in_action():
    data = """
Si le nom de l'organisme est «BLAH»
    Alors le plafond de verre applicable vaut 150
"""
    with pytest.raises(WrongPointerError):
        Rule.load(data.split('\n'))
