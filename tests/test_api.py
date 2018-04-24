from http import HTTPStatus
import json

import pytest
from openapi_spec_validator import validate_spec

from pff.api import app as pffapp

pytestmark = pytest.mark.asyncio


@pytest.fixture
def app():
    yield pffapp


async def test_simulate_endpoint(client, app):

    resp = await client.post('/simulate', body={
        'beneficiaire.solde_cpf': 10, 'beneficiaire.entreprise.idcc': 2706})
    assert resp.status == HTTPStatus.OK
    assert 'passed' in json.loads(resp.body)
    assert 'failed' in json.loads(resp.body)


async def test_schema(client, app):
    resp = await client.get('/schema')
    assert resp.status == HTTPStatus.OK
    validate_spec(json.loads(resp.body))
