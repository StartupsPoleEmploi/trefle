from trefle.rules import Action

SCHEMA = {
    'prix': {
        'type': 'integer',
        'label': 'prix horaire',
    },
    'plafond': {
        'type': 'integer',
        'label': "plafond horaire",
    },
}


def test_set_value_with_constant(patch_schema):
    patch_schema(SCHEMA)
    action = Action('le plafond horaire est égal à 8')
    data = {}
    action.act(data)
    assert data['plafond'] == 8


def test_set_value_with_reference(patch_schema):
    patch_schema(SCHEMA)
    action = Action('le plafond horaire est égal au prix horaire')
    data = {'prix': 18}
    action.act(data)
    assert data['plafond'] == 18


def test_set_percent(patch_schema):
    patch_schema(SCHEMA)
    action = Action('le plafond horaire est égal à 50% du prix horaire')
    data = {'prix': 18}
    action.act(data)
    assert data['plafond'] == 9


def test_unset_key(patch_schema):
    patch_schema(SCHEMA)
    action = Action("il n'y a pas de plafond horaire")
    data = {'plafond': 18}
    action.act(data)
    assert 'plafond' not in data


def test_unset_missing_key(patch_schema):
    patch_schema(SCHEMA)
    action = Action("il n'y a pas de plafond horaire")
    data = {}
    # Should not fail.
    action.act(data)
    assert 'plafond' not in data
