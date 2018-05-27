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
        'CPF': {
            'temps de travail': {
                'nom': 'CPF sur son temps de travail',
                'description': 'blah'
            },
            'hors temps de travail': {
                'nom': 'CPF hors temps de travail',
                'description': 'bleuh'
            },
        }
    }
    assert load_financements(data) == {
        'CPF sur son temps de travail': {
            'tags': ['CPF', 'temps de travail'],
            'description': 'blah',
            'nom': 'CPF sur son temps de travail',
        },
        'CPF hors temps de travail': {
            'tags': ['CPF', 'hors temps de travail'],
            'description': 'bleuh',
            'nom': 'CPF hors temps de travail',
        },
    }
