import os

import pytest

from trefle.metadata import last_modified

pytestmark = pytest.mark.asyncio


async def test_last_modified():
    date = await last_modified('trefle/__init__.py')
    assert date.isoformat() == '2018-12-07T11:18:40+01:00'
