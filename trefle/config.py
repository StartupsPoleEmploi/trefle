from pathlib import Path
import re

from unidecode import unidecode
import yaml

from .rules import Rule, SCHEMA, LABELS


CONSTANTS = {}
MODALITES = []
ELIGIBILITE = []
FINANCEMENTS = {}
ORGANISMES = {}
ROOT = Path(__file__).parent / 'config'
IDCC = {}
RAW_RULES = {}

INTERCARIF_URL = 'https://labonneformation.pole-emploi.fr/ws_intercarif'
ELIGIBILITE_URL = 'http://www.intercariforef.org/serviceweb2/eligibilite/?filtre=branche&'
DEP_TO_REG = {
    '01': '84', '02': '32', '03': '84', '04': '93', '05': '93', '06': '93',
    '07': '84', '08': '44', '09': '76', '10': '44', '11': '76', '12': '76',
    '13': '93', '14': '28', '15': '84', '16': '75', '17': '75', '18': '24',
    '19': '75', '21': '27', '22': '53', '23': '75', '24': '75', '25': '27',
    '26': '84', '27': '28', '28': '24', '29': '53', '2A': '94', '2B': '94',
    '30': '76', '31': '76', '32': '76', '33': '75', '34': '76', '35': '53',
    '36': '24', '37': '24', '38': '84', '39': '27', '40': '75', '41': '24',
    '42': '84', '43': '84', '44': '52', '45': '24', '46': '76', '47': '75',
    '48': '76', '49': '52', '50': '28', '51': '44', '52': '44', '53': '52',
    '54': '44', '55': '44', '56': '53', '57': '44', '58': '27', '59': '32',
    '60': '32', '61': '28', '62': '32', '63': '84', '64': '75', '65': '76',
    '66': '76', '67': '44', '68': '44', '69': '84', '70': '27', '71': '27',
    '72': '52', '73': '84', '74': '84', '75': '11', '76': '28', '77': '11',
    '78': '11', '79': '75', '80': '32', '81': '76', '82': '76', '83': '93',
    '84': '93', '85': '52', '86': '75', '87': '75', '88': '44', '89': '27',
    '90': '27', '91': '11', '92': '11', '93': '11', '94': '11', '95': '11',
    '97': '06',
}


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
        output = {}
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
                    load_financements(more, output, props, ns)
                else:
                    props[subkey] = value
            if 'nom' in more:
                output[more['nom']] = props
    return output


def load_rules(path):
    with path.open() as rules_file:
        data = rules_file.read()
        RAW_RULES[path.stem] = data
        return Rule.load(data.split('\n'))


# TODO: move in utils?
def fold_name(s):
    return unidecode(s).lower().replace(' ', '')


def init():
    print('Initializing config')
    with (ROOT / 'schema.yml').open() as f:
        SCHEMA.update(load_schema(yaml.safe_load(f.read())))
    ELIGIBILITE.extend(load_rules(ROOT / 'eligibilite.rules'))
    paths = (ROOT / 'modalites').glob('*.rules')
    for path in sorted(paths, key=lambda p: p.name.lower()):
        MODALITES.extend(load_rules(path))
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
    print('Done initializing config')
