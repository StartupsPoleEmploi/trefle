from datetime import datetime
from pathlib import Path

import pytest

from trefle import exceptions
from trefle import routine


def test_flatten():
    data = {'a': {'b': 'value'}}
    routine.flatten(data)
    assert data == {'a.b': 'value'}


@pytest.mark.asyncio
async def test_populate_formation_from_bytes():
    with Path(__file__).parent.joinpath('data/formation.xml').open('rb') as f:
        context = {}
        routine.add_constants(context)
        await routine.populate_formation_from_bytes(context, f.read())

        assert context['formation.eligible_copanef'] is True
        assert context['formation.codes_naf'] == {'0162Z', '0520Z', '2361Z',
                                                  '2362Z', '7820Z', '9604Z',
                                                  '9609Z'}
        assert context['formation.regions_coparef'] == {'24'}
        assert context['formation.codes_formacode'] == ['22403', '22402']
        assert context['formation.domaines_formacode'] == {'224'}
        assert context['formation.foad'] is False
        assert context['formation.niveau_sortie'] == 4
        assert context['formation.heures'] == 697
        assert context['formation.mois'] == 6
        assert context['formation.semaines'] == 26
        assert context['formation.duree_hebdomadaire'] == 27
        assert context['formation.codes_financeur'] == {10, 5, 2}
        assert context['formation.qualifiante'] is True


@pytest.mark.asyncio
async def test_populate_formation_from_bytes_with_empty_list():
    content = b"""<?xml version="1.0" encoding="utf-8"?>
                  <lheo xmlns="http://www.lheo.org/2.2">
                  <offres>
                  </offres>
                  </lheo>"""
    context = {}
    with pytest.raises(ValueError):
        await routine.populate_formation_from_bytes(context, content)


def test_insee_commune_to_region():
    context = {'beneficiaire.entreprise.commune': '93031'}
    routine.insee_commune_to_region(context)
    assert context['beneficiaire.entreprise.region'] == '11'  # IDF


@pytest.mark.asyncio
async def test_populate_formation_upstream_error(mock_get):
    mock_get(status_code=500)
    with pytest.raises(exceptions.UpstreamError):
        await routine.populate_formation({'formation.numero': 'ZORGLUB'})


@pytest.mark.asyncio
async def test_retrieve_codes_naf(mock_get):
    content = b"""<?xml version="1.0" encoding="utf-8"?>
<eligibilites-cpf>
<statut>OK</statut>
<nombre-resultats>2</nombre-resultats>
<eligibilite-cpf>
<id-cpf>139555</id-cpf>
<branche>47.64Z</branche>
<branche>55.20Z</branche>
<branche>70.10Z</branche>
<branche>77.21Z</branche>
</eligibilite-cpf>
<eligibilite-cpf>
<id-cpf>182860</id-cpf>
</eligibilite-cpf>
</eligibilites-cpf>"""
    mock_get(content=content)
    assert await routine.retrieve_codes_naf(ids=['139555', '182860']) == [
        '47.64Z', '55.20Z', '70.10Z', '77.21Z']


@pytest.mark.parametrize('start,end,months', [
    ((2018, 1, 1), (2018, 5, 31), 5),
    ((2018, 1, 1), (2018, 5, 1), 4),
    ((2018, 1, 31), (2018, 5, 1), 3),
    ((2018, 1, 1), (2019, 5, 31), 17),
])
def test_diff_month(start, end, months):
    assert routine.diff_month(datetime(*start), datetime(*end)) == months


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
    assert routine.diff_week(datetime(*start), datetime(*end)) == weeks
