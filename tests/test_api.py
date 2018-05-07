from http import HTTPStatus
import json

import pytest
from openapi_core import create_spec
from openapi_core.wrappers import MockRequest, MockResponse
from openapi_core.validators import ResponseValidator
from openapi_spec_validator import validate_spec
from roll.extensions import traceback


from trefle.api import app as trefleapp

pytestmark = pytest.mark.asyncio


@pytest.fixture(scope='session')
def app():
    # Get the traceback in console in case of unhandled error.
    traceback(trefleapp)
    yield trefleapp


async def test_schema(client, app):
    resp = await client.get('/schema')
    assert resp.status == HTTPStatus.OK
    validate_spec(json.loads(resp.body))


async def test_simulate_endpoint(client, app):
    resp = await client.get('/schema')
    spec = create_spec(json.loads(resp.body))

    resp = await client.post('/financement', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_copanef': True,
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.OK
    assert 'financements' in json.loads(resp.body)
    financements = json.loads(resp.body)['financements']
    assert len(financements)
    assert financements[0].get('eligible')

    validator = ResponseValidator(spec)
    request = MockRequest('http://localhost', 'post', '/financement')
    response = MockResponse(resp.body, resp.status.value)
    result = validator.validate(request, response)
    result.raise_for_errors()


async def test_simulate_endpoint_filter_eligible(client, app):
    body = {
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.contrat': 'cdi',
        'formation.eligible_copanef': True,
        'beneficiaire.entreprise.idcc': 2706
    }
    # Normal request.
    resp = await client.post('/financement', body=body)
    assert resp.status == HTTPStatus.OK
    financements = json.loads(resp.body)['financements']
    assert len(financements) == 10
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
    assert len(financements) == 8
    for financement in financements:
        assert financement['eligible'] is False


async def test_simulate_endpoint_with_wrong_method(client, app):
    resp = await client.get('/financement')
    assert resp.status == HTTPStatus.METHOD_NOT_ALLOWED
    assert 'application/json' in resp.headers['Content-Type']


async def test_simulate_endpoint_with_empty_data(client, app):
    resp = await client.post('/financement', body='')
    assert resp.status == HTTPStatus.BAD_REQUEST
    assert 'application/json' in resp.headers['Content-Type']


async def test_simulate_endpoint_with_invalid_data(client, app):
    resp = await client.get('/schema')
    spec = create_spec(json.loads(resp.body))

    resp = await client.post('/financement', body={
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.UNPROCESSABLE_ENTITY
    assert 'application/json' in resp.headers['Content-Type']

    # See https://github.com/p1c2u/openapi-core/issues/33
    # validator = ResponseValidator(spec)
    # request = MockRequest('http://localhost', 'post', '/financement')
    # response = MockResponse(resp.body, resp.status.value)
    # result = validator.validate(request, response)
    # result.raise_for_errors()
