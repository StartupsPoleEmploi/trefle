import ujson as json

from trefle.config import ELIGIBILITE, MODALITES
from trefle.debugging import green, red, trace_condition, yellow


def render_condition_coverage(context, condition):
    if condition.terms:
        for sub in condition.terms:
            yield from render_condition_coverage(context, sub)
    else:
        func = red
        char = '✗'
        indent = condition.level * 4
        return_values = set(condition._return_values)
        if return_values:
            func = yellow
            char = '~'
            if {False, True} == return_values:
                func = green
                char = '✓'
        if context.config.userdata.get('coverage-format', 'summary') != 'summary':
            print(" " * indent, func(f'{char} {condition}'))
            if context.config.userdata.get('coverage-format') == 'long':
                if return_values:
                    print(" " * indent, "  • Returned statuses:",
                          return_values, "({}/2)".format(len(return_values)))
                if condition._called_with:
                    print(" " * indent, "  • Params:")
                    called_with = []
                    for p in condition._called_with:
                        if p not in called_with:
                            called_with.append(p)
                    for params in called_with:
                        print(" " * indent, " " * 4, params)
        yield len(set(condition._return_values))
    for child in condition.children:
        yield from render_condition_coverage(context, child)


def load_rules(context):
    rules = []
    wanted = context.config.userdata.get('coverage', 'all')
    if wanted in ['all', 'eligibilite']:
        rules.extend(ELIGIBILITE)
    if wanted in ['all', 'modalites']:
        rules.extend(MODALITES)
    return rules


def before_all(context):
    for rule in load_rules(context):
        trace_condition(rule.root)


def after_all(context):
    rules = load_rules(context)
    statements = 0
    covered = 0
    userdata = context.config.userdata
    format_ = userdata.get('coverage-format', 'summary')
    if rules:
        print('-' * 10, 'Rules coverage report', '-' * 10)
        for rule in rules:
            if format_ != 'summary':
                print('\n{:—^50}'.format(rule.name))
            for new_covered in render_condition_coverage(context, rule.root):
                statements += 2
                covered += new_covered
        coverage = round(covered / statements * 100, 2)
        print(f'Coverage: {covered}/{statements} ({coverage}%)', )
        print('-' * 10, 'End coverage report', '-' * 10)


def after_step(context, step):
    if step.status == "failed":
        print('Data was:')
        if 'financements' in context.data:
            del context.data['financements']
        print(json.dumps(context.data))
