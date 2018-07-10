from collections import namedtuple
import inspect
import re

from .exceptions import NoDataError, WrongPointerError, NoStepError
from .helpers import isfloat, count_indent

SCHEMA = {}
LABELS = {}


def Label(v):
    """Used as annotation for casting to variable id from variable label."""
    try:
        return LABELS[v]
    except KeyError:
        raise WrongPointerError(v)


class LazyValue:

    def __init__(self, raw):
        self.raw = raw
        self.get = None
        self.default = None
        self.key = None
        self.compile()

    def __repr__(self):
        return f'<LazyValue: {self.raw}>'

    def compile(self):
        value = self.parse_value(self.raw)
        if value is not ...:
            self.get = lambda **d: value
        else:
            try:
                self.key = LABELS[self.raw]
            except KeyError:
                raise WrongPointerError(self.raw)
            self.get = lambda **d: self._get(**d)
            self.default = self.compute_default()

    def parse_value(self, value):
        if value[0] == '«' and value[-1] == '»':
            value = value[1:-1]
            if value in LABELS:
                # This is an enum.
                # FIXME: Should we have a dedicated registry instead?
                value = LABELS[value]
        elif value[0] == '[' and value[-1] == ']':
            value = [self.parse_value(v) for v in value[1:-1].split(',')]
        elif value.isdigit():
            value = int(value)
        elif isfloat(value):
            value = float(value)
        else:
            value = ...
        return value

    def _get(self, **context):
        try:
            value = context[self.key]
        except KeyError:
            value = None
        if value is None:
            if self.default is not ...:
                return self.default
            raise NoDataError(self.raw)
        return value

    def compute_default(self):
        schema = SCHEMA[self.key]
        if 'default' in schema:
            return schema['default']
        elif schema['type'] == 'array':
            return []
        return ...


def action(pattern):

    def wrapper(func):
        Action.PATTERNS[re.compile(pattern)] = func
        func.on_miss = None
        return func

    return wrapper


def condition(pattern):

    def wrapper(func):
        Condition.PATTERNS[re.compile(pattern)] = func
        return func

    return wrapper


def on_miss(target):

    def wrapper(func):
        func.on_miss = target
        return func

    return wrapper


class Status:

    def __init__(self, condition, parent=None):
        self.condition = condition
        self.status = None
        self.terms = []
        self.children = []
        self.parent = parent

    def __bool__(self):
        return self.status

    def __repr__(self):
        return f'<Status {self.condition} => {self.status}'

    @property
    def json(self):
        out = {'condition': str(self.condition), 'status': self.status}
        if self.terms:
            out['terms'] = [t.json for t in self.terms]
            out['connective'] = self.condition.connective
        return out


class Action:

    PATTERNS = {}

    def __init__(self, raw, name=None, line=0):
        self.raw = raw
        self.func = None
        self.params = {}
        self.name = name
        self.line = line
        self.compile()

    def __repr__(self):
        return f'<Action: {self}>'

    def __str__(self):
        return self.raw

    def compile(self):
        for pattern, func in self.PATTERNS.items():
            match = pattern.match(self.raw)
            if match:
                self.func = func
                break
        else:
            raise NoStepError(f'No pattern match action: `{self.raw}`')
        data = match.groupdict()
        spec = inspect.signature(self.func)
        for name, param in spec.parameters.items():
            if name == 'context':
                continue
            value = data[name]
            if param.annotation != inspect._empty:
                try:
                    value = param.annotation(value)
                except Exception as err:
                    # Give more context.
                    err.args = (f'{err} (from `{self.raw}`, {self.name}:{self.line})',)
                    raise
            self.params[name] = value

    def act(self, context):
        try:
            self.func(context, **self.params)
        except NoDataError as err:
            raise NoDataError(f'No data for `{err}` in `{self.raw}`')

    def on_miss(self, context, status):
        if self.func.on_miss:
            self.func.on_miss(status, context, **self.params)


@action(r"(l'|les? |la )(?P<key>.+) (vaut|est) (?P<value>[\w«» +\-'\.]+)$")
@action(r"(l'|les? |la )(?P<key>.+) est égale? (à la|à|aux?)? (?P<value>[\w«» +\-\.']+)$")
def set_value(context, key: Label, value: LazyValue):
    context[key] = value.get(**context)


