from http import HTTPStatus
import json

import pytest
from openapi_core import create_spec
from openapi_core.wrappers import MockRequest, MockResponse
from openapi_core.validators import ResponseValidator
from openapi_spec_validator import validate_spec
from roll.extensions import traceback


from pff.api import app as pffapp

pytestmark = pytest.mark.asyncio


@pytest.fixture(scope='session')
def app():
    # Get the traceback in console in case of unhandled error.
    traceback(pffapp)
    yield pffapp


async def test_schema(client, app):
    resp = await client.get('/schema')
    assert resp.status == HTTPStatus.OK
    validate_spec(json.loads(resp.body))


async def test_simulate_endpoint(client, app):
    resp = await client.get('/schema')
    spec = create_spec(json.loads(resp.body))

    resp = await client.post('/simulate', body={
        'beneficiaire.solde_cpf': 10,
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.OK

    validator = ResponseValidator(spec)
    request = MockRequest('http://localhost', 'get', '/simulate')
    response = MockResponse(resp.body, resp.status.value)
    result = validator.validate(request, response)
    result.raise_for_errors()


async def test_simulate_endpoint_with_invalid_data(client, app):
    resp = await client.get('/schema')
    spec = create_spec(json.loads(resp.body))

    resp = await client.post('/simulate', body={
        'beneficiaire.remuneration': 1400,
        'beneficiaire.droit_prive': True,
        'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.UNPROCESSABLE_ENTITY

    # See https://github.com/p1c2u/openapi-core/issues/33
    # validator = ResponseValidator(spec)
    # request = MockRequest('http://localhost', 'get', '/simulate')
    # response = MockResponse(resp.body, resp.status.value)
    # result = validator.validate(request, response)
    # result.raise_for_errors()
