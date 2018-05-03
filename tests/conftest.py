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
