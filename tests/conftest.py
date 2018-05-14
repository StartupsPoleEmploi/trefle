from collections import namedtuple
import pytest

from trefle.rules import LABELS, VARIABLES


@pytest.fixture
def patch_variables():
    before = VARIABLES.copy()

    def patch(new):
        VARIABLES.clear()
        VARIABLES.update(new)
        LABELS.update({v.get('label'): k for k, v in VARIABLES.items()})

    yield patch
    VARIABLES.clear()
    VARIABLES.update(before)


@pytest.fixture
def mock_get(monkeypatch):
    Response = namedtuple("Response", ('status_code', 'content',))

    def patch(status_code=200, content=''):
        def _get(url):
            return Response(status_code=status_code, content=content)
        monkeypatch.setattr('requests.get', _get)
    return patch
