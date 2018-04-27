import time

from minicli import cli, run
from roll.extensions import simple_server

from .core import simulate
from .config import init
from .rules import LazyValue, VARIABLES
from .api import app


@cli(name='simulate')
def cli_simulate(*args):
    init()
    data = dict(a.split('=') for a in args)
    for key in list(data.keys()):
        # LayValue only knows about labels.
        label = VARIABLES[key]['label']
        data[key] = LazyValue(label).get(**data)
    start = time.perf_counter()
    passed, failed = simulate(**data)
    duration = (time.perf_counter() - start)
    print('*' * 80)
    print('Éligible')
    if passed:
        for financement in passed:
            print('- Nom:', financement.nom)
            print('  Description:', financement.description)
            print('  Démarches:', financement.demarches)
            print('  Organisme:', financement.organisme)
            print('  Financement:', financement.prise_en_charge, '€')
            print('  Rémunération:', financement.remuneration, '€')
            print('')
    else:
        print('_')
    print('*' * 80)
    print('Non éligible')
    if failed:
        for financement in failed:
            print('-', financement.nom)
    else:
        print('—')
    print(f'Duration: {duration} second')


@cli
def serve():
    simple_server(app)


def main():
    run()


if __name__ == '__main__':
    main()
