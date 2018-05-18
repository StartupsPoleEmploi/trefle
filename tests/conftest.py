from collections import namedtuple
import pytest

from trefle.rules import LABELS, VARIABLES


@pytest.fixture
def patch_variables():
    before_variables = VARIABLES.copy()
    before_labels = LABELS.copy()

    def patch(new):
        VARIABLES.clear()
        VARIABLES.update(new)
        LABELS.clear()
        LABELS.update({v.get('label'): k for k, v in VARIABLES.items()})

    yield patch
    VARIABLES.clear()
    VARIABLES.update(before_variables)
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
