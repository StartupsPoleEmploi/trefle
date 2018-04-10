from pathlib import Path

import yaml


OPERATORS = {
    '=': '__eq__',
    '>': '__gt__',
    '>=': '__ge__',
    '<': '__lt__',
    '<=': '__le__',
    'CONTIENT': '__contains__',
}
VARIABLES = {}


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


with (Path(__file__).parent / 'config/variables.yml').open() as f:
    VARIABLES.update(load_variables(yaml.safe_load(f.read())))


class Variable:

    def __init__(self, raw):
        self.raw = raw
        if raw in VARIABLES:
            self.set_type()
            self.constant = False
        else:
            self.constant = True
            if self.raw[0] == '«' and self.raw[-1] == '»':
                self.raw = self.raw[1:-1]
            elif self.raw.isdigit():
                self.raw = int(self.raw)

    def set_type(self):
        try:
            self.type = getattr(self, VARIABLES[self.raw]['type'])
        except AttributeError:
            self.type = lambda x: x

    def get(self, data):
        if self.constant:
            return self.raw
        return self.type(data.get(self.raw))

    def bool(self, value):
        return ('OUI' if str(value).lower() in ('oui', 'yes', '1', 'true')
                else 'NON')

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
            self.left = Variable(left)
            self.right = Variable(right)
            if self.operator.startswith('!'):
                self.operator = self.operator[1:]
                self.negative = True

    def assess(self, **data):
        if self.conditions:
            if self.connective == 'OU':
                return any(c.assess(**data) for c in self.conditions)
            return all(c.assess(**data) for c in self.conditions)
        try:
            left = self.left.get(data)
            right = self.right.get(data)
        except (ValueError, TypeError):
            return False
        if left is None or right is None:
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

    def __init__(self, conditions, scenarios):
        self.conditions = conditions
        self.scenarios = [Scenario(name) for name in scenarios]

    def assess(self, **data):
        return all(c.assess(**data) for c in self.conditions)

    @classmethod
    def load(cls, data, conditions=None, rules=None):
        if rules is None:
            rules = []
        if conditions is None:
            conditions = []
        for key, sub in data.items():
            conditions.append(Condition(key))
            if not isinstance(sub, dict):  # We have a leaf.
                rules.append(Rule(conditions, sub))
            else:
                Rule.load(sub, conditions.copy(), rules)
        return rules

    def __repr__(self):
        return f'<Rule: {self.conditions} => {self.scenarios}>'


class Scenario:

    def __init__(self, name):
        self.name = name


def simulate(**data):
    passed, failed = [], []
    for rule in load_rules():
        if rule.assess(**data):
            for scenario in rule.scenarios:
                passed.append(scenario)
        else:
            for scenario in rule.scenarios:
                failed.append(scenario)
    return passed, failed


def load_rules():
    with (Path(__file__).parent / 'config/rules.yml').open() as rules_file:
        data = yaml.safe_load(rules_file.read())
    return Rule.load(data)
