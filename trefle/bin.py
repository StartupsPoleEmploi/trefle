import time

from minicli import cli, run
from roll.extensions import simple_server

from .api import app
from .config import ELIGIBILITE, MODALITES, SCHEMA
from .core import simulate
from .debugging import data_from_lbf_url, green, make_feature, red, trace_rule


RULES = ELIGIBILITE + MODALITES


def parse_args(args):
    data = {}
    for arg in args:
        key, value = arg.split('=')
        schema = SCHEMA[key]
        if value.startswith('['):
            value = value[1:-1].split(',')  # TODO: Merge with LazyValue?
            if (schema['type'] == 'array'
               and schema['items']['type'] == 'integer'):
                value = [int(v) for v in value]
        data[key] = value
    return data


@cli(name='simulate')
async def cli_simulate(*args, url=None, trace=False, feature=False,
                       show_data=False):
    """Simulate a call to the API.

    Pass data as args in the form key=value.
    :url: Optionnal LBF URL to retrieve data from.
    :trace: Display a trace of all checked conditions.
    :feature: Render a Gherkin Feature with given data.
    :show_data: Render a table with used data.
    """
    data = {}
    if url:
        data = await data_from_lbf_url(url)
    if args:
        data.update(parse_args(args))
    if trace:
        for rule in RULES:
            trace_rule(rule)
    if show_data:
        tpl = '| {:<50}| {:<50}|'
        print(tpl.format('key', 'value'))
        print('| {0}| {0}|'.format('-'*50))
        for key, value in data.items():
            if key.startswith('constante'):
                continue
            print(tpl.format(key, str(value)))
    start = time.perf_counter()
    financements = await simulate(**data)
    duration = (time.perf_counter() - start)
    print('*' * 105)
    print('Éligible')
    eligibles = [f for f in financements if f['eligible']]
    for financement in eligibles:
        if financement.get('eligible'):
            print('- Nom:', financement['nom'])
            print('  Description:', financement['description'][:150], '…')
            print('  Démarches:', financement['demarches'][:150], '…')
            print('  Organisme:')
            print('      Nom:', financement['organisme']['nom'])
            print('      Site web:', financement['organisme']['web'])
            print('  Financement:', financement['prise_en_charge'], '€')
            print('  Rémunération:', financement['remuneration'], '€')
            print('')
    if not financements:
        print('Aucun financement éligible')
    if feature:
        if url:
            print(f'# {url}')
        print(make_feature(data, eligibles))
    if trace:
        render_trace_rules()
    print(f'Duration: {round(duration, 4)} second')


def render_trace_rules():
    for rule in RULES:
        print('—'*105)
        for condition in rule.conditions:
            if condition.conditions:
                conditions = condition.conditions
            else:
                conditions = [condition]
            for condition in conditions:
                calls = []
                for call in zip(condition._return_values,
                                condition._called_with):
                    if call not in calls:
                        calls.append(call)
                print(" " * 4, condition)
                for return_value, params in calls:
                    func = red
                    char = '✗'
                    if return_value is True:
                        func = green
                        char = '✓'
                    print(" " * 8, func(f'{char} {params}'))


@cli
def serve():
    """Run a web server (for development only)."""
    simple_server(app)


def main():
    run()


if __name__ == '__main__':
    main()
