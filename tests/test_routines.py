import datetime
import json
from pathlib import Path

import pytest

from trefle.config import IDCC
from trefle.context import Context
from trefle import exceptions
from trefle import routine


@pytest.mark.asyncio
async def test_populate_formation_from_json():
    with Path(__file__).parent.joinpath('data/formation.json').open('rb') as f:
        context = Context({})
        await routine.populate_formation_from_json(context, json.loads(f.read()))
        routine.extrapolate_context(context)
        routine.preprocess(context)

        assert context['formation.eligible_cpf'] is False
        assert context['formation.codes_naf'] == {'0162Z', '0520Z', '2361Z',
                                                  '4399E', '7820Z', '9604Z',
                                                  '9609Z'}
        assert context['formation.codes_formacode'] == {22403, 22402}
        assert context['formation.domaines_formacode'] == {224}
        assert context['formation.foad'] is False
        assert context['formation.niveau_sortie'] == 4
        assert context['formation.heures'] == 697
        assert context['formation.heures_entreprise'] == 112
        assert context['formation.heures_centre'] == 585
        assert context['formation.mois'] == 7
        assert context['formation.semaines'] == 31
        assert context['formation.duree_hebdo'] == 35
        assert context['formation.codes_financeur'] == {2}
        assert context['formation.certifiante'] is True
        assert context['formation.professionnalisante'] is False
        assert context['formation.codes_cpf'] == {233155, 167204, 222991, 18320, 1487,
                                                  130805, 227989, 222905}
        assert context['formation.codes_cpf_de'] == {233155, 130805, 232054}
        assert context['formation.code_certifinfo'] == 80735
        assert context['formation.code_rncp'] == 320
        assert context['formation.rncp'] is True
        assert context['formation.entrees_sorties_permanentes'] is False
        assert context['formation.contrat_apprentissage'] is False
        assert context['formation.contrat_professionnalisation'] is False
        assert context['formation.poec'] is False
        assert context['formation.departement'] == '37'
        assert context['formation.region'] == '24'
        assert context['formation.siret_organisme'] == 82436343600497
        assert context['formation.intitule'] == "Titre professionnel plaquiste"


@pytest.mark.parametrize('path,key,value', [
    ('without_rncp', 'formation.rncp', False),
    ('vae', 'formation.vae', True),
    ('clea', 'formation.clea', True),
    ('non_certifiante', 'formation.certifiante', False),
    ('certifiante', 'formation.certifiante', True),
    ('objectif_general_formation_certifiante', 'formation.certifiante', True),
    ('non_professionnalisante', 'formation.professionnalisante', False),
    ('professionnalisante', 'formation.professionnalisante', True),
    ('wrong_code_financeur_16', 'formation.codes_financeur', {2, 10}),
    ('entrees_sorties_permanentes', 'formation.entrees_sorties_permanentes',
     True),
    ('contrat_apprentissage', 'formation.contrat_apprentissage', True),
    ('contrat_professionnalisation', 'formation.contrat_professionnalisation',
     True),
    ('poec', 'formation.poec', True),
    ('heures_centre_empty', 'formation.heures_centre', 585),
    ('daeu', 'formation.daeu', True),
    ('daeu', 'formation.enseignement_superieur', True),
    # deprecated use only for coparef region that doesn't exist anymore
    # ('old_region', 'formation.regions_coparef_de', {'24', '27'}),
    ('with_copanef', 'formation.eligible_cpf', True),
    ('with_codes_modalite_pedagogique', 'formation.foad', True),
])
@pytest.mark.asyncio
async def test_populate_formation_from_json_edge_cases(path, key, value):
    path = Path(__file__).parent / f'data/{path}.json'
    data = json.loads(path.read_text())
    context = Context({})
    await routine.populate_formation_from_json(context, data)
    routine.extrapolate_context(context)
    routine.preprocess(context)
    assert context[key] == value


@pytest.mark.asyncio
async def test_preprocess_should_set_codes_cpf_of_de():
    with Path(__file__).parent.joinpath('data/formation.json').open('rb') as f:
        context = Context({'beneficiaire.inscrit_pe': True})
        await routine.populate_formation_from_json(context, json.loads(f.read()))
        routine.extrapolate_context(context)
        routine.preprocess(context)
        assert context['formation.codes_cpf'] == {233155, 130805, 232054}


def test_extrapolate_context_should_set_region():
    context = {'beneficiaire.entreprise.commune': '93031'}
    routine.extrapolate_context(context)
    assert context['beneficiaire.entreprise.region'] == '11'  # IDF


def test_extrapolate_context_should_set_formation_old_region_to_new_region():
    context = {'formation.region': '26'}  # Bourgogne
    routine.extrapolate_context(context)
    assert context['formation.region'] == '27'  # Bourgogne-Franche-Comté


# depracated since coparef doesn't exist anymore
# def test_extrapolate_context_should_set_coparef_old_region_to_new_region():
#     context = {'formation.regions_coparef': {'26', '53'}}  # Bourgogne / Bretagne
#     routine.extrapolate_context(context)
#     assert context['formation.regions_coparef'] == {'27', '53'}  # Bourgogne-Franche-Comté


@pytest.mark.asyncio
async def test_populate_formation_upstream_error(mock_get):
    mock_get(status_code=500)
    with pytest.raises(exceptions.UpstreamError):
        await routine.populate_formation({'formation.numero': 'ZORGLUB'})


def test_build_catalog_url(monkeypatch):
    fakenow = datetime.datetime(2017, 10, 12, 13, 45, 0)

    class mydate:
        @classmethod
        def utcnow(cls):
            return fakenow
    monkeypatch.setattr(datetime, 'datetime', mydate)
    monkeypatch.setattr('trefle.config.CATALOG_USER', 'foobar')
    monkeypatch.setattr('trefle.config.CATALOG_KEY', 'barfoo')
    monkeypatch.setattr('trefle.config.CATALOG_URL', 'http://catalog.fr')
    assert routine.build_catalog_url('12345') == 'http://catalog.fr?user=foobar&uid=12345&timestamp=2017-10-12T13%3A45%3A00&signature=2aabef68f687ecdbb084e2b1dc930583'


@pytest.mark.parametrize('term', ['coiff', '2596'])
def test_search_idcc_code_by_word(term):
    data = {'2596': {'OPACIF': 'Fongecif',
            'OPCO': 'OPCO Entreprises de proximité',
            'convention collective': 'Convention collective nationale de la coiffure et des professions connexes'}}

    assert routine.search_term(IDCC, term) == data
