from pff.rules import load_variables


def test_load_variables():
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
    assert load_variables(data) == {
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