@action(r"(l'|les? |la )(?P<key>.+) est égale? à (?P<rate>[\d\.]+)% (de la|du) (?P<value>[\w«» +\-\.']+)$")
def set_percent(context, key: Label, rate: float, value: LazyValue):
    context[key] = value.get(**context) * rate / 100


def attach_status(status, context, name):
    conditions = [status.json]
    while status.parent is not None:
        status = status.parent
        conditions.append(status.json)
    conditions.reverse()
    context['financements'][name]['eligibilite'] = conditions


@on_miss(attach_status)
@action(r"définir le financement «(?P<name>[\w +-]+)» comme éligible")
def set_financement_eligible(context, name):
    if name not in context['financements']:
        raise ValueError(f'Unknown financement `{name}`')
    context['financements'][name]['eligible'] = True


@action(r"c'est une? (?P<key>.+)")
def set_true(context, key: Label):
    context[key] = True


@action(r"il n'y a pas de (?P<key>[\w ]+)$")
def unset_key(context, key: Label):
    try:
        del context[key]
    except KeyError:
        pass


class Condition:

    PATTERNS = {}
    AND = 'ET'
    OR = 'OU'

    def __init__(self, terms, parent=None, connective=None, level=0,
                 name=None, line=0):
        assert terms, 'Cannot create a Condition without terms'
        self.parent = parent
        self.params = {}
        self.children = []
        self.actions = []
        self.terms = []
        self.negative = False
        self.connective = connective or self.AND
        self.level = level
        self.name = name
        self.line = line
        if len(terms) == 1:
            terms = terms[0].split(', et ')
            if len(terms) > 1:
                self.connective = self.AND
            else:
                terms = terms[0].split(', ou ')
                if len(terms) > 1:
                    self.connective = self.OR
        self.raw = f' {self.connective} '.join(terms)
        if len(terms) > 1:
            self.terms = [Condition([t], level=self.level, name=self.name,
                                    line=self.line) for t in terms]
        else:
            self.compile()

    def __repr__(self):
        return f'<Condition: {self}>'

    def __str__(self):
        return self.raw

    def compile(self):
        for pattern, func in self.PATTERNS.items():
            match = pattern.match(self.raw)
            if match:
                self.func = func
                break
        else:
            raise NoStepError(f'No pattern match step: `{self.raw}`')
        data = match.groupdict()
        spec = inspect.signature(self.func)
        for name in list(spec.parameters.keys())[1:]:  # Skip context.
            value = data[name]
            try:
                value = LazyValue(value)
            except Exception as err:
                # Give more context.
                err.args = (f'{err} (from `{self.raw}`)',)
                raise
            self.params[name] = value

    def get_params(self, context):
        return {n: v.get(**context) for n, v in self.params.items()}

    def assess(self, context, parent=None, overall=True):
        status = Status(self, parent)
        if self.terms:
            status.terms = [c.assess(context) for c in self.terms]
            if self.connective == self.OR:
                current = any(status.terms)
            else:
                current = all(status.terms)
        else:
            try:
                current = self.func(context, **self.get_params(context))
            except NoDataError:
                current = False
            except Exception as err:
                # Give more context.
                params = ' AND '.join(f'{value.raw}={value.get(**context)}'
                                      for value in self.params.values())
                err.args = (f'{err} (in `{self.raw}`, where {params})',)
                raise
        status.status = current
        overall = overall and current
        if self.actions:
            for action in self.actions:
                if overall:
                    action.act(context)
                else:
                    action.on_miss(context, status)
        # Always call children conditions so we have the whole tree for
        # explaining the situation.
        if self.children:
            for child in self.children:
                child.assess(context, status, overall)
        return status


@condition(r"c'est une? (?P<key>.+)")
def check_true(context, key):
    return key is True


@condition(r"ce n'est pas une? (?P<key>.+)")
def check_false(context, key):
    return key is False


@condition(r"le financement est de type (?P<tag>.+)")
def check_type(context, tag):
    return tag in context['financement.tags']


@condition(r"(l'|les? |la )(?P<left>.+) est supérieure? à (?P<right>[\w ]+)")
def check_gt(context, left, right):
    return left > right


@condition(r"(l'|les? |la )(?P<left>.+) est supérieure? ou égale? à (?P<right>[\w ]+)")
def check_ge(context, left, right):
    return left >= right


