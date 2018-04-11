from pathlib import Path

import yaml

from . import routine
from .exceptions import NoDataError


OPERATORS = {
    '=': '__eq__',
    'VAUT': '__eq__',
    '>': '__gt__',
    '>=': '__ge__',
    '<': '__lt__',
    '<=': '__le__',
    'CONTIENT': '__contains__',
}
VARIABLES = {}
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
            output['.'.join(ns)] = more
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
        if self.raw in variables:
            try:
                type_ = getattr(self, variables[self.raw]['type'])
            except AttributeError:
                self.get = lambda **d: self._get(**d)
            else:
                self.get = lambda **d: type_(self._get(**d))
        else:
            if self.raw[0] == '«' and self.raw[-1] == '»':
                value = self.raw[1:-1]
            elif self.raw.isdigit():
                value = int(self.raw)
            elif isfloat(self.raw):
                value = float(self.raw)
            elif self.raw.lower() in self.TRUE_VALUES + self.FALSE_VALUES:
                value = self.bool(self.raw)
            else:
                value = self.raw
            self.get = lambda **d: value

    def _get(self, **data):
        try:
            return data[self.raw]
        except KeyError:
            raise NoDataError

    def bool(self, value):
        value = str(value).lower()
        if value in self.TRUE_VALUES:
            return True
        if value in self.FALSE_VALUES:
            return False
        raise ValueError(f'Invalid boolean value for "{self.raw}": "{value}"')

    def int(self, value):
        return int(value)


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
            self.left = LazyValue(left)
            self.right = LazyValue(right)
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

    def __repr__(self):
        return f'<Rule: {self.conditions} => {self.output}>'


class Scenario:

    def __init__(self, name):
        self.name = name

    def __repr__(self):
        return f'<Scenario: {self.name}'

    def __call__(self, **data):
        variables = []
        data = data.copy()
        data.update({'scenario.nom': self.name})
        # TODO: use a routine and make it dynamic with scenario type
        self.organisme = data['beneficiaire.entreprise.opca']
        data.update({'organisme.nom': self.organisme})
        for rule in PRISE_EN_CHARGE:
            if rule.assess(**data):
                variables.append(rule)
        for rule in variables:
            for variable in rule.output:
                dest, src = variable.split(' VAUT ')
                data[dest] = data.get(src, src)
        for rule in REMUNERATION:
            if rule.assess(**data):
                variables.append(rule)
        for rule in variables:
            for variable in rule.output:
                dest, src = variable.split(' VAUT ')
                data[dest] = data.get(src, src)
        # TODO: type should come from the variables.yml entry type
        self.prise_en_charge = (int(data['organisme.taux_horaire'])
                                * data['beneficiaire.cpf'])
        self.remuneration = data.get('scenario.remuneration', None)


def simulate(**data):
    passed, failed = [], []
    routine.idcc_to_opca(data)
    for rule in load_rules(Path(__file__).parent / 'config/rules.yml'):
        if rule.assess(**data):
            for name in rule.output:
                scenario = Scenario(name)
                scenario(**data)
                passed.append(scenario)
        else:
            for scenario in rule.output:
                failed.append(Scenario(scenario))
    return passed, failed


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
