from pff.core import Condition, VARIABLES

VARIABLES.clear()
VARIABLES.update({
    'age': {
        'type': 'int'
    },
    'inscrit': {
        'type': 'bool'
    },
})


def test_equal_to_const_condition():
    condition = Condition('inscrit = OUI')
    assert condition.left.raw == 'inscrit'
    assert condition.operator == '='
    assert condition.right.raw == 'OUI'
    assert condition.assess(inscrit='OUI') is True
    assert condition.assess(inscrit='NON') is False
    assert condition.assess(unknown='OUI') is False


def test_gt_int_condition():
    condition = Condition('age > 18')
    assert condition.left.raw == 'age'
    assert condition.operator == '>'
    assert condition.right.raw == 18
    assert condition.assess(age='19') is True
    assert condition.assess(age=19) is True
    assert condition.assess(age='17') is False
    assert condition.assess(age='notanint') is False


def test_equal_OR_combined_condition():
    condition = Condition('inscrit = OUI OU age > 50')
    assert len(condition.conditions) == 2
    assert condition.assess(inscrit='OUI', age='39') is True
    assert condition.assess(inscrit='NON', age='51') is True
    assert condition.assess(inscrit='NON', age='39') is False


def test_equal_AND_combined_condition():
    condition = Condition('inscrit = OUI ET age > 50')
    assert len(condition.conditions) == 2
    assert condition.assess(inscrit='OUI', age='60') is True
    assert condition.assess(inscrit='OUI', age='49') is False
    assert condition.assess(inscrit='NON', age='notanint') is False
