from pathlib import Path

import yaml

from pff.core import simulate


# Magic: Generate tests from yml.
def pytest_generate_tests(metafunc):
    if {'input', 'passed', 'failed'} <= set(metafunc.fixturenames):
        args = []
        ids = []
        with (Path(__file__).parent / 'cases.yml').open() as fixtures:
            for fixture in yaml.load(fixtures):
                args.append((fixture['entrée'], fixture['sortie']['éligible'],
                             fixture['sortie']['non éligible']))
                ids.append(str(fixture['entrée']))
            metafunc.parametrize('input,passed,failed', args, ids=ids)


def test_abrev(input, passed, failed):
    assert list(simulate(**input)) == [passed or [], failed or []]
