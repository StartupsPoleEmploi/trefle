import os
from collections import namedtuple
from pathlib import Path

import pytest
from roll.extensions import traceback

from trefle.config import AUTHORIZED
from trefle.rules import LABELS, SCHEMA


@pytest.fixture(scope='session')
def app():
    # Do not import before pytest_configure has run to patch env vars.
    from trefle.api import app as trefleapp
    # Get the traceback in console in case of unhandled error.
    traceback(trefleapp)
    yield trefleapp


@pytest.fixture
def patch_schema():
    before_schema = SCHEMA.copy()
    before_labels = LABELS.copy()

    def patch(new):
        SCHEMA.clear()
        SCHEMA.update(new)
        LABELS.clear()
        LABELS.update({v.get('label'): k for k, v in SCHEMA.items()})

    yield patch
    SCHEMA.clear()
    SCHEMA.update(before_schema)
    LABELS.clear()
    LABELS.update(before_labels)


@pytest.fixture
def patch_authorisations():
    before = AUTHORIZED.copy()

    def patch(new):
        AUTHORIZED.clear()
        AUTHORIZED.extend(new)

    yield patch
    AUTHORIZED.clear()
    AUTHORIZED.extend(before)


@pytest.fixture
def mock_get(monkeypatch):
    class Response:
        def __init__(self, status_code, content):
            self.status_code = status_code
            self.content = content

        def json(self):
            return self.content

    def patch(status_code=200, content=''):
        def _get(url):
            return Response(status_code=status_code, content=content)
        monkeypatch.setattr('requests.get', _get)
    return patch


def pytest_configure(config):
    logs_dir = '/tmp/trefle-tests'
    os.environ['TREFLE_LOG_DIR'] = logs_dir
    Path(logs_dir).mkdir(exist_ok=True)
