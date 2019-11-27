import pytest

from trefle.context import Context
from trefle.exceptions import WrongPointerError
from trefle.rules import Pointer


def test_pointer_with_string_constant(patch_schema):
    patch_schema({})  # Make sure we have no labels.
    lv = Pointer('«CDI»')
    assert lv.get({}) == 'CDI'


def test_pointer_with_int_constant():
    lv = Pointer('18')
    assert lv.get({}) == 18


def test_pointer_with_float_constant():
    lv = Pointer('27.45')
    assert lv.get({}) == 27.45


def test_pointer_with_int_variable(patch_schema):
    patch_schema({'a_key': {'type': 'integer', 'label': 'a label'}})
    lv = Pointer('a label')
    assert lv.get({'a_key': 27}) == 27


def test_pointer_with_bool_variable(patch_schema):
    patch_schema({'a_key': {'type': 'boolean', 'label': 'a label'}})
    lv = Pointer('a label')
    assert lv.get({'a_key': True}) is True


def test_pointer_raises_with_invalid_pointer():
    with pytest.raises(WrongPointerError):
        Pointer('invalid pointer')


def test_pointer_should_return_default_value_for_missing_key(patch_schema):
    patch_schema({'a_key': {'type': 'integer', 'label': 'a label',
                            'default': 123}})
    lv = Pointer('a label')
    assert lv.get(Context({'wrong': 27})) == 123


def test_pointer_should_return_default_value_for_none_value(patch_schema):
    patch_schema({'a_key': {'type': 'integer', 'label': 'a label',
                            'default': 123}})
    lv = Pointer('a label')
    assert lv.get(Context({'wrong': None})) == 123
