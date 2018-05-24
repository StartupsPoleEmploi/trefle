from datetime import datetime
from pathlib import Path

import pytest

from trefle import exceptions
from trefle import routine


def test_flatten():
    data = {'a': {'b': 'value'}}
    routine.flatten(data)
    assert data == {'a.b': 'value'}


def test_populate_formation_from_bytes():
    with Path(__file__).parent.joinpath('data/formation.xml').open('rb') as f:
        cotnext = {}
        routine.add_constants(cotnext)
        routine.populate_formation_from_bytes(cotnext, f.read())

        assert cotnext['formation.eligible_copanef'] is True
        assert cotnext['formation.codes_naf'] == {'01.62Z', '05.20Z', '23.61Z',
                                                  '23.62Z', '78.20Z', '96.04Z',
                                                  '96.09Z'}
        assert cotnext['formation.regions_coparef'] == {'24'}
        assert cotnext['formation.codes_formacode'] == ['22403', '22402']
        assert cotnext['formation.domaines_formacode'] == {'224'}
        assert cotnext['formation.foad'] is False
        assert cotnext['formation.niveau_sortie'] == 4
        assert cotnext['formation.heures'] == 697
        assert cotnext['formation.mois'] == 6
        assert cotnext['formation.codes_financeur'] == {10, 5, 2}


def test_populate_formation_from_bytes_with_empty_list():
    content = b"""<?xml version="1.0" encoding="utf-8"?>
                  <lheo xmlns="http://www.lheo.org/2.2">
                  <offres>
                  </offres>
                  </lheo>"""
    context = {}
    with pytest.raises(ValueError):
        routine.populate_formation_from_bytes(context, content)


def test_insee_commune_to_region():
    context = {'beneficiaire.entreprise.commune': '93031'}
    routine.insee_commune_to_region(context)
    assert context['beneficiaire.entreprise.region'] == '11'  # IDF


@pytest.mark.asyncio
async def test_populate_formation_upstream_error(mock_get):
    mock_get(status_code=500)
    with pytest.raises(exceptions.UpstreamError):
        await routine.populate_formation({'formation.numero': 'ZORGLUB'})


@pytest.mark.parametrize('start,end,months', [
    ((2018, 1, 1), (2018, 5, 31), 5),
    ((2018, 1, 1), (2018, 5, 1), 4),
    ((2018, 1, 31), (2018, 5, 1), 3),
])
def test_diff_month(start, end, months):
    assert routine.diff_month(datetime(*start), datetime(*end)) == months
