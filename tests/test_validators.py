import re

import pytest

from trefle.validators import validate


def test_validate_integer(patch_schema):
    patch_schema({
        'beneficiaire.age': {'type': 'integer'},
        'beneficiaire.solde_cpf': {'type': 'integer'}
    })
    data = {
        'beneficiaire.age': '22',
        'beneficiaire.solde_cpf': '89.0',
    }
    validate(data)
    assert data['beneficiaire.age'] == 22
    assert data['beneficiaire.solde_cpf'] == 89


def test_validate_missing_required(patch_schema):
    patch_schema({
        'beneficiaire.age': {'type': 'integer', 'required': True},
        'beneficiaire.droit_prive': {'type': 'boolean', 'required': True},
    })
    with pytest.raises(ValueError) as err:
        validate({'beneficiaire.birth': 22})
    assert err.value.args[0] == {
        'beneficiaire.age': 'Ce champ est obligatoire',
        'beneficiaire.droit_prive': 'Ce champ est obligatoire',
    }


def test_validate_bad_integer(patch_schema):
    patch_schema({
        'beneficiaire.age': {'type': 'integer'},
        'beneficiaire.solde_cpf': {'type': 'integer', 'required': True},
    })
    data = {
        'beneficiaire.age': 'foo',
        'beneficiaire.solde_cpf': 'blah'
    }
    with pytest.raises(ValueError) as err:
        validate(data)
    assert err.value.args[0] == {
        'beneficiaire.age': "`foo` n'est pas de type integer",
        'beneficiaire.solde_cpf': "`blah` n'est pas de type integer"
    }


@pytest.mark.parametrize('input,expected', [
    ('true', True),
    ('oui', True),
    ('yes', True),
    ('false', False),
    ('non', False),
    ('no', False),
    ('0', False),
    ('1', True),
])
def test_validate_bool(input, expected, patch_schema):
    patch_schema({
        'beneficiaire.droit_prive': {'type': 'boolean', 'required': True}
    })
    data = {
        'beneficiaire.droit_prive': input,
    }
    validate(data)
    assert data['beneficiaire.droit_prive'] == expected


def test_validate_bad_bool(patch_schema):
    patch_schema({
        'beneficiaire.droit_prive': {'type': 'boolean', 'required': True}
    })
    data = {'beneficiaire.droit_prive': 'yep'}
    with pytest.raises(ValueError) as err:
        validate(data)
    assert err.value.args[0] == {
        'beneficiaire.droit_prive': "`yep` n'est pas de type boolean"
    }


def test_validate_enum(patch_schema):
    patch_schema({
        'beneficiaire.contrat': {'type': 'string',
                                 'enum': {'cdd': 'CDD', 'cdi': 'CDI'}}
    })
    data = {'beneficiaire.contrat': 'cdd'}
    validate(data)
    assert data['beneficiaire.contrat'] == 'cdd'


def test_validate_bad_enum(patch_schema):
    patch_schema({
        'beneficiaire.contrat': {'type': 'string',
                                 'enum': {'cdd': 'CDD', 'cdi': 'CDI'}}
    })
    data = {'beneficiaire.contrat': 'cdg'}
    with pytest.raises(ValueError) as err:
        validate(data)
    assert err.value.args[0] == {
        'beneficiaire.contrat': "`cdg` ne fait pas partie de ['cdd', 'cdi']"
    }


@pytest.mark.parametrize('input,valid', [
    ('01111', True),
    ('2A004', True),
    ('A2004', False),
    ('unvalid', False),
])
def test_validate_pattern(patch_schema, input, valid):
    patch_schema({
        'beneficiaire.insee': {
            'type': 'string',
            'pattern': re.compile('(2[AB]|[0-9]{2})[0-9]{3}')}})
    data = {'beneficiaire.insee': input}
    if not valid:
        with pytest.raises(ValueError):
            validate(data)
    else:
        validate(data)


@pytest.mark.parametrize('input,output', [
    ('1412', '1412'),
    ('0024', '24'),
    ('1722A', '1722A'),
    ('unvalid', False),
])
def test_validate_idcc(patch_schema, input, output):
    patch_schema({
        'idcc': {'type': 'string', 'format': 'idcc'}})
    data = {'idcc': input}
    if not output:
        with pytest.raises(ValueError):
            validate(data)
    else:
        validate(data)
        assert data['idcc'] == output


@pytest.mark.parametrize('input,output', [
    ('6202A', '6202A'),
    ('62.02A', '6202A'),
])
def test_validate_naf(patch_schema, input, output):
    patch_schema({
        'naf': {'type': 'string', 'format': 'naf'}})
    data = {'naf': input}
    validate(data)
    assert data['naf'] == output
