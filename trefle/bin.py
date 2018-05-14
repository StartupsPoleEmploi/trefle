import time

from minicli import cli, run
from roll.extensions import simple_server

from .core import simulate
from .rules import LazyValue, VARIABLES
from .api import app


@cli(name='simulate')
async def cli_simulate(*args):
    data = dict(a.split('=') for a in args)
    for key in list(data.keys()):
        # LayValue only knows about labels.
        label = VARIABLES[key]['label']
        data[key] = LazyValue(label).get(**data)
    start = time.perf_counter()
    financements = await simulate(**data)
    duration = (time.perf_counter() - start)
    print('*' * 80)
    print('Éligible')
    for financement in financements:
        if financement.get('eligible'):
            print('- Nom:', financement['nom'])
            print('  Description:', financement['description'][:150], '…')
            print('  Démarches:', financement['demarches'][:150], '…')
            print('  Organisme:')
            print('      Nom:', financement['organisme']['nom'])
            print('  Financement:', financement['prise_en_charge'], '€')
            print('  Rémunération:', financement['remuneration'], '€')
            print('')
    else:
        print('Aucun financement éligible')
    print(f'Duration: {round(duration, 4)} second')


@cli
def serve():
    simple_server(app)


def main():
    run()


if __name__ == '__main__':
    main()
