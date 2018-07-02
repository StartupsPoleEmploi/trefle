import pytest

from trefle.exceptions import WrongPointerError
from trefle.rules import LazyValue


def test_lazyvalue_with_string_constant(patch_schema):
    patch_schema({})  # Make sure we have no labels.
    lv = LazyValue('«CDI»')
    assert lv.get() == 'CDI'


def test_lazyvalue_with_int_constant():
    lv = LazyValue('18')
    assert lv.get() == 18


def test_lazyvalue_with_float_constant():
    lv = LazyValue('27.45')
    assert lv.get() == 27.45


def test_lazyvalue_with_int_variable(patch_schema):
    patch_schema({'a_key': {'type': 'integer', 'label': 'a label'}})
    lv = LazyValue('a label')
    assert lv.get(a_key=27) == 27


def test_lazyvalue_with_bool_variable(patch_schema):
    patch_schema({'a_key': {'type': 'boolean', 'label': 'a label'}})
    lv = LazyValue('a label')
    assert lv.get(a_key=True) is True


def test_lazyvalue_raises_with_invalid_pointer():
    with pytest.raises(WrongPointerError):
        LazyValue('invalid pointer')


def test_lazyvalue_should_return_default_value_for_missing_key(patch_schema):
    patch_schema({'a_key': {'type': 'integer', 'label': 'a label',
                            'default': 123}})
    lv = LazyValue('a label')
    assert lv.get(wrong=27) == 123


def test_lazyvalue_should_return_default_value_for_none_value(patch_schema):
    patch_schema({'a_key': {'type': 'integer', 'label': 'a label',
                            'default': 123}})
    lv = LazyValue('a label')
    assert lv.get(wrong=None) == 123
