from datetime import datetime

import pytest
from trefle.helpers import (count_indent, diff_month, diff_week, flatten,
                            isfloat)


def test_flatten():
    data = {'a': {'b': 'value'}}
    flatten(data)
    assert data == {'a.b': 'value'}


@pytest.mark.parametrize('start,end,months', [
    ((2018, 1, 1), (2018, 5, 31), 5),
    ((2018, 1, 1), (2018, 5, 1), 4),
    ((2018, 1, 31), (2018, 5, 1), 3),
    ((2018, 1, 1), (2019, 5, 31), 17),
])
def test_diff_month(start, end, months):
    assert diff_month(datetime(*start), datetime(*end)) == months


@pytest.mark.parametrize('start,end,weeks', [
    ((2018, 1, 1), (2018, 1, 3), 1),
    ((2018, 1, 1), (2018, 1, 7), 1),
    ((2018, 1, 1), (2018, 1, 8), 2),
    ((2018, 1, 1), (2018, 5, 31), 22),
    ((2018, 1, 1), (2018, 5, 1), 18),
    ((2018, 1, 31), (2018, 5, 1), 13),
    ((2018, 1, 1), (2019, 5, 31), 74),
    ((2018, 1, 1), (2019, 1, 1), 53),
])
def test_diff_week(start, end, weeks):
    assert diff_week(datetime(*start), datetime(*end)) == weeks


@pytest.mark.parametrize('input,expected', [
    ('', 0),
    ('    ', 4),
    ('    x', 4),
])
def test_count_indent(input, expected):
    assert count_indent(input) == expected


@pytest.mark.parametrize('input,expected', [
    (4.5, True),
    ('4.5', True),
    (4, True),
    (None, False),
    ('', False),
])
def test_isfloat(input, expected):
    assert isfloat(input) == expected
