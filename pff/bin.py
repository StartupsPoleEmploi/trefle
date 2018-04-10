from minicli import cli, run
from roll.extensions import simple_server

from .core import simulate, LazyValue
from .api import app


@cli(name='simulate')
def cli_simulate(*args):
    data = dict(a.split('=') for a in args)
    for key, value in data.items():
        data[key] = LazyValue(key).get(**data)
    passed, failed = simulate(**data)
    print('*' * 80)
    print('Éligible')
    if passed:
        for scenario in passed:
            print('- Nom:', scenario.name)
            print('  Financement:', scenario.prise_en_charge, 'euros')
            print('')
    else:
        print('_')
    print('*' * 80)
    print('Non éligible')
    if failed:
        for scenario in failed:
            print('-', scenario.name)
    else:
        print('—')


@cli
def serve():
    simple_server(app)


def main():
    run()


if __name__ == '__main__':
    main()
