import unittest.mock
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
        data = {}
        routine.populate_formation_from_bytes(data, f.read())

        assert data['formation.eligible_copanef'] is True
        assert data['formation.codes_naf'] == {'01.62Z', '05.20Z', '23.61Z',
                                               '23.62Z', '78.20Z', '96.04Z',
                                               '96.09Z'}
        assert data['formation.regions'] == {'24'}
        assert data['formation.codes_formacode'] == ['22403', '22402']
        assert data['formation.domaines_formacode'] == {'224'}
        assert data['formation.foad'] is False
        assert data['formation.niveau_sortie'] == 4


@pytest.mark.asyncio
async def test_populate_formation_upstream_error(mock_get):
    mock_get(status_code=500)
    with pytest.raises(exceptions.UpstreamError):
        await routine.populate_formation({'formation.numero': 'ZORGLUB'})
