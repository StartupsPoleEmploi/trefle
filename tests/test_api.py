from http import HTTPStatus
import json

import pytest
from openapi_core import create_spec
from openapi_core.wrappers import MockRequest, MockResponse
from openapi_core.validators import ResponseValidator
from openapi_spec_validator import validate_spec


from pff.api import app as pffapp

pytestmark = pytest.mark.asyncio


@pytest.fixture
def app():
    yield pffapp


async def test_schema(client, app):
    resp = await client.get('/schema')
    assert resp.status == HTTPStatus.OK
    validate_spec(json.loads(resp.body))


async def test_simulate_endpoint(client, app):
    resp = await client.get('/schema')
    spec = create_spec(json.loads(resp.body))

    resp = await client.post('/simulate', body={
        'beneficiaire.solde_cpf': 10, 'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.OK

    validator = ResponseValidator(spec)
    request = MockRequest('http://localhost', 'get', '/simulate')
    response = MockResponse(resp.body, resp.status.value)
    result = validator.validate(request, response)
    result.raise_for_errors()
