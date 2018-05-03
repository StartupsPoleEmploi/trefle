import inspect
import re

from .exceptions import NoDataError, WrongPointerError

VARIABLES = {}
LABELS = {}


def Label(v):
    """Used as annotation for casting to variable id from variable label."""
    return LABELS[v]


def isfloat(v):
    try:
        float(v)
    except ValueError:
        return False
    return True


def count_indent(s):
    for i, c in enumerate(s):
        if c != ' ':
            return i
    return len(s)


class LazyValue:

    RAW_VALUES = (True, False)

    def __init__(self, raw, variables=VARIABLES):
        self.raw = raw
        self.get = None
        self.compile(variables)

    def __repr__(self):
        return f'<LazyValue: {self.raw}>'

    def compile(self, variables):
        value = ...
        if self.raw in self.RAW_VALUES:
            value = self.raw
        elif self.raw[0] == '«' and self.raw[-1] == '»':
            value = self.raw[1:-1]
        elif self.raw[0] == '[' and self.raw[-1] == ']':
            value = self.raw.split(',')  # TODO: type of members/constante?
        elif self.raw.isdigit():
            value = int(self.raw)
        elif isfloat(self.raw):
            value = float(self.raw)
        else:
            try:
                self.key = LABELS[self.raw]
            except KeyError:
                raise WrongPointerError(self.raw)
            self.get = lambda **d: self._get(**d)
        if value is not ...:
            self.get = lambda **d: value

    def _get(self, **data):
        try:
            return data[self.key]
        except KeyError:
            raise NoDataError(self.raw)


def action(pattern):

    def wrapper(func):
        Action.PATTERNS[pattern] = func
        return func

    return wrapper


def condition(pattern):

    def wrapper(func):
        Condition.PATTERNS[pattern] = func
        return func

    return wrapper


class Step:

    def __repr__(self):
        return f'<{self.__class__.__name__}: {self.raw}>'

    def compile(self):
        for pattern, func in self.PATTERNS.items():
            match = re.match(pattern, self.raw)
            if match:
                self.func = func
                break
        else:
            raise ValueError(f'No pattern match step: {self.raw}')
        data = match.groupdict()
        spec = inspect.signature(self.func)
        for name, param in spec.parameters.items():
            if name == 'data':
                continue
            value = data[name]
            if param.annotation != inspect._empty:
                try:
                    value = param.annotation(value)
                except Exception as err:
                    # Give more context.
                    err.args = (f'{err} (from `{self.raw}`)',)
                    raise
            self.params[name] = value


class Action(Step):

    PATTERNS = {}

    def __init__(self, raw):
        self.raw = raw
        self.func = None
        self.params = {}
        self.compile()

    def act(self, data):
        try:
            self.func(data, **self.params)
        except NoDataError as err:
            raise NoDataError(f'Invalid key "{err}" for {self.raw}')


class Condition(Step):

    PATTERNS = {}

    def __init__(self, raw):
        if raw.startswith(('SI ', 'ET ')):
            raw = raw[3:]
        self.raw = raw
        self.params = {}
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

    def assess(self, **data):
        if self.conditions:
            if self.connective == 'OU':
                return any([c.assess(**data) for c in self.conditions])
            return all([c.assess(**data) for c in self.conditions])
        try:
            return self.func(data, **self.params)
        except NoDataError:
            return False


@action(r"(l'|les? |la )(?P<key>.+) vaut (?P<value>[\w«» +-]+)")
@action(r"(l'|les? |la )(?P<key>.+) est égale? (à la|à|aux?)? (?P<value>[\w«» +-]+)")
def set_value(data, key: Label, value: LazyValue):
    data[key] = value.get(**data)


@action(r"ajouter (?P<value>[\w«» +-]+) aux? (?P<key>.+)")
def add_value(data, key: Label, value: LazyValue):
    if key not in data:
        data[key] = []
    data[key].append(value.get(**data))


@action(r"définir le financement «(?P<name>[\w +-]+)» comme éligible")
def set_financement_eligible(data, name):
    if name not in data['financements']:
        raise ValueError(f'Unknown financement `{name}`')
    data['financements'][name]['eligible'] = True


@condition(r"c'est une? (?P<key>.+)")
def check_true(data, key: LazyValue):
    return key.get(**data) is True


@condition(r"ce n'est pas une? (?P<key>.+)")
def check_false(data, key: LazyValue):
    return key.get(**data) is False


@condition(r"(l'|les? |la )(?P<left>.+) est supérieure? à (?P<right>[\w ]+)")
def check_gt(data, left: LazyValue, right: LazyValue):
    return left.get(**data) > right.get(**data)


@condition(r"(l'|les? |la )(?P<left>.+) est supérieure? ou égale? à (?P<right>[\w ]+)")
def check_ge(data, left: LazyValue, right: LazyValue):
    return left.get(**data) >= right.get(**data)


@condition(r"(l'|les? |la )(?P<left>.+) est inférieure? à (?P<right>[\w ]+)")
def check_lt(data, left: LazyValue, right: LazyValue):
    return left.get(**data) < right.get(**data)


@condition(r"(l'|les? |la )(?P<left>.+) est inférieure? ou égale à (?P<right>[\w ]+)")
def check_le(data, left: LazyValue, right: LazyValue):
    return left.get(**data) <= right.get(**data)


@condition(r"(l'|les? |la )(?P<left>.+) fait partie (de l'|des? |de la |du )(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<right>.+) contient (l'|les? |la )?(?P<left>[ \w«»]+)")
def check_contain(data, left: LazyValue, right: LazyValue):
    return left.get(**data) in right.get(**data)


@condition(r"(l'|les? |la )(?P<left>.+) ne fait pas partie (de l'|des? |de la |du )(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<right>.+) ne contient pas (l'|les? |la )?(?P<left>[ \w«»]+)")
def check_contain(data, left: LazyValue, right: LazyValue):
    return left.get(**data) not in right.get(**data)


@condition(r"(l'|les? |la )(?P<left>.+) (est|vaut) (?P<right>[\w«» +-]+)")
def check_equal(data, left: LazyValue, right: LazyValue):
    return left.get(**data) == right.get(**data)


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
                inner.append(Condition(line[3:]))
                Rule.load(data, curr_indent, inner[:], rules, outer)
        if actions:
            rules.append(Rule(tree, actions))
        return rules

    @staticmethod
    def process(rules, data, failed=None):
        for rule in rules:
            if rule.assess(**data):
                for action in rule.actions:
                    action.act(data)
            elif failed is not None:
                failed.append(rule)

    def __repr__(self):
        return f'<Rule: {self.conditions} => {self.actions}>'
