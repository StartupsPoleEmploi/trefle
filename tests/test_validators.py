import pytest


from pff.validators import validate


def test_validate():
    data = {
        'beneficiaire.droit_prive': True,
        'beneficiaire.age': '22',
        'beneficiaire.solde_cpf': '89',
        'beneficiaire.remuneration': 1200,
        'formation.numero': '23_24',
    }
    validate(data)
    assert data['beneficiaire.age'] == 22
    assert data['beneficiaire.solde_cpf'] == 89


def test_validate_missing_required():
    with pytest.raises(ValueError) as err:
        validate({})
    assert err.value.args[0] == {
        'beneficiaire.droit_prive': 'Ce champ est obligatoire',
        'beneficiaire.remuneration': 'Ce champ est obligatoire',
        'beneficiaire.solde_cpf': 'Ce champ est obligatoire'
    }


def test_validate_bad_integer():
    data = {
        'beneficiaire.droit_prive': True,
        'beneficiaire.age': 'foo',
        'beneficiaire.solde_cpf': 'blah',
        'beneficiaire.remuneration': 1200,
        'formation.numero': '23_24',
    }
    with pytest.raises(ValueError) as err:
        validate(data)
    assert err.value.args[0] == {
        'beneficiaire.age': "foo n'est pas de type integer",
        'beneficiaire.solde_cpf': "blah n'est pas de type integer"
    }
