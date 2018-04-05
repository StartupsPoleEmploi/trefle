from minicli import cli, run
from roll.extensions import simple_server

from .core import simulate
from .api import app


@cli(name='simulate')
def cli_simulate(*args):
    data = dict(a.split('=') for a in args)
    passed, failed = simulate(**data)
    print('Éligible')
    print(passed or '—')
    print('Non éligible')
    print(failed or '—')


@cli
def serve():
    simple_server(app)


def main():
    run()


if __name__ == '__main__':
    main()
