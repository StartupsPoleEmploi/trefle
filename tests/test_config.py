from trefle.config import load_schema, load_naf


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


def test_load_naf():
    data = """code;name
SECTION A;AGRICULTURE, SYLVICULTURE ET PÊCHE
1;Culture et production animale, chasse et services annexes
1.1;Cultures non permanentes
1.11;Culture de céréales (à l'exception du riz), de légumineuses et de graines oléagineuses
01.11Z;Culture de céréales (à l'exception du riz), de légumineuses et de graines oléagineuses
1.12;Culture du riz
01.12Z;Culture du riz
1.13;Culture de légumes, de melons, de racines et de tubercules
01.13Z;Culture de légumes, de melons, de racines et de tubercules
1.14;Culture de la canne à sucre
01.14Z;Culture de la canne à sucre"""
    assert load_naf(data) == {
        '01': ['0111Z', '0112Z', '0113Z', '0114Z'],
        '011': ['0111Z', '0112Z', '0113Z', '0114Z'],
        '0111': ['0111Z'],
        '0112': ['0112Z'],
        '0113': ['0113Z'],
        '0114': ['0114Z']
    }
