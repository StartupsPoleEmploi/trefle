from pathlib import Path

import yaml

from .rules import Rule, VARIABLES, LABELS


CONSTANTS = {}
PRISE_EN_CHARGE = []
REMUNERATION = []
ELIGIBILITE = []
FINANCEMENTS = {}
ROOT = Path(__file__).parent


def load_variables(data, output=None, namespace=None):
    if output is None:
        output = {}
    if namespace is None:
        namespace = []
    for key, more in data.items():
        ns = namespace.copy()
        ns.append(key)
        if 'type' in more:  # We have a variable.
            name = '.'.join(ns)
            output[name] = more
            if ns[0] == 'constante':
                CONSTANTS[name] = more['value']
            if 'label' in more:
                LABELS[more['label']] = name
        else:
            load_variables(more, output, ns)
    return output


def load_financements(data, output=None, properties=None):
    if output is None:
        output = {}
    if properties is None:
        properties = {}
    for key, more in data.items():
        props = properties.copy()
        if isinstance(more, dict):
            for subkey, value in more.items():
                if isinstance(value, dict):
                    load_financements(more, output, props)
                else:
                    props[subkey] = value
            if 'nom' in more:
                output[more['nom']] = props
    return output


def load_rules(path):
    with path.open() as rules_file:
        return Rule.load(rules_file.readlines())


def init():
    print('Initializing config')
    with (ROOT / 'config/variables.yml').open() as f:
        VARIABLES.update(load_variables(yaml.safe_load(f.read())))
    for path in (ROOT / 'config/prise_en_charge').glob('*.rules'):
        PRISE_EN_CHARGE.extend(load_rules(path))
    REMUNERATION.extend(load_rules(ROOT / 'config/remuneration.rules'))
    ELIGIBILITE.extend(
        load_rules(Path(__file__).parent / 'config/eligibilite.rules'))
    with (ROOT / 'config/financements.yml').open() as f:
        load_financements(yaml.safe_load(f.read()), FINANCEMENTS)
