import pytest

from trefle.context import Context
from trefle.exceptions import DataError, NoDataError


def test_getitem(patch_schema):
    patch_schema({'key': {'type': 'string'}})
    context = Context({'key': 'value'})
    assert context['key'] == 'value'
    assert context.get('key') == 'value'


def test_get_should_return_default_if_key_is_missing(patch_schema):
    patch_schema({'key': {'type': 'integer'}})
    context = Context({})
    assert context.get('key') is None


def test_get_should_return_default_if_dataerror(patch_schema):
    patch_schema({'key': {'type': 'integer'}})
    context = Context({'key': 'invalid'})
    assert context.get('key') is None


def test_getitem_should_raise_dataerror(patch_schema):
    patch_schema({'key': {'type': 'integer'}})
    context = Context({'key': 'invalid'})
    with pytest.raises(DataError):
        context['key']


def test_getitem_should_raise_nodataerror_when_key_is_missing(patch_schema):
    patch_schema({'key': {'type': 'integer'}})
    context = Context({})
    with pytest.raises(NoDataError):
        context['key']


def test_setitem_should_validate_value(patch_schema):
    patch_schema({'key': {'type': 'integer'}})
    context = Context({})
    context['key'] = '12'
    assert context['key'] == 12


def test_setitem_should_not_set_invalid_value(patch_schema):
    patch_schema({'key': {'type': 'integer'}})
    context = Context({})
    context['key'] = 'invalid'
    assert 'key' not in context
    assert context.get('key') is None


def test_copy_should_copy_data_and_cleaned_data():
    context = Context({'key': 'value'})
    other = context.copy()
    other['key'] = 'other'
    assert context['key'] == 'value'
    context['key'] = 'again'
    assert other['key'] == 'other'
