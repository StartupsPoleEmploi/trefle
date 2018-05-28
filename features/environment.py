import sys

from trefle.config import ELIGIBILITE, MODALITES
from trefle.debugging import green, red, trace_rule, yellow


def render_condition_coverage(context, condition, indent=0):
    func = red
    char = '✗'
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
                print(" " * indent, " " * 4, "• Returned statuses:",
                      return_values, "({}/2)".format(len(return_values)))
            if condition._called_with:
                print(" " * indent, " " * 4, "• Params:")
                called_with = []
                for p in condition._called_with:
                    if p not in called_with:
                        called_with.append(p)
                for params in called_with:
                    print(" " * indent, " " * 8, params)


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
        trace_rule(rule)


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
                print('—' * 80)
            for condition in rule.conditions:
                if condition.conditions:
                    indent = 4
                    conditions = condition.conditions
                else:
                    indent = 0
                    conditions = [condition]
                for c in conditions:
                    statements += 2
                    new_covered = len(set(c._return_values))
                    covered += new_covered
                    render_condition_coverage(context, c, indent=indent)
                    if format_ != 'summary':
                        if new_covered < int(userdata.get('coverage-exit', 0)):
                            sys.exit('Coverage exited on user request!')
        coverage = round(covered / statements * 100, 2)
        print(f'Coverage: {covered}/{statements} ({coverage}%)', )
        print('-' * 10, 'End coverage report', '-' * 10)
