import json
import os
import urllib.parse
from http import HTTPStatus
from pathlib import Path

import pytest
from openapi_core import create_spec
from openapi_core.wrappers.mock import MockRequest, MockResponse
from openapi_core.shortcuts import ResponseValidator
from openapi_spec_validator import validate_spec


from trefle.config import FINANCEMENTS

pytestmark = pytest.mark.asyncio


async def test_schema(client):
    resp = await client.get('/schema')
    assert resp.status == HTTPStatus.OK
    validate_spec(json.loads(resp.body))


async def test_simulate_endpoint(client):
    resp = await client.get('/schema')
    spec = create_spec(json.loads(resp.body))

    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.OK
    assert 'financements' in json.loads(resp.body)
    financements = json.loads(resp.body)['financements']
    print(financements[0])
    assert financements
    assert financements[0].get('eligible')
    assert 'Version' in resp.headers

    validator = ResponseValidator(spec)
    request = MockRequest('http://trefle.pole-emploi.fr', 'post', '/financement')
    response = MockResponse(resp.body, resp.status.value)
    result = validator.validate(request, response)
    result.raise_for_errors()


async def test_simulate_endpoint_without_formation_prix_horaire(client):
    resp = await client.get('/schema')

    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.OK
    assert 'financements' in json.loads(resp.body)
    financements = json.loads(resp.body)['financements']
    assert financements
    assert financements[0]['prise_en_charge'] is None
    assert financements[0]['plafond_prise_en_charge'] > 0


async def test_simulate_endpoint_with_formation_prix_horaire(client):
    resp = await client.get('/schema')

    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'formation.prix_horaire': 25,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.OK
    assert 'financements' in json.loads(resp.body)
    financements = json.loads(resp.body)['financements']
    assert financements
    assert financements[0]['plafond_prise_en_charge'] > 0
    assert financements[0]['prise_en_charge'] > 0


async def test_simulate_endpoint_filter_eligible(client):
    body = {
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706
    }
    # Normal request.
    resp = await client.post('/financement', body=body)
    assert resp.status == HTTPStatus.OK
    financements = json.loads(resp.body)['financements']
    assert len(financements) == len(FINANCEMENTS)
    # Filter eligible only
    resp = await client.post('/financement?eligible=true', body=body)
    assert resp.status == HTTPStatus.OK
    financements = json.loads(resp.body)['financements']
    assert len(financements) == 2
    for financement in financements:
        assert financement['eligible'] is True
    # Filter non eligible only
    resp = await client.post('/financement?eligible=false', body=body)
    assert resp.status == HTTPStatus.OK
    financements = json.loads(resp.body)['financements']
    assert len(financements) == len(FINANCEMENTS) - 2
    for financement in financements:
        assert financement['eligible'] is False


async def test_simulate_endpoint_filter_tags(client):
    body = {
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706
    }
    # Normal request.
    resp = await client.post('/financement', body=body)
    assert resp.status == HTTPStatus.OK
    financements = json.loads(resp.body)['financements']
    assert len(financements) == len(FINANCEMENTS)
    # Filter CPF only
    resp = await client.post('/financement?tags=CPF', body=body)
    assert resp.status == HTTPStatus.OK
    financements = json.loads(resp.body)['financements']
    assert len(financements) == 3
    for financement in financements:
        assert 'CPF' in financement['tags']


async def test_simulate_endpoint_mix_filters(client):
    body = {
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706
    }
    # Normal request.
    resp = await client.post('/financement', body=body)
    assert resp.status == HTTPStatus.OK
    financements = json.loads(resp.body)['financements']
    assert len(financements) == len(FINANCEMENTS)
    # Filter CPF only
    resp = await client.post('/financement?tags=hors%20temps%20de%20travail'
                             '&eligible=1', body=body)
    assert resp.status == HTTPStatus.OK
    financements = json.loads(resp.body)['financements']
    assert len(financements) == 1


async def test_simulate_hors_temps_de_travail(client):
    body = {
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706
    }
    # Normal request.
    resp = await client.post('/financement', body=body)
    assert resp.status == HTTPStatus.OK
    financements = json.loads(resp.body)['financements']
    assert len(financements) == len(FINANCEMENTS)
    # Filter eligible only
    resp = await client.post('/financement?tags=hors%20temps%20de%20travail'
                             '&eligible=1', body=body)
    assert resp.status == HTTPStatus.OK
    financements = json.loads(resp.body)['financements']
    assert len(financements) == 1


async def test_simulate_triggers_log(client):
    body = {
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706
    }

    log_path = Path(os.environ['TREFLE_LOG_DIR']) / 'trefle-simulate.log'
    log_path.write_text('')
    resp = await client.post('/financement', body=body)
    assert resp.status == 200
    lines = log_path.read_text().splitlines()
    assert len(lines) == 1
    log_data = json.loads(lines[0])
    assert log_data['financements']
    assert 'version' in log_data
    assert 'date' in log_data
    assert not log_data['errors']


