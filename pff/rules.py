import re
from pathlib import Path

import yaml

from .exceptions import NoDataError, WrongPointerError


VARIABLES = {}
LABELS = {}
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
            if 'label' in more:
                LABELS[more['label']] = name
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

    def __repr__(self):
        return f'<LazyValue: {self.raw}>'

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
                self.key = LABELS[self.raw]
                type_ = getattr(self, variables[self.key]['type'])
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
            return data[self.key]
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

    OPERATORS = {
        'vaut': 'set',
        'est égal': 'set',
        'ajouter': 'add',
    }

    PATTERNS = (
        r"(l'|les? |la )(?P<key>.+) (?P<operator>est égal)e? (à la|à|aux?)? (?P<value>[\w«» +-]+)",
        r"(l'|les? |la )(?P<key>.+) (?P<operator>vaut) (?P<value>[\w«» +-]+)",
        r"(?P<operator>ajouter) (?P<value>[\w«» +-]+) aux? (?P<key>.+)",
    )

    def __init__(self, raw):
        self.raw = raw
        self.compile()

    def __repr__(self):
        return f'<Action: {self.raw}>'

    def compile(self):
        for pattern in self.PATTERNS:
            match = re.match(pattern, self.raw)
            if match:
                break
        else:
            raise ValueError(f'No pattern match action: {self.raw}')
        data = match.groupdict()
        self.key = LABELS[data['key']]
        operator = self.OPERATORS[data['operator']]
        self.func = getattr(self, operator)
        value = data['value']
        try:
            self.value = LazyValue(value)
        except WrongPointerError as err:
            # Give more context.
            raise WrongPointerError(f'{err} does not exist in {self.raw}')

    def do(self, data):
        try:
            value = self.value.get(**data)
            self.func(data, self.key, value)
        except NoDataError as err:
            raise NoDataError(f'Invalid key "{err}" for {self.raw}')

    @staticmethod
    def set(data, key, value):
        data[key] = value

    @staticmethod
    def add(data, key, value):
        if key not in data:
            data[key] = []
        data[key].append(value)


class Condition:

    PATTERNS = (
        r"(?P<operator>c(e n)?'est( pas)?) une? (?P<left>.+)",
        r"(l'|les? |la )(?P<left>.+) (?P<operator>est (supérieure?|inférieure?)( ou égale?)? à) (?P<right>[\w ]+)",
        r"(l'|les? |la )(?P<left>.+) (?P<operator>est|vaut) (?P<right>[\w«» +-]+)",
        r"(l'|les? |la )(?P<right>.+) (?P<operator>(fait|ne fait pas) partie) (de l'|des? |de la |du )(?P<left>.+)",
        r"(l'|les? |la )(?P<left>.+) (?P<operator>contient|ne contient pas) (l'|les? |la )?(?P<right>[ \w«»]+)",
    )
    OPERATORS = {
        "c'est": '__eq__',
        "est supérieur à": '__gt__',
        "est supérieur ou égal à": '__ge__',
        "est supérieure à": '__gt__',
        "est supérieure ou égale à": '__ge__',
        "est inférieur à": '__lt__',
        "est inférieur ou égal à": '__le__',
        "est inférieure à": '__lt__',
        "est inférieure ou égale à": '__le__',
        "est": '__eq__',
        "vaut": '__eq__',
        'fait partie': '__contains__',
        'contient': '__contains__',
    }
    NEGATIVES = {
        "ce n'est pas": "c'est",
        "ne fait pas partie": "fait partie",
        "ne contient pas": "contient",
    }

    def __init__(self, raw):
        if raw.startswith(('SI ', 'ET ')):
            raw = raw[3:]
        self.raw = raw
        self.conditions = []
        self.negative = False
        if ' OU ' in self.raw:
            self.conditions = [Condition(s) for s in self.raw.split(' OU ')]
            self.connective = 'OU'
        elif ' ET ' in self.raw:
            self.conditions = [Condition(s) for s in self.raw.split(' ET ')]
            self.connective = 'ET'
        else:
            self.compile()

    def compile(self):
        for pattern in self.PATTERNS:
            match = re.match(pattern, self.raw)
            if match:
                break
        else:
            raise ValueError(f'No pattern match condition: {self.raw}')
        data = match.groupdict()
        left = data['left']
        operator = data['operator']
        # No right means boolean check.
        right = data.get('right', 'OUI')
        if operator in self.NEGATIVES:
            operator = self.NEGATIVES[operator]
            self.negative = True
        self.operator = self.OPERATORS[operator]
        try:
            self.left = LazyValue(left)
            self.right = LazyValue(right)
        except WrongPointerError as err:
            # Give more context.
            raise WrongPointerError(f'{err} does not exist in {self.raw}')

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
        result = getattr(left, self.operator)(right)
        if self.negative:
            return not result
        return result

    def extract(self, data):
        return data.get(self.key)

    def __repr__(self):
        return f'<Condition: {self.raw}>'


