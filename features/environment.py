from trefle.config import ELIGIBILITE, PRISE_EN_CHARGE, REMUNERATION
from trefle.exceptions import NoDataError


def yellow(s):
    return f'\x1b[1;33m{s}\x1b[0m'


def green(s):
    return f'\x1b[1;32m{s}\x1b[0m'


def red(s):
    return f'\x1b[1;31m{s}\x1b[0m'


def patch_condition(context, condition):
    assess_orig = condition.assess
    context.config.userdata['stats']['statements'] += 2

    def assess_wrapper(**data):
        status = assess_orig(**data)
        condition._return_values.add(status)

        params = {}
        for param in condition.params.values():
            try:
                value = param.get(**data)
            except NoDataError:  # No data were provided for this value.
                value = None
            params[param.raw] = value
        if params not in condition._called_with:
            condition._called_with.append(params)
        return status

    condition.assess = assess_wrapper
    condition._return_values = set()
    condition._called_with = []
    for sub in condition.conditions:
        patch_condition(context, sub)


def patch_rule(context, rule):
    for condition in rule.conditions:
        patch_condition(context, condition)


def compute_condition_coverage(context, condition, indent=0):
    func = red
    char = '✗'
    if condition._return_values:
        func = yellow
        char = '~'
        if {False, True} == condition._return_values:
            func = green
            char = '✓'
    context.config.userdata['stats']['cover'] += len(condition._return_values)
    if context.config.userdata.get('coverage-format', 'summary') != 'summary':
        print(" " * indent, func(f'{char} {condition}'))
        if context.config.userdata.get('coverage-format') == 'long':
            if condition._return_values:
                print(" " * indent, " " * 4, "• Returned statuses:",
                      condition._return_values,
                      "({}/2)".format(len(condition._return_values)))
            if condition._called_with:
                print(" " * indent, " " * 4, "• Params:")
            for params in condition._called_with:
                print(" " * indent, " " * 8, params)


def load_rules(context):
    rules = []
    coverage = context.config.userdata.get('coverage', 'all')
    if coverage in ['all', 'eligibilite']:
        rules.extend(ELIGIBILITE)
    if coverage in ['all', 'remuneration']:
        rules.extend(REMUNERATION)
    if coverage in ['all', 'prise_en_charge']:
        rules.extend(PRISE_EN_CHARGE)
    return rules


def before_all(context):
    context.config.userdata['stats'] = {
        'statements': 0,
        'cover': 0
    }
    rules = load_rules(context)
    for rule in rules:
        patch_rule(context, rule)


def after_all(context):
    rules = load_rules(context)
    stats = context.config.userdata['stats']
    if rules:
        print('-' * 10, 'Rules coverage report', '-' * 10)
        for rule in rules:
            if context.config.userdata.get('coverage-format',
                                           'summary') != 'summary':
                print('—' * 80)
            for condition in rule.conditions:
                if condition.conditions:
                    for c in condition.conditions:
                        compute_condition_coverage(context, c, indent=4)
                else:
                    compute_condition_coverage(context, condition)
        coverage = round(stats['cover'] / stats['statements'] * 100, 2)
        print(f'Coverage: {coverage}%', )
        print('-' * 10, 'End coverage report', '-' * 10)
