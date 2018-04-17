from pathlib import Path

import yaml

from . import routine
from .exceptions import NoDataError, WrongPointerError


OPERATORS = {
    '=': '__eq__',
    '>': '__gt__',
    '>=': '__ge__',
    '<': '__lt__',
    '<=': '__le__',
    'CONTIENT': '__contains__',
}
VARIABLES = {}
CONSTANTS = {}
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
        else:
            load_variables(more, output, ns)
    return output


def isfloat(v):
    try:
        float(v)
    except ValueError:
        return False
    return True


class LazyValue:

    TRUE_VALUES = ('oui', 'yes', 'true')
    FALSE_VALUES = ('non', 'no', 'false')

    def __init__(self, raw, variables=VARIABLES):
        self.raw = raw
        self.get = None
        self.compile(variables)

    def compile(self, variables):
        value = ...
        if self.raw[0] == '«' and self.raw[-1] == '»':
            value = self.raw[1:-1]
        elif self.raw[0] == '[' and self.raw[-1] == ']':
            value = self.raw.split(',')  # TODO: type of members/constante?
        elif self.raw.isdigit():
            value = int(self.raw)
        elif isfloat(self.raw):
            value = float(self.raw)
        elif self.raw.lower() in self.TRUE_VALUES + self.FALSE_VALUES:
            value = self.bool(self.raw)
        else:
            try:
                type_ = getattr(self, variables[self.raw]['type'])
            except AttributeError:
                self.get = lambda **d: self._get(**d)
            except KeyError:
                raise WrongPointerError(self.raw)
            else:
                self.get = lambda **d: type_(self._get(**d))
        if value is not ...:
            self.get = lambda **d: value

    def _get(self, **data):
        try:
            return data[self.raw]
        except KeyError:
            raise NoDataError(self.raw)

    def bool(self, value):
        value = str(value).lower()
        if value in self.TRUE_VALUES:
            return True
        if value in self.FALSE_VALUES:
            return False
        raise ValueError(f'Invalid boolean value for "{self.raw}": "{value}"')

    def int(self, value):
        return int(value)


class Action:

    def __init__(self, raw):
        self.raw = raw
        key, operator, value = raw.split()
        self.key = key
        self.value = LazyValue(value)
        self.func = getattr(self, operator)

    def do(self, data):
        try:
            self.func(data, self.key, self.value.get(**data))
        except NoDataError as err:
            raise NoDataError(f'Invalid key "{err}" for {self.raw}')

    @staticmethod
    def VAUT(data, key, value):
        data[key] = value

    @staticmethod
    def CONTIENT(data, key, value):
        if key not in data:
            data[key] = []
        data[key].append(value)


class Condition:

    def __init__(self, raw):
        if raw.startswith(('SI ', 'ET ')):
            raw = raw[3:]
        self.raw = raw
        self.conditions = []
        self.negative = False
        # TODO: Deal with ()
        if ' OU ' in self.raw:
            self.conditions = [Condition(s) for s in self.raw.split(' OU ')]
            self.connective = 'OU'
        elif ' ET ' in self.raw:
            self.conditions = [Condition(s) for s in self.raw.split(' ET ')]
            self.connective = 'ET'
        else:
            left, self.operator, right = self.raw.split()
            try:
                self.left = LazyValue(left)
                self.right = LazyValue(right)
            except WrongPointerError as err:
                # Give more context.
                raise WrongPointerError(f'{err} does not exist in {self.raw}')
            if self.operator.startswith('!'):
                self.operator = self.operator[1:]
                self.negative = True

    def assess(self, **data):
        if self.conditions:
            if self.connective == 'OU':
                return any([c.assess(**data) for c in self.conditions])
            return all([c.assess(**data) for c in self.conditions])
        try:
            left = self.left.get(**data)
            right = self.right.get(**data)
        except NoDataError:
            return False
        operator = OPERATORS.get(self.operator)
        result = getattr(left, operator)(right)
        if self.negative:
            return not result
        return result

    def extract(self, data):
        return data.get(self.key)

    def __repr__(self):
        return f'<Condition: {self.raw}>'


class Rule:

    def __init__(self, conditions, output):
        self.conditions = conditions
        #TODO rename output to something more clear like "actions"
        self.output = output

    def assess(self, **data):
        return all(c.assess(**data) for c in self.conditions)

    @classmethod
    def load(cls, data, conditions=None, rules=None):
        if rules is None:
            rules = []
        if conditions is None:
            conditions = []
        for key, inner in data.items():
            local = conditions[:]
            if key == 'ALORS':  # We have a leaf.
                rules.append(Rule(local, inner))
            else:
                # TODO: warn/raise if condition already exist in local
                local.append(Condition(key))
                Rule.load(inner, local, rules)
        return rules

    @classmethod
    def process(cls, rules, data, failed=None):
        for rule in rules:
            if rule.assess(**data):
                for raw in rule.output:
                    action = Action(raw)
                    action.do(data)
            elif failed is not None:
                for raw in rule.output:
                    action = Action(raw)
                    failed.append(Scenario(action.right.get()))

    def __repr__(self):
        return f'<Rule: {self.conditions} => {self.output}>'


class Scenario:

    def __init__(self, name):
        self.name = name

    def __repr__(self):
        return f'<Scenario: {self.name}'

    def __call__(self, **data):
        data = data.copy()
        data.update({'scenario.nom': self.name})
        # TODO: use a routine and make it dynamic with scenario type
        self.organisme = data['beneficiaire.entreprise.opca']
        data.update({'organisme.nom': self.organisme})
        Rule.process(PRISE_EN_CHARGE, data)
        Rule.process(REMUNERATION, data)
        # TODO: type should come from the variables.yml entry type
        heures = data['beneficiaire.cpf']
        if ('organisme.plafond_horaire' in data
           and int(data['organisme.plafond_horaire']) < heures):
            heures = int(data['organisme.plafond_horaire'])
        prise_en_charge = int(data['organisme.taux_horaire']) * heures
        if ('organisme.plafond_financier' in data
           and int(data['organisme.plafond_financier']) < prise_en_charge):
            prise_en_charge = int(data['organisme.plafond_financier'])
        self.prise_en_charge = prise_en_charge
        self.remuneration = int(data.get('scenario.remuneration', 0))


def load_rules(path):
    with (path).open() as rules_file:
        data = yaml.safe_load(rules_file.read())
    return Rule.load(data)


with (ROOT / 'config/variables.yml').open() as f:
    VARIABLES.update(load_variables(yaml.safe_load(f.read())))
PRISE_EN_CHARGE = []
for path in (ROOT / 'config/prise_en_charge').glob('*.yml'):
    PRISE_EN_CHARGE.extend(load_rules(path))
REMUNERATION = load_rules(ROOT / 'config/remuneration.yml')
RULES = load_rules(Path(__file__).parent / 'config/rules.yml')
