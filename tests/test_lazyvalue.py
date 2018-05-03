from trefle.rules import LazyValue


def test_lazyvalue_with_string_constant():
    lv = LazyValue('«CDI»')
    assert lv.get() == 'CDI'


def test_lazyvalue_with_int_constant():
    lv = LazyValue('18')
    assert lv.get() == 18


def test_lazyvalue_with_float_constant():
    lv = LazyValue('27.45')
    assert lv.get() == 27.45


def test_lazyvalue_with_int_variable(patch_variables):
    patch_variables({'a_key': {'type': 'integer', 'label': 'a label'}})
    lv = LazyValue('a label')
    assert lv.get(a_key=27) == 27


def test_lazyvalue_with_bool_variable(patch_variables):
    patch_variables({'a_key': {'type': 'boolean', 'label': 'a label'}})
    lv = LazyValue('a label')
    assert lv.get(a_key=True) is True
