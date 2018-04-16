from pff.rules import LazyValue


VARIABLES = {
    'age': {
        'type': 'int'
    },
    'inscrit': {
        'type': 'bool'
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
    lv = LazyValue('age', variables={'age': {'type': 'int'}})
    assert lv.get(age='27') == 27


def test_lazyvalue_with_bool_variable():
    lv = LazyValue('inscrit', variables={'inscrit': {'type': 'bool'}})
    assert lv.get(inscrit='OUI') is True