@condition(r"(l'|les? |la )(?P<left>.+) est inférieure? à (?P<right>[\w ]+)")
def check_lt(context, left, right):
    return left < right


@condition(r"(l'|les? |la )(?P<left>.+) est inférieure? ou égale? à (?P<right>[\w ]+)")
def check_le(context, left, right):
    return left <= right


@condition(r"(l'|les? |la )(?P<left>.+) contien(nen)?t au moins une? ([^ ]+ )?(parmi|des) (?P<right>[ \[\],\w«»]+)")
def check_share_one(context, left, right):
    return bool(set(left or []) & set(right or []))


# @not_match('{left & right}')
@condition(r"(l'|les? |la )(?P<left>.+) ne contien(nen)?t aucun des (?P<right>[ \w«»]+)")
def check_not_share_one(context, left, right):
    return not bool(set(left or []) & set(right or []))


@condition(r"(l'|les? |la )(?P<left>.+) fait partie (de l'|de la |des? |du )(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<right>.+) contient (l'|les? |la )?(?P<left>[ \w«»]+)")
def check_contain(context, left, right):
    return left in right


@condition(r"(l'|les? |la )(?P<left>.+) ne fait pas partie (de l'|des? |de la |du )(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<right>.+) ne contient pas (l'|les? |la )?(?P<left>[ \w«»]+)")
def check_not_contain(context, left, right):
    return left not in right


@condition(r"(l'|les? |la )(?P<left>.+) (est|vaut) (?P<right>[\w«» +\-\.']+)")
def check_equal(context, left, right):
    return left == right


Line = namedtuple('Line', ['index', 'indent', 'keyword', 'sentence'])


class StopRecursivity(Exception):

    def __init__(self, indent):
        self.indent = indent


class Rule:

    def __init__(self, name, root):
        assert root, 'Cannot create a rule without root'
        self.root = root
        self.name = name

    def assess(self, context):
        return self.root.assess(context)

    @staticmethod
    def iter_lines(iterable):
        previous = Line(0, 0, None, None)
        current = None
        for index, raw in enumerate(iterable):
            indent = count_indent(raw)
            line = raw.strip()
            if not line or line.startswith('#'):
                continue
            keyword, sentence = line.split(maxsplit=1)
            keyword = keyword.lower()
            next_ = Line(index+1, indent, keyword, sentence)
            if current:
                yield (previous, current, next_)
            previous = current
            current = next_
        yield (previous, current, Line(0, 0, None, None))

    @classmethod
    def load(cls, lines, name, rules=None, parent=None):
        if rules is None:
            rules = []
            lines = cls.iter_lines(lines)
        # rules of conditions valid until now (higher indentation ihnerits
        # conditions from lower indentations).
        current = None
        actions = []  # One or more actions of a rule.
        terms = []  # One or more terms of a condition.
        connective = None
        for (prev, curr, next_) in lines:
            assert curr.indent % 4 == 0, f'Wrong indentation: {curr.sentence}'
            if curr.keyword == 'si' or (terms and curr.keyword in ('et', 'ou')):
                terms.append(curr.sentence)
                if not connective and curr.keyword == 'ou':
                    connective = Condition.OR
            elif curr.keyword == 'alors' or (actions and curr.keyword == 'et'):
                actions.append(Action(curr.sentence))
            if actions and (next_.indent < curr.indent or next_.keyword == 'si'):
                parent.actions = actions
                actions = []
            if next_.indent < curr.indent:
                raise StopRecursivity(indent=next_.indent)
                # Move back one step up in recursivity.
            if next_.indent > curr.indent:
                if next_.keyword in ('si', 'alors') and terms:
                    current = Condition(terms[:], parent, connective,
                                        level=int(curr.indent/4), name=name,
                                        line=curr.index)
                    if curr.indent == 0:
                        rules.append(Rule(name, current))
                        parent = current
                    else:
                        parent.children.append(current)
                    terms = []
                    connective = None
                try:
                    Rule.load(lines, name, rules, current)
                except StopRecursivity as err:
                    if err.indent < curr.indent:
                        raise
                    continue  # We are on the right level.
        return rules

    @staticmethod
    def process(rules, context):
        for rule in rules:
            try:
                rule.assess(context)
            except NoDataError as err:
                # Give more context.
                err.args = (f'{err} (from `{rule}`)',)
                raise

    def __repr__(self):
        return f'<Rule: {self.name}>'
