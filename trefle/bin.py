import time
import sys
from pathlib import Path

import hupper
import ujson as json
from minicli import cli, run
from roll.extensions import simple_server, static, traceback

from trefle import simulate, get_financements
from trefle.api import app
from trefle.debugging import data_from_lbf_url, green, make_scenario, red
from trefle.exceptions import DataError
from trefle.helpers import flatten
from trefle.rules import parse_value, SCHEMA


def parse_args(args):
    data = {}
    for arg in args:
        key, value = arg.split('=')
        data[key] = parse_value(value, default=value)
    return data


def colorize(s, status, prefix='✓✗'):
    func = red
    char = f'{prefix[1]} ' if prefix else ''
    if status is True:
        func = green
        char = f'{prefix[0]} ' if prefix else ''
    return func(f'{char}{s}')


def render_status(status, level=0):
    terms = status.terms or [status]
    line = f' {status.condition.connective} '.join(
        colorize(t.condition, t.status, prefix=None) for t in terms)
    prefix = colorize('  '*level, status.status)
    print(f'    {prefix} {line}')
    for child in status.children:
        render_status(child, level=level+1)


@cli(name='simulate')
async def cli_simulate(*args, context: json.loads={}, url=None, trace=False,
                       output_scenario=False, show_context=False, tags=[],
                       show_non_eligible=False):
    """Simulate a call to the API.

    Pass context as args in the form key=value.
    :context: context in json form (for example from a request body).
    :url: Optionnal LBF URL to retrieve context from.
    :trace: Display a trace of all checked conditions.
    :output_scenario: Render a Gherkin scenario with given context.
    :show_context: Render a table with used context.
    :tags: Only return financements matching tags.
    """
    if 'context' in context:
        context = context['context']  # Copy-paste from our logs.
    flatten(context)
    if url:
        context = data_from_lbf_url(url)
    if args:
        context.update(parse_args(args))
    financements = get_financements(tags=tags)
    try:
        start = time.perf_counter()
        await simulate(context, financements)
        duration = (time.perf_counter() - start)
    except DataError as err:
        sys.exit(f'Error in data: {err}')
    except Exception:
        raise
    finally:
        if show_context:
            print('-' * 105)
            tpl = '| {:<50}| {:<50}|'
            print(tpl.format('key', 'value'))
            print('| {0}| {0}|'.format('-'*50))
            for key, value in context.items():
                if key.startswith(('constante', 'financements')):
                    continue
                print(tpl.format(key, str(value)))
            print('-' * 105)
    print('*' * 105)
    eligibles = [f for f in financements if f['eligible']]
    if eligibles:
        print('Financements éligibles\n')
    else:
        print('Aucun financement éligible')
    for financement in eligibles:
        print(financement['nom'])
        for key, value in financement.items():
            if not value or key in ('nom', 'organisme', 'explain', 'tags',
                                    'eligible', 'ressources'):
                continue
            schema = SCHEMA["financement." + key]
            if isinstance(value, str) and len(value) > 100:
                value = f'{value[:100]}…'
            print(f'  {schema["label"]}: {value}')
        if financement.get('organisme'):
            print('  organisme:', financement['organisme']['nom'])
        if trace:
            for status in financement['explain']:
                render_status(status)
        print('-'*80)
    non_eligibles = [f for f in financements if not f['eligible']]
    if non_eligibles and (show_non_eligible or trace):
        print('\nFinancements non éligibles\n')
        for financement in non_eligibles:
            print('-', financement['nom'])
            if trace:
                for status in financement['explain']:
                    render_status(status)
    if output_scenario:
        if url:
            print(f'# {url}')
        print(make_scenario(context, eligibles + non_eligibles))
    print(f'Duration: {round(duration, 4)} second')


def render_trace_condition(condition):
    if condition.terms:
        for sub in condition.terms:
            render_trace_condition(sub)
    else:
        calls = []
        indent = condition.level * 4
        for call in zip(condition._return_values,
                        condition._called_with):
            if call not in calls:
                calls.append(call)
        print(" " * indent, condition)
        for return_value, params in calls:
            func = red
            char = '✗'
            if return_value is True:
                func = green
                char = '✓'
            print(" " * indent, func(f'  {char} {params}'))
    for child in condition.children:
        render_trace_condition(child)


@cli
def serve(reload=False):
    """Run a web server (for development only)."""
    # Debug only.
    static(app, '/explorer/', Path(__file__).parent / 'explorer')
    if reload:
        hupper.start_reloader('trefle.bin.serve')
    traceback(app)
    simple_server(app)


@cli
def test_config():
    """Just load the config."""
    print('Project loaded successfully!')


def main():
    run()


if __name__ == '__main__':
    main()
