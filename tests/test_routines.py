from pathlib import Path

from pff import routine


def test_populate_formation():
    with Path(__file__).parent.joinpath('data/formation.xml').open('rb') as f:
        data = {}
        routine.populate_formation_from_bytes(data, f.read())

        assert data['formation.eligible_copanef'] is True
        assert data['formation.codes_naf'] == {'01.62Z', '05.20Z', '23.61Z', '23.62Z', '78.20Z', '96.04Z', '96.09Z'}
        assert data['formation.regions'] == {'24'}
