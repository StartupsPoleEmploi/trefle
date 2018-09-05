from datetime import datetime

import pytest
from trefle.context import Context
from trefle.exceptions import DataError
from trefle.helpers import (count_indent, diff_month, diff_week, flatten,
                            fold_name, insee_commune_to_departement,
                            insee_commune_to_region, isfloat)


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


@pytest.mark.parametrize('input,expected', [
    ('AGEFOS PME', 'agefospme'),
    ('Agefos PME', 'agefospme'),
    ('AgéfosPME', 'agefospme'),
])
def test_fold_name(input, expected):
    assert fold_name(input) == expected


@pytest.mark.parametrize('input,expected', [
    ('93031', '11'),  # idf
    ('20000', '94'),  # When consuming postode
    ('97131', '01'),  # Guadeloupe
    ('97231', '02'),  # Martinique
    ('blah', False)
])
def test_insee_commune_to_region(input, expected):
    context = Context({'commune': input})
    if expected:
        insee_commune_to_region(context, 'commune', 'region')
        assert context['region'] == expected
    else:
        with pytest.raises(DataError):
            insee_commune_to_region(context, 'commune', 'region')


@pytest.mark.parametrize('input,expected', [
    ('93031', '93'),  # idf
    ('2A000', '2A'),
    ('97131', '971'),  # Guadeloupe
    ('97631', '976'),  # Mayotte
    ('99999', False),
])
def test_insee_commune_to_departement(input, expected):
    context = Context({'commune': input})
    insee_commune_to_departement(context, 'commune',
                                 'beneficiaire.departement')
    if expected:
        assert context['beneficiaire.departement'] == expected
    else:
        # Invalid enum value prevent to be added in context
        assert 'beneficiaire.departement' not in context
