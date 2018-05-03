from trefle.rules import LazyValue


VARIABLES = {
    'age': {
        'type': 'integer'
    },
    'inscrit': {
        'type': 'boolean'
    },
}


def test_lazyvalue_with_string_constant():
    lv = LazyValue('«CDI»', variables={})
    assert lv.get() == 'CDI'


def test_lazyvalue_with_int_constant():
    lv = LazyValue('18', variables={})
    assert lv.get() == 18


def test_lazyvalue_with_float_constant():
    lv = LazyValue('27.45', variables={})
    assert lv.get() == 27.45


def test_lazyvalue_with_int_variable():
    lv = LazyValue('âge du bénéficiaire', variables={'age': {'type': 'int'}})
    assert lv.get(age=27) == 27


def test_lazyvalue_with_bool_variable():
    lv = LazyValue('âge du bénéficiaire', variables={'age': {'type': 'bool'}})
    assert lv.get(age=True) is True
