from collections import namedtuple
import pytest

from trefle.rules import LABELS, SCHEMA


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
def mock_get(monkeypatch):
    Response = namedtuple("Response", ('status_code', 'content',))

    def patch(status_code=200, content=''):
        def _get(url):
            return Response(status_code=status_code, content=content)
        monkeypatch.setattr('requests.get', _get)
    return patch
