import pytest

from trefle.rules import Condition, VARIABLES, LABELS


@pytest.fixture
def patch_variables():
    before = VARIABLES.copy()
    VARIABLES.clear()
    VARIABLES.update({
        'age': {
            'type': 'integer',
            'label': 'âge du bénéficiaire',
        },
        'contrat': {
            'type': 'str',
            'label': "type de contrat du bénéficiaire",
        },
        'naf': {
            'type': 'str',
            'label': "code naf du bénéficiaire",
        },
        'nafs': {
            'type': 'List[str]',
            'label': "codes naf de la formation",
        },
        'inscrit': {
            'type': 'boolean',
            'label': 'bénéficiaire inscrit',
        },
    })
    LABELS.update({v['label']: k for k, v in VARIABLES.items()})
    yield
    VARIABLES.clear()
    VARIABLES.update(before)


def test_boolean_condition(patch_variables):
    condition = Condition("SI c'est un bénéficiaire inscrit")
    assert condition.assess(inscrit=True) is True
    assert condition.assess(inscrit=False) is False
    assert condition.assess(unknown=True) is False


def test_negative_boolean_condition(patch_variables):
    condition = Condition("SI ce n'est pas un bénéficiaire inscrit")
    assert condition.assess(inscrit=False) is True
    assert condition.assess(inscrit=True) is False
    assert condition.assess(unknown='X') is False


def test_gt_int_condition(patch_variables):
    condition = Condition("SI l'âge du bénéficiaire est supérieur à 18")
    assert condition.assess(age=19) is True
    assert condition.assess(age=17) is False
    assert condition.assess(age=18) is False


def test_ge_int_condition(patch_variables):
    condition = Condition("SI l'âge du bénéficiaire "
                          "est supérieur ou égal à 18")
    assert condition.assess(age=19) is True
    assert condition.assess(age=18) is True
    assert condition.assess(age=17) is False


def test_equal_str_condition(patch_variables):
    condition = Condition("SI le type de contrat du bénéficiaire est «CDD»")
    assert condition.assess(contrat='CDD') is True
    assert condition.assess(contrat='CDI') is False
    assert condition.assess(inscrit=False) is False


def test_equal_OR_combined_condition(patch_variables):
    condition = Condition("SI c'est un bénéficiaire inscrit "
                          "OU l'âge du bénéficiaire est supérieur à 50")
    assert len(condition.conditions) == 2
    assert condition.assess(inscrit=True, age=39) is True
    assert condition.assess(inscrit=False, age=51) is True
    assert condition.assess(inscrit=False, age=39) is False


def test_equal_AND_combined_condition(patch_variables):
    condition = Condition("SI c'est un bénéficiaire inscrit "
                          "ET l'âge du bénéficiaire est supérieur à 50")
    assert len(condition.conditions) == 2
    assert condition.assess(inscrit=True, age=60) is True
    assert condition.assess(inscrit=True, age=49) is False


def test_contains_condition(patch_variables):
    condition = Condition("SI le code naf du bénéficiaire fait partie des "
                          "codes naf de la formation")
    assert condition.assess(naf='123', nafs=['123', '456']) is True
    assert condition.assess(naf='123', nafs=['456']) is False
    assert condition.assess(unknown=True) is False


def test_not_contains_condition(patch_variables):
    condition = Condition("SI le code naf du bénéficiaire ne fait pas partie "
                          "des codes naf de la formation")
    assert condition.assess(naf='123', nafs=['123', '456']) is False
    assert condition.assess(naf='123', nafs=['456']) is True
    assert condition.assess(unknown=True) is False