async def test_simulate_error_triggers_log(client):
    body = {
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': 'invalide',
        'beneficiaire.entreprise.idcc': 2706
    }

    log_path = Path(os.environ['TREFLE_LOG_DIR']) / 'trefle-simulate.log'
    log_path.write_text('')
    resp = await client.post('/financement', body=body)
    assert resp.status == 422
    lines = log_path.read_text().splitlines()
    assert len(lines) == 1
    log_data = json.loads(lines[0])
    assert not log_data['financements']
    assert 'version' in log_data
    assert 'date' in log_data
    assert 'beneficiaire.entreprise.commune' in log_data['errors']


async def test_simulate_endpoint_with_wrong_method(client):
    resp = await client.get('/financement')
    assert resp.status == HTTPStatus.METHOD_NOT_ALLOWED
    assert 'application/json' in resp.headers['Content-Type']


async def test_simulate_endpoint_with_empty_data(client):
    resp = await client.post('/financement', body='')
    assert resp.status == HTTPStatus.BAD_REQUEST
    assert 'application/json' in resp.headers['Content-Type']


async def test_simulate_endpoint_with_empty_idcc(client):
    resp = await client.get('/schema')

    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': None})
    assert resp.status == HTTPStatus.UNPROCESSABLE_ENTITY
    assert json.loads(resp.body) == {
        'beneficiaire.entreprise.idcc': 'Ce champ est obligatoire'}


async def test_simulate_endpoint_with_invalid_idcc_format(client):
    resp = await client.get('/schema')

    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 'foobar'})
    assert resp.status == HTTPStatus.UNPROCESSABLE_ENTITY
    assert json.loads(resp.body) == {
        'beneficiaire.entreprise.idcc': "Valeur d'IDCC inconnue: `foobar`"}


async def test_simulate_endpoint_with_unknown_idcc(client):
    resp = await client.get('/schema')

    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 1234567})
    assert resp.status == HTTPStatus.UNPROCESSABLE_ENTITY
    assert json.loads(resp.body) == {
        'beneficiaire.entreprise.idcc': "Valeur d'IDCC inconnue: `1234567`"}


@pytest.mark.parametrize('naf', [
    '12345',
    'A1234A',
    '1234AA',
])
async def test_simulate_endpoint_with_invalid_naf(client, naf):
    resp = await client.get('/schema')

    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.naf': naf,
        'beneficiaire.entreprise.idcc': '1486'})
    assert resp.status == HTTPStatus.UNPROCESSABLE_ENTITY
    assert json.loads(resp.body) == {
        'beneficiaire.entreprise.naf': (f"`{naf}` n'est pas au format "
                                        "^\\d{2}\\.?\\d{2}[a-zA-Z]$")}


@pytest.mark.parametrize('insee', [
    '123456',
    'A12345',
])
async def test_simulate_endpoint_with_invalid_insee(client, insee):
    resp = await client.get('/schema')

    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': insee,
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.UNPROCESSABLE_ENTITY
    assert json.loads(resp.body) == {
        'beneficiaire.entreprise.commune': (f"`{insee}` n'est pas au format "
                                            "^(2[AB]|[0-9]{2})[0-9]{3}$")}


async def test_simulate_endpoint_with_unknown_departement(client):
    resp = await client.get('/schema')

    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '99001',
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.UNPROCESSABLE_ENTITY
    assert json.loads(resp.body) == {
        'beneficiaire.entreprise.commune': "Valeur invalide: `99001`"}


