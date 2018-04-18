import pytest

from pff.rules import Rule, count_ident


@pytest.mark.parametrize('input,expected', [
    ('', 0),
    ('    ', 4),
    ('    x', 4),
])
def test_count_ident(input, expected):
    assert count_ident(input) == expected


def test_rules_load():
    data = """
SI c'est un bénéficiaire de droit privé
    SI la région de l'établissement du bénéficiaire fait partie des régions éligibles COPAREF
        ALORS la rémunération possible vaut 2000
        ALORS le taux horaire applicable vaut 8000
    SI c'est une formation éligible COPANEF
        SI le compte CPF du bénéficiaire est supérieur à 0
            ALORS la rémunération possible vaut 1000
            ALORS le taux horaire applicable vaut 6000
"""
    rules = Rule.load(data.split('\n'))
    print(rules)
    assert len(rules) == 2
    assert rules[0].conditions[0].raw == "c'est un bénéficiaire de droit privé"
    assert rules[0].conditions[1].raw == ("la région de l'établissement du "
                                          "bénéficiaire fait partie des "
                                          "régions éligibles COPAREF")
    assert rules[0].actions[0].raw == 'la rémunération possible vaut 2000'
    assert rules[0].actions[1].raw == 'le taux horaire applicable vaut 8000'
    assert rules[1].conditions[0].raw == "c'est un bénéficiaire de droit privé"
    assert rules[1].conditions[1].raw == "c'est une formation éligible COPANEF"
    assert rules[1].conditions[2].raw == ("le compte CPF du bénéficiaire est "
                                          "supérieur à 0")
    assert rules[1].actions[0].raw == 'la rémunération possible vaut 1000'
    assert rules[1].actions[1].raw == 'le taux horaire applicable vaut 6000'
