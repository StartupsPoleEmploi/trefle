from http import HTTPStatus
import json

import pytest

from pff.api import app as pffapp

pytestmark = pytest.mark.asyncio


@pytest.fixture
def app():
    yield pffapp


async def test_simulate_endpoint(client, app):

    resp = await client.post('/', body={'beneficiaire.cpf': '10'})
    assert resp.status == HTTPStatus.OK
    assert 'passed' in json.loads(resp.body)
    assert 'failed' in json.loads(resp.body)