async def test_simulate_endpoint_with_invalid_data(client):
    resp = await client.get('/schema')
    spec = create_spec(json.loads(resp.body))

    resp = await client.post('/financement', body={
        'beneficiaire.remuneration': '1400',
        'beneficiaire.droit_prive': 'invalide',
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.UNPROCESSABLE_ENTITY
    assert 'application/json' in resp.headers['Content-Type']

    validator = ResponseValidator(spec)
    request = MockRequest('http://trefle.pole-emploi.fr', 'post', '/financement')
    response = MockResponse(resp.body, resp.status.value)
    result = validator.validate(request, response)
    result.raise_for_errors()


async def test_simulate_endpoint_with_upstream_error(client, mock_get):
    body = {
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.numero': '1234',
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706
    }
    mock_get(status_code=500)
    resp = await client.post('/financement', body=body)

    assert resp.status == HTTPStatus.INTERNAL_SERVER_ERROR
    assert 'UPSTREAM_ERROR' in json.loads(resp.body)['error']


async def test_simulate_endpoint_with_invalid_formation_id(client, mock_get):
    body = {
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.numero': '1234',
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706
    }
    mock_get(status_code=404)
    resp = await client.post('/financement', body=body)

    assert resp.status == HTTPStatus.UNPROCESSABLE_ENTITY
    assert json.loads(resp.body) == {
        'error': 'Error with id `1234`: `No formation found`'}


async def test_remuneration_parsing_should_be_liberal(client):
    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': '1600,0 €',
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '12345',
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.OK


async def test_glossary(client):
    resp = await client.get('/explore/glossary')
    assert resp.status == HTTPStatus.OK
    assert 'OPCA' in json.loads(resp.body)


@pytest.mark.parametrize('search_term', [
    1147,
    'cabinets médicaux',
])
async def test_idcc_search(client, search_term):
    resp = await client.get('/idcc?q=' + urllib.parse.quote_plus(str(search_term)))
    assert resp.status == HTTPStatus.OK
    assert json.loads(resp.body) == {"1147": {"convention collective":
                                              "Convention collective du personnel des cabinets médicaux (médecin)",
                                              "OPCO": "OPCO Entreprises de proximité",
                                              "OPACIF": "Fongecif"}
                                     }


async def test_naf_code_search(client):
    resp = await client.get('/naf?q=620')
    assert resp.status == HTTPStatus.OK
    assert json.loads(resp.body) == {
        '6201Z': {'code':'6201Z','name':'Programmation informatique'},
        '6202A': {'code':'6202A','name':'Conseil en systèmes et logiciels informatiques'},
        '6202B': {'code':'6202B','name':'Tierce maintenance de systèmes et d’applications informatiques'},
        '6203Z': {'code':'6203Z','name':"Gestion d'installations informatiques"},
        '6209Z': {'code':'6209Z','name':'Autres activités informatiques'},
        '0620Z': {'code': '0620Z', 'name': 'Extraction de gaz naturel'},
        '2620Z': {'code': '2620Z',
                  'name': "Fabrication d'ordinateurs et d'équipements périphériques"},


    }


async def test_naf_term_search(client):
    resp = await client.get('/naf?q=program')
    assert resp.status == HTTPStatus.OK
    assert json.loads(resp.body) == {
        '6201Z': {'code': '6201Z', 'name': 'Programmation informatique'},
        '4110D': {'code': '4110D', 'name': 'Supports juridiques de programmes'},
        '5911A': {'code': '5911A',
                  'name': 'Production de films et de programmes pour la télévision'},
        '5912Z': {'code': '5912Z',
                  'name': 'Post-production de films cinématographiques, de vidéo et '
                          'de programmes de télévision'},
        '6010Z': {'code': '6010Z', 'name': 'Édition et diffusion de programmes radio'}
    }


#async def test_rules_details(client):
#    resp = await client.post('/financement?eligible=0&explain=1', body={
#        'beneficiaire.solde_cpf': 10,
#        'beneficiaire.remuneration': 1400,
#        'beneficiaire.droit_prive': True,
#        'beneficiaire.contrat': 'cdi',
#        # make sure eligible copanef will be false
#        'formation.regions_coparef': ['11'],
#        'formation.codes_naf': [],
#        'formation.heures': 100,
#        'beneficiaire.entreprise.commune': '2A004',
#        'beneficiaire.entreprise.idcc': 2706})
#    assert resp.status == HTTPStatus.OK
#    assert 'financements' in json.loads(resp.body)
#    financement = json.loads(resp.body)['financements'][0]
#    assert financement['eligible'] is False
#    assert financement['explain']
#    assert financement['explain'][0]['params'] == {
#        'formation.individuels': True
#    }
#    assert 'CPF' in financement['tags']
#    assert not financement['explain'][0]['children'][0]['children'][0]['terms'][1][
#        'status'
#    ]
#    assert (
#        financement['explain'][0]['children'][0]['children'][0]['terms'][1]['reason']
#        == "ce n'est pas formation éligible CPF"
#    )


async def test_simulate_financement_properties(client):
    resp = await client.get('/schema')

    resp = await client.post('/financement?tags=PRF', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_cpf': True,
        'formation.heures': 100,
        'beneficiaire.entreprise.commune': '2A004',
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.OK
    assert 'financements' in json.loads(resp.body)
    financements = json.loads(resp.body)['financements']
    assert financements
    assert financements[0].get('sigle')
    assert financements[0].get('intitule')
    assert financements[0].get('tags')


async def test_explore_financements(client):
    resp = await client.get('/explore/financements')
    financements = json.loads(resp.body)
    assert 'intitule' in financements[0]


async def test_explore_schema(client):
    resp = await client.get('/explore/schema')
    data = json.loads(resp.body)
    assert 'beneficiaire.age' in data


async def test_explore_rules(client):
    resp = await client.get('/explore/rules')
    data = json.loads(resp.body)
    assert 'CPF.rules' in data


async def test_explore_scenarios(client):
    resp = await client.get('/explore/scenarios')
    data = json.loads(resp.body)
    assert 'raw' in data[0]
