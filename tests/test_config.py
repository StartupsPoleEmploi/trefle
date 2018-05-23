from trefle.config import load_schema, load_financements


def test_load_schema():
    data = {
        'beneficiaire': {
            'cpf': {
                'type': 'bool',
                'description': 'blah'
            },
            'age': {
                'type': 'int',
                'description': 'bleh'
            },
            'entreprise': {
                'ace': {
                    'type': 'str',
                    'description': 'booh'
                }
            }
        }
    }
    assert load_schema(data) == {
        'beneficiaire.cpf': {
            'type': 'bool',
            'description': 'blah'
        },
        'beneficiaire.age': {
            'type': 'int',
            'description': 'bleh'
        },
        'beneficiaire.entreprise.ace': {
            'type': 'str',
            'description': 'booh'
        },
    }


def test_load_financements():
    data = {
        'cpf': {
            'genre': 'CPF',
            'temps_de_travail': {
                'nom': 'CPF sur son temps de travail',
                'description': 'blah'
            },
            'hors_temps_de_travail': {
                'nom': 'CPF hors temps de travail',
                'description': 'bleuh'
            },
        }
    }
    assert load_financements(data) == {
        'CPF sur son temps de travail': {
            'genre': 'CPF',
            'description': 'blah',
            'nom': 'CPF sur son temps de travail',
        },
        'CPF hors temps de travail': {
            'genre': 'CPF',
            'description': 'bleuh',
            'nom': 'CPF hors temps de travail',
        },
    }
