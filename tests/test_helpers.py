import datetime

import pytest
from trefle.context import Context
from trefle.exceptions import DataError
from trefle.helpers import (count_indent, diff_month, diff_week, flatten,
                            fold_name, insee_commune_to_departement,
                            insee_departement_to_region, isfloat,
                            calculate_age)


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
    assert diff_month(datetime.datetime(*start), datetime.datetime(*end)) == months


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
    assert diff_week(datetime.datetime(*start), datetime.datetime(*end)) == weeks


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
    ('AGEFOS PME', 'AGEFOSPME'),
    ('Agefos PME', 'AGEFOSPME'),
    ('AgéfosPME', 'AGEFOSPME'),
    ('Agéfos-PME', 'AGEFOSPME'),
    ('Agéfos_PME', 'AGEFOSPME'),
])
def test_fold_name(input, expected):
    assert fold_name(input) == expected


@pytest.mark.parametrize('input,expected', [
    ('93', '11'),  # idf
    ('20', '94'),  # When consuming postode
    ('971', '01'),  # Guadeloupe
    ('972', '02'),  # Martinique
    ('blah', False)
])
def test_insee_departement_to_region(input, expected):
    context = Context({'departement': input})
    if expected:
        insee_departement_to_region(context, 'departement', 'region')
        assert context['region'] == expected
    else:
        with pytest.raises(DataError):
            insee_departement_to_region(context, 'departement', 'region')


def test_insee_departement_to_region_with_alias(patch_schema):
    patch_schema({'departement': {'type': 'string', 'alias': ['departement_habitation']}, 'region': {'type': 'string'}})
    context = Context({'departement_habitation': '35'})
    insee_departement_to_region(context, 'departement', 'region')
    assert context['region'] == '53'


def test_insee_commune_to_departement_with_alias(patch_schema):
    patch_schema({'commune': {'type': 'string', 'alias': ['commune_habitation']}, 'departement': {'type': 'string'}})
    context = Context({'commune_habitation': '35001'})
    insee_commune_to_departement(context, 'commune', 'departement')
    assert context['departement'] == '35'


@pytest.mark.parametrize('input,expected', [
    ('93031', '93'),  # idf
    ('2A000', '2A'),
    ('97131', '971'),  # Guadeloupe
    ('97631', '976'),  # Mayotte
    ('99999', False),
    ('invalide', False),
])
def test_insee_commune_to_departement(input, expected):
    context = Context({'commune': input})
    if expected:
        insee_commune_to_departement(context, 'commune',
                                     'beneficiaire.departement')
        assert context['beneficiaire.departement'] == expected
    else:
        with pytest.raises(DataError):
            insee_commune_to_departement(context, 'commune',
                                         'beneficiaire.departement')

@pytest.mark.parametrize('input,expected', [
    ((1999, 5, 20), 19),
    ((1998, 10, 8), 20),
    ((1998, 1, 1), 20),
    ((1998, 12, 31), 19),
])
def test_calculate_age(input, expected, monkeypatch):
    class mydate:
        @classmethod
        def today(cls):
            return datetime.datetime(2018, 10, 8)
    monkeypatch.setattr(datetime, 'date', mydate)
    assert calculate_age(datetime.datetime(*input)) == expected
