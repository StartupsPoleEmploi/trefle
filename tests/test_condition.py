from trefle.rules import Condition
from trefle.context import Context


SCHEMA = {
    'age': {
        'type': 'integer',
        'label': 'âge du bénéficiaire',
    },
    'contrat': {
        'type': 'str',
        'label': "type de contrat du bénéficiaire",
    },
    'naf': {
        'type': 'str',
        'label': "code naf du bénéficiaire",
    },
    'nafs': {
        'type': 'array',
        'items': {'type': 'string'},
        'label': "codes naf de la formation",
    },
    'nafs_artisanat': {
        'type': 'array',
        'items': {'type': 'string'},
        'label': "codes naf artisanat",
    },
    'inscrit': {
        'type': 'boolean',
        'label': 'bénéficiaire inscrit',
    },
    'certifinfo': {
        'type': 'integer',
        'label': "code certifinfo",
    },
}


def test_boolean_condition(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["c'est un bénéficiaire inscrit"])
    assert condition.assess(Context({'inscrit': True}))
    assert not condition.assess(Context({'inscrit': False}))
    assert not condition.assess(Context({'unknown': True}))


def test_negative_boolean_condition(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["ce n'est pas un bénéficiaire inscrit"])
    assert condition.assess(Context({'inscrit': False}))
    assert not condition.assess(Context({'inscrit': True}))
    assert condition.assess(Context({'unknown': 'X'}))


def test_gt_int_condition(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["l'âge du bénéficiaire est supérieur à 18"])
    assert condition.assess(Context({'age': 19}))
    assert not condition.assess(Context({'age': 17}))
    assert not condition.assess(Context({'age': 18}))


def test_ge_int_condition(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["l'âge du bénéficiaire "
                           "est supérieur ou égal à 18"])
    assert condition.assess(Context({'age': 19}))
    assert condition.assess(Context({'age': 18}))
    assert not condition.assess(Context({'age': 17}))


def test_le_int_condition(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["l'âge du bénéficiaire "
                           "est inférieur ou égal à 18"])
    assert condition.assess(Context({'age': 17}))
    assert condition.assess(Context({'age': 18}))
    assert not condition.assess(Context({'age': 19}))


def test_equal_str_condition(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["le type de contrat du bénéficiaire est «CDD»"])
    assert condition.assess(Context({'contrat': 'CDD'}))
    assert not condition.assess(Context({'contrat': 'CDI'}))
    assert not condition.assess(Context({'inscrit': False}))


def test_equal_OR_combined_condition(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["c'est un bénéficiaire inscrit",
                           "l'âge du bénéficiaire est supérieur à 50"],
                          connective=Condition.OR)
    assert len(condition.terms) == 2
    assert condition.assess(Context({'inscrit': True, 'age': 39}))
    assert condition.assess(Context({'inscrit': False, 'age': 51}))
    assert not condition.assess(Context({'inscrit': False, 'age': 39}))


def test_line_condition_with_OR(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["c'est un bénéficiaire inscrit, ou l'âge du "
                           "bénéficiaire est supérieur à 50"])
    assert len(condition.terms) == 2
    assert condition.assess(Context({'inscrit': True, 'age': 39}))
    assert condition.assess(Context({'inscrit': False, 'age': 51}))
    assert not condition.assess(Context({'inscrit': False, 'age': 39}))


def test_equal_AND_combined_condition(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["c'est un bénéficiaire inscrit",
                           "l'âge du bénéficiaire est supérieur à 50"],
                          connective=Condition.AND)
    assert len(condition.terms) == 2
    assert condition.assess(Context({'inscrit': True, 'age': 60}))
    assert not condition.assess(Context({'inscrit': True, 'age': 49}))


def test_inline_condition_with_AND(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["c'est un bénéficiaire inscrit, et l'âge du "
                           "bénéficiaire est supérieur à 50"])
    assert len(condition.terms) == 2
    assert condition.assess(Context({'inscrit': True, 'age': 60}))
    assert not condition.assess(Context({'inscrit': True, 'age': 49}))


def test_contains_condition(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["le code naf du bénéficiaire fait partie des "
                           "codes naf de la formation"])
    assert condition.assess(Context({'naf': '123', 'nafs': ['123', '456']}))
    assert not condition.assess(Context({'naf': '123', 'nafs': ['456']}))
    assert not condition.assess(Context({'unknown': True}))


def test_contains_condition_with_list_of_str(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["le code naf du bénéficiaire fait partie des "
                           "[«123»,«45»]"])
    assert condition.assess(Context({'naf': '123'}))
    assert not condition.assess(Context({'naf': 123}))
    assert not condition.assess(Context({'naf': '123,45'}))


def test_contains_condition_with_list_of_int(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["le code certifinfo fait partie des "
                           "[123,45]"])
    assert condition.assess(Context({'certifinfo': 123}))
    assert not condition.assess(Context({'certifinfo': '124'}))
    assert not condition.assess(Context({'certifinfo': '125.45'}))


def test_not_contains_condition(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["le code naf du bénéficiaire ne fait pas partie "
                           "des codes naf de la formation"])
    assert not condition.assess(Context({'naf': '123',
                                         'nafs': ['123', '456']}))
    assert condition.assess(Context({'naf': '123', 'nafs': ['456']}))
    assert condition.assess(Context({'unknown': True}))


def test_share_one(patch_schema):
    patch_schema(SCHEMA)
    condition = Condition(["les codes naf de la formation contiennent au "
                           "moins un des codes naf artisanat"])
    assert condition.assess(Context({'nafs': ['123', '124'],
                            'nafs_artisanat': ['123', '456']}))
    assert condition.assess(Context({'nafs': ['123', '124'],
                            'nafs_artisanat': ['123']}))
    assert condition.assess(Context({'nafs': ['123'],
                            'nafs_artisanat': ['123', '456']}))
    assert not condition.assess(Context({'nafs': ['123', '124'],
                                         'nafs_artisanat': ['125', '456']}))
    assert not condition.assess(Context({'nafs_artisanat': ['125', '456']}))
