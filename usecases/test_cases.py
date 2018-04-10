from pathlib import Path

import yaml

from pff.core import simulate


# Magic: Generate tests from yml.
def pytest_generate_tests(metafunc):
    if {'input', 'expected'} <= set(metafunc.fixturenames):
        args = []
        ids = []
        with (Path(__file__).parent / 'cases.yml').open() as fixtures:
            for fixture in yaml.load(fixtures):
                args.append((fixture['entrée'], fixture['sortie']))
                ids.append(fixture.get('description', str(fixture['entrée'])))
            metafunc.parametrize('input,expected', args, ids=ids)


def test_abrev(input, expected):
    assert list(simulate(**input))[0] == (expected or [])
