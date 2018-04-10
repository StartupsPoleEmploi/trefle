import pytest

from pff.core import Condition, VARIABLES


@pytest.fixture
def patch_variables():
    before = VARIABLES.copy()
    VARIABLES.clear()
    VARIABLES.update({
        'age': {
            'type': 'int'
        },
        'inscrit': {
            'type': 'bool'
        },
    })
    yield
    VARIABLES.clear()
    VARIABLES.update(before)


def test_equal_to_const_condition(patch_variables):
    condition = Condition('inscrit = OUI')
    assert condition.assess(inscrit='OUI') is True
    assert condition.assess(inscrit='NON') is False
    assert condition.assess(unknown='OUI') is False


def test_gt_int_condition(patch_variables):
    condition = Condition('age > 18')
    assert condition.assess(age='19') is True
    assert condition.assess(age=19) is True
    assert condition.assess(age='17') is False


def test_gt_int_condition_should_raise_with_invalid_value(patch_variables):
    condition = Condition('age > 18')
    with pytest.raises(ValueError):
        condition.assess(age='notanint')


def test_equal_int_condition_should_raise_with_invalid_value(patch_variables):
    condition = Condition('age = 18')
    with pytest.raises(ValueError):
        condition.assess(age='notanint')


def test_equal_true_condition_should_raise_with_invalid_value(patch_variables):
    condition = Condition('inscrit = OUI')
    with pytest.raises(ValueError):
        condition.assess(inscrit='notabool')


def test_equal_OR_combined_condition(patch_variables):
    condition = Condition('inscrit = OUI OU age > 50')
    assert len(condition.conditions) == 2
    assert condition.assess(inscrit='OUI', age='39') is True
    assert condition.assess(inscrit='NON', age='51') is True
    assert condition.assess(inscrit='NON', age='39') is False


def test_equal_AND_combined_condition(patch_variables):
    condition = Condition('inscrit = OUI ET age > 50')
    assert len(condition.conditions) == 2
    assert condition.assess(inscrit='OUI', age='60') is True
    assert condition.assess(inscrit='OUI', age='49') is False
    with pytest.raises(ValueError):
        condition.assess(inscrit='NON', age='notanint')