class Rule:

    def __init__(self, conditions, actions):
        assert conditions, 'Cannot create a rule without conditions'
        self.conditions = conditions
        self.actions = actions

    def assess(self, **data):
        return all(c.assess(**data) for c in self.conditions)

    @classmethod
    def load(cls, data, prev_indent=0, tree=None, rules=None, outer=None):
        if rules is None:
            rules = []
            data = iter(data)
        if tree is None:
            tree = []
        if outer is None:
            outer = []
        actions = []
        while True:
            if outer:
                raw = outer[0]
                outer.clear()
            else:
                try:
                    raw = next(data)
                except StopIteration:
                    break
            if not raw:
                continue
            curr_indent = count_indent(raw)
            line = raw.strip()
            if line.startswith('#'):
                continue
            if line.startswith('ALORS '):
                actions.append(Action(line[6:]))
                prev_indent = curr_indent
            else:
                if actions:
                    rules.append(Rule(tree[:], actions))
                    outer.clear()
                    actions = []
                if curr_indent < prev_indent:
                    outer.append(raw)
                    break
                inner = tree[:]
                outer.clear()
                inner.append(Condition(line))
                Rule.load(data, curr_indent, inner[:], rules, outer)
        if actions:
            rules.append(Rule(tree, actions))
        return rules

    @staticmethod
    def process(rules, data, failed=None):
        for rule in rules:
            if rule.assess(**data):
                for action in rule.actions:
                    action.do(data)
            elif failed is not None:
                for action in rule.actions:
                    failed.append(Scenario(action.value.get()))

    def __repr__(self):
        return f'<Rule: {self.conditions} => {self.actions}>'


class Scenario:

    def __init__(self, name):
        self.name = name
        self.organisme = None
        self.prise_en_charge = None
        self.remuneration = None

    def __repr__(self):
        return f'<Scenario: {self.name}'

    def __call__(self, **data):
        data.update({'scenario.nom': self.name,
                     'scenario.genre': self.name.split('.')[0].upper()})
        # TODO: use a routine and make it dynamic with scenario type
        self.organisme = data['beneficiaire.entreprise.opca']
        data.update({'organisme.nom': self.organisme})
        Rule.process(PRISE_EN_CHARGE, data)
        Rule.process(REMUNERATION, data)
        # TODO: type should come from the variables.yml entry type
        heures = data['beneficiaire.solde_cpf']
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
    with path.open() as rules_file:
        return Rule.load(rules_file.readlines())


def count_indent(s):
    for i, c in enumerate(s):
        if c != ' ':
            return i
    return len(s)


with (ROOT / 'config/variables.yml').open() as f:
    VARIABLES.update(load_variables(yaml.safe_load(f.read())))
PRISE_EN_CHARGE = []
for path in (ROOT / 'config/prise_en_charge').glob('*.yml'):
    PRISE_EN_CHARGE.extend(load_rules(path))
REMUNERATION = load_rules(ROOT / 'config/remuneration.yml')
RULES = load_rules(Path(__file__).parent / 'config/rules.yml')
