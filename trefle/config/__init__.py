import csv
import re
import sys
from collections import defaultdict
from pathlib import Path

import yaml

from ..exceptions import NoStepError, WrongPointerError
from ..helpers import fold_name
from ..rules import Rule, SCHEMA, LABELS, RULES, IDCC


CONSTANTS = {}
FINANCEMENTS = []
ORGANISMES = {}
ROOT = Path(__file__).parent
RAW_RULES = {}
GLOSSARY = {}
NAF = {}
FEATURES = {}

INTERCARIF_URL = 'https://labonneformation.pole-emploi.fr/ws_intercarif'
ELIGIBILITE_URL = 'http://www.intercariforef.org/serviceweb2/eligibilite/?filtre=branche&'


def load_schema(data, output=None, namespace=None):
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
            if 'enum' in more:
                for key, label in more['enum'].items():
                    LABELS[label] = key
            if 'pattern' in more:
                more['pattern'] = re.compile(more['pattern'])
        else:
            load_schema(more, output, ns)
    return output


def load_financements(data, output=None, properties=None, namespace=None):
    if output is None:
        output = []
    if properties is None:
        properties = {}
    if namespace is None:
        namespace = []
    for key, more in data.items():
        props = properties.copy()
        ns = namespace.copy()
        ns.append(key)
        props['tags'] = ns
        if isinstance(more, dict):
            for subkey, value in more.items():
                if isinstance(value, dict):
                    load_financements({subkey: value}, output, props, ns)
                else:
                    props[subkey] = value
            if 'nom' in more:
                output.append(props)
    return output


def load_naf(data):
    # Data from https://www.insee.fr/fr/information/2406147
    from ..validators import format_naf
    out = defaultdict(list)
    reader = csv.DictReader(data.split('\n'), delimiter=';')
    for line in reader:
        if not line or len(line['code']) != 6:
            continue
        code = format_naf(line['code'])
        for i in range(2, len(code)):
            out[code[:i]].append(code)
    return out


def load_rules(path):
    with path.open() as rules_file:
        data = rules_file.read()
        id_ = str(path.relative_to(ROOT))
        RAW_RULES[id_] = {
            'data': data,
            'path': id_,
            'name': path.name,
        }
        try:
            return id_, Rule.load(data.splitlines(), id_)
        except (NoStepError, WrongPointerError) as err:
            sys.exit(f'Project loading failed: {err!r}')


def load_dir_rules(root):
    paths = (root).glob('**/*.rules')
    for path in sorted(paths, key=lambda p: p.name.lower()):
        yield load_rules(path)


def load_features():
    paths = (ROOT / 'features').glob('*.feature')
    for path in sorted(paths, key=lambda p: p.name.lower()):
        raw = path.read_text()
        id_ = str(path.relative_to(ROOT))
        FEATURES[id_] = {
            'raw': raw,
            'path': id_,
            'name': path.stem,
        }


def init():
    print('Initializing config')
    with (ROOT / 'schema.yml').open() as f:
        SCHEMA.update(load_schema(yaml.safe_load(f.read())))
    for id_, rules in load_dir_rules(ROOT / 'rules'):
        RULES[id_] = rules
    with (ROOT / 'financements.yml').open() as f:
        load_financements(yaml.safe_load(f.read()), FINANCEMENTS)
    with (ROOT / 'organismes.yml').open() as f:
        for name, data in yaml.safe_load(f.read()).items():
            organisme = data
            data['nom'] = name
            ORGANISMES[name] = organisme
            # Also add a folded key, for user input sourced name.
            ORGANISMES[fold_name(name)] = organisme
    with (ROOT / 'idcc.yml').open() as f:
        IDCC.update(yaml.safe_load(f.read()))
    with (ROOT / 'glossaire.yml').open() as f:
        GLOSSARY.update(yaml.safe_load(f.read()))
    with (ROOT / 'naf.csv').open() as f:
        NAF.update(load_naf(f.read()))
    load_features()
    print('Done initializing config')
