from pathlib import Path

import pytest

from trefle.context import Context
from trefle import exceptions
from trefle import routine


@pytest.mark.asyncio
async def test_populate_formation_from_bytes():
    with Path(__file__).parent.joinpath('data/formation.xml').open('rb') as f:
        context = Context({})
        routine.extrapolate_context(context)
        await routine.populate_formation_from_bytes(context, f.read())
        routine.preprocess(context)

        assert context['formation.eligible_copanef'] is True
        assert context['formation.codes_naf'] == {'0162Z', '0520Z', '2361Z',
                                                  '2362Z', '7820Z', '9604Z',
                                                  '9609Z'}
        assert context['formation.regions_coparef'] == {'24'}
        assert context['formation.codes_formacode'] == {22403, 22402}
        assert context['formation.domaines_formacode'] == {224}
        assert context['formation.foad'] is False
        assert context['formation.niveau_sortie'] == 4
        assert context['formation.heures'] == 697
        assert context['formation.heures_entreprise'] == 112
        assert context['formation.heures_centre'] == 585
        assert context['formation.mois'] == 6
        assert context['formation.semaines'] == 26
        assert context['formation.duree_hebdo'] == 35
        assert context['formation.codes_financeur'] == {10, 5, 2}
        assert context['formation.certifiante'] is True
        assert context['formation.codes_cpf'] == {167204, 13352, 1487, 18320,
                                                  130805}
        assert context['formation.code_certifinfo'] == 80735
        assert context['formation.code_rncp'] == 320
        assert context['formation.rncp'] is True
        assert context['formation.entrees_sorties'] == 0
        assert context['formation.entrees_sorties_permanentes'] is False
        assert context['formation.contrat_apprentissage'] is False
        assert context['formation.contrat_professionnalisation'] is False
        assert context['formation.poec'] is False


@pytest.mark.parametrize('path,key,value', [
    ('without_rncp', 'formation.rncp', False),
    ('vae', 'formation.vae', True),
    ('clea', 'formation.clea', True),
    ('non_certifiante', 'formation.certifiante', False),
    ('certifiante', 'formation.certifiante', True),
    ('objectif_general_formation_certifiante', 'formation.certifiante', True),
    ('wrong_code_financeur_16', 'formation.codes_financeur', {0, 5, 10, 17}),
    ('entrees_sorties_permanentes', 'formation.entrees_sorties', 1),
    ('entrees_sorties_permanentes', 'formation.entrees_sorties_permanentes',
     True),
    ('contrat_apprentissage', 'formation.contrat_apprentissage', True),
    ('contrat_professionnalisation', 'formation.contrat_professionnalisation',
     True),
    ('poec', 'formation.poec', True),
])
@pytest.mark.asyncio
async def test_populate_formation_from_bytes_edge_cases(path, key, value):
    with Path(__file__).parent.joinpath(f'data/{path}.xml').open('rb') as f:
        context = Context({})
        routine.extrapolate_context(context)
        await routine.populate_formation_from_bytes(context, f.read())
        routine.preprocess(context)
        assert context[key] == value


@pytest.mark.asyncio
async def test_populate_formation_from_bytes_with_empty_list():
    content = b"""<?xml version="1.0" encoding="utf-8"?>
                  <lheo xmlns="http://www.lheo.org/2.2">
                  <offres>
                  </offres>
                  </lheo>"""
    context = Context({})
    with pytest.raises(ValueError):
        await routine.populate_formation_from_bytes(context, content)


def test_extrapolate_context_should_set_region():
    context = {'beneficiaire.entreprise.commune': '93031'}
    routine.extrapolate_context(context)
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
    assert await routine.retrieve_codes_naf(ids=['139555', '182860']) == {
        '4764Z', '5520Z', '7010Z', '7721Z'}
