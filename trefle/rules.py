from collections import namedtuple
import inspect
import re

from .exceptions import NoDataError, WrongPointerError, NoStepError
from .helpers import isfloat, count_indent

SCHEMA = {}
LABELS = {}
RULES = {}


def parse_value(value, default=...):
    if value[0] == '«' and value[-1] == '»':
        value = value[1:-1]
        if value in LABELS:
            # This is an enum.
            # FIXME: Should we have a dedicated registry instead?
            value = LABELS[value]
    elif value[0] == '[' and value[-1] == ']':
        value = [parse_value(v) for v in value[1:-1].split(',')]
    elif value.isdigit():
        value = int(value)
    elif isfloat(value):
        value = float(value)
    else:
        value = default
    return value


def Label(v):
    """Used as annotation for casting to variable id from variable label."""
    try:
        return LABELS[v]
    except KeyError:
        raise WrongPointerError(v)


class Pointer:

    def __init__(self, raw):
        self.raw = raw
        self.get = None
        self.default = None
        self.key = None
        self.compile()

    def __repr__(self):
        return f'<Pointer: {self.raw}>'

    def compile(self):
        value = parse_value(self.raw)
        if value is not ...:
            self.get = lambda **d: value
        else:
            try:
                self.key = LABELS[self.raw]
            except KeyError:
                raise WrongPointerError(self.raw)
            self.get = lambda **d: self._get_from_context(**d)
            self.default = self.compute_default()

    def _get_from_context(self, **context):
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
        return func

    return wrapper


def condition(pattern):

    def wrapper(func):
        Condition.PATTERNS[re.compile(pattern)] = func
        func.reason = None
        func.no_status = False
        return func

    return wrapper


def reason(msg):

    def wrapper(func):
        func.reason = msg
        return func

    return wrapper


def no_status(func):
    # Make this condition not visible for final status output.
    func.no_status = True
    return func


class Value:

    def __init__(self, pointer, context):
        self.value = pointer.get(**context)
        self.pointer = pointer

    def __str__(self):
        return str(self.value or 'aucun(e)')

    @property
    def json(self):
        if self.pointer.key:
            return {self.pointer.key: self.value}


class Status:

    def __init__(self, condition, parent=None):
        self.condition = condition
        self.status = None
        self.terms = []
        self.children = []
        self.parent = parent
        self.params = {}
        self.reason = None

    def __bool__(self):
        return self.status

    def __repr__(self):
        return f'<Status {self.condition} => {self.status}'

    @property
    def json(self):
        out = {'condition': str(self.condition), 'status': self.status,
               'params': {}}
        for param in self.params.values():
            if param.json:
                out['params'].update(param.json)
        if self.terms:
            out['terms'] = [t.json for t in self.terms]
            out['connective'] = self.condition.connective
        elif not self.status:
            out['reason'] = self.reason
        out['children'] = [c.json for c in self.children]
        return out


class Step:

    def __init__(self, path=None, line=0):
        self.func = None
        self.params = {}
        self.path = path
        self.line = line

    def __repr__(self):
        return f'<{self.__class__.__name__}: {self} ({self.path}:{self.line})>'

    def __str__(self):
        return self.raw

    def parse_raw(self):
        for pattern, func in self.PATTERNS.items():
            match = pattern.match(self.raw)
            if match:
                self.func = func
                break
        else:
            raise NoStepError(f'No pattern matches step: `{self!r}`')
        return match.groupdict()

    @property
    def spec(self):
        spec = inspect.signature(self.func)
        return list(spec.parameters.items())[1:]  # Skip `context`.

    def compile(self):
        data = self.parse_raw()
        for name, param in self.spec:
            value = data[name]
            type_ = param.annotation
            if type_ == inspect._empty:
                type_ = self.DEFAULT_TYPE
            try:
                value = type_(value)
            except Exception as err:
                # Give more context.
                err.args = (f'{err} (from `{self!r}`)',)
                raise
            self.params[name] = value


class Action(Step):

    PATTERNS = {}
    DEFAULT_TYPE = str

    def __init__(self, raw, path=None, line=0):
        super().__init__(path, line)
        self.raw = raw
        self.compile()

    def act(self, context):
        try:
            self.func(context, **self.params)
        except NoDataError as err:
            raise NoDataError(f'No data for `{err}` in `{self.raw}`')


class Condition(Step):

    PATTERNS = {}
    AND = 'ET'
    OR = 'OU'
    DEFAULT_TYPE = Pointer

    def __init__(self, terms, connective=None, level=0, path=None, line=0):
        assert terms, 'Cannot create a Condition without terms'
        super().__init__(path, line)
        self.children = []
        self.actions = []
        self.terms = []
        self.negative = False
        self.connective = connective or self.AND
        self.level = level
        if len(terms) == 1:
            terms = terms[0].split(', et ')
            if len(terms) > 1:
                self.connective = self.AND
            else:
                terms = terms[0].split(', ou ')
                if len(terms) > 1:
                    self.connective = self.OR
        if len(terms) > 1:
            self.raw = f' {self.connective} '.join(terms)
            self.terms = [Condition([t], level=self.level, path=self.path,
                                    line=self.line) for t in terms]
        else:
            self.raw = terms[0]
            self.compile()

    def evaluate(self, context):
        return {n: Value(v, context) for n, v in self.params.items()}

    def assess(self, context):
        status = Status(self)
        if self.terms:
            status.terms = [c.assess(context) for c in self.terms]
            if self.connective == self.OR:
                status.status = any(status.terms)
            else:
                status.status = all(status.terms)
        else:
            try:
                status.params = self.evaluate(context)
            except NoDataError as err:
                status.status = False
                status.reason = f"Donnée manquante pour «{err}»"
            except Exception as err:
                # Give more context.
                params = ' AND '.join(f'{key}={value}'
                                      for key, value in status.params.items())
                err.args = (f'{err} (in `{self.raw}`, where {params})',)
                raise
            else:
                status.status = self.func(context, **status.params)
                if not status and self.func.reason:
                    status.reason = self.func.reason.format(**status.params)
        return status

    @property
    def no_status(self):
        return self.func and self.func.no_status


@action(r"le financement est éligible")
def set_eligible(context):
    context['financement.eligible'] = True


@action(r"(l'|les? |la )(?P<key>.+) (vaut|est) (?P<value>[\w«» +\-'\.]+)$")
@action(r"(l'|les? |la )(?P<key>.+) est égale? (à la|à|aux?)? (?P<value>[\w«» +\-\.']+)$")
def set_value(context, key: Label, value: Pointer):
    context[key] = value.get(**context)


@action(r"(l'|les? |la )(?P<key>.+) est égale? à (?P<rate>[\d\.]+)% (de la|du) (?P<value>[\w«» +\-\.']+)$")
def set_percent(context, key: Label, rate: float, value: Pointer):
    context[key] = value.get(**context) * rate / 100


@action(r"c'est une? (?P<key>.+)")
def set_true(context, key: Label):
    context[key] = True


@action(r"appliquer les règles (de )?(l'|le |la )?(?P<rule>.+)")
def include(context, rule: Pointer):
    rule = rule.get(**context)
    name = f'rules/{rule}.rules'
    rules = RULES.get(name)
    for rule in rules:
        status = Rule.process(rule, context)
        if status is not None:  # If root status is a no_status one.
            context['status'].append(status)


@action(r"il n'y a pas de (?P<key>[\w ]+)$")
def unset_key(context, key: Label):
    try:
        del context[key]
    except KeyError:
        pass


@reason("ce n'est pas {key.pointer.raw}")
@condition(r"c'est une? (?P<key>.+)")
def check_true(context, key):
    return key.value is True


@reason("c'est {key.pointer.raw}")
@condition(r"ce n'est pas une? (?P<key>.+)")
def check_false(context, key):
    return key.value is False


@no_status
@reason("le financement n'est pas de type «{tag}»")
@condition(r"le financement est de type (?P<tag>.+)")
def check_type(context, tag):
    return tag.value in context['financement.tags']


@reason("{left.pointer.raw} vaut {left}, c'est inférieur ou égal au seuil de {right}")
@condition(r"(l'|les? |la )(?P<left>.+) est supérieure? à (?P<right>[\w ]+)")
def check_gt(context, left, right):
    return left.value > right.value


@reason("{left.pointer.raw} trop faible: {left}, au lieu de {right} au moins")
@condition(r"(l'|les? |la )(?P<left>.+) est supérieure? ou égale? à (?P<right>[\w ]+)")
def check_ge(context, left, right):
    return left.value >= right.value


@reason("{left.pointer.raw} vaut {left}, c'est supérieur ou égal au seuil ({right})")
@condition(r"(l'|les? |la )(?P<left>.+) est inférieure? à (?P<right>[\w ]+)")
def check_lt(context, left, right):
    return left.value < right.value


@reason("{left.pointer.raw} trop grande: {left} (le maximum est {right})")
@condition(r"(l'|les? |la )(?P<left>.+) est inférieure? ou égale? à (?P<right>[\w ]+)")
def check_le(context, left, right):
    return left.value <= right.value


@reason("«{left}» ne contient pas {right}")
@condition(r"(l'|les? |la )(?P<left>.+) contien(nen)?t au moins une? ([^ ]+ )?(parmi|des) (?P<right>[ \[\],\w«»]+)")
def check_share_one(context, left, right):
    return bool(set(left.value or []) & set(right.value or []))


@reason("«{right}» contient {left}")
@condition(r"(l'|les? |la )(?P<left>.+) ne contien(nen)?t aucun des (?P<right>[ \w«»]+)")
def check_not_share_one(context, left, right):
    return not bool(set(left.value or []) & set(right.value or []))


@reason("{left.pointer.raw} ({left}) ne fait pas partie de «{right.pointer.raw}» ({right})")
@condition(r"(l'|les? |la )(?P<left>.+) fait partie (de l'|de la |des? |du )(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<right>.+) contient (l'|les? |la )?(?P<left>[ \w«»]+)")
def check_contain(context, left, right):
    return left.value in right.value


@reason("{left.pointer.raw} («{left}») fait partie de «{right}»")
@condition(r"(l'|les? |la )(?P<left>.+) ne fait pas partie (de l'|des? |de la |du )(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<right>.+) ne contient pas (l'|les? |la )?(?P<left>[ \w«»]+)")
def check_not_contain(context, left, right):
    return left.value not in right.value


@reason("{left.pointer.raw} vaut «{left}» au lieu de «{right}»")
@condition(r"(l'|les? |la )(?P<left>.+) (est|vaut) (?P<right>[\w«» +\-\.']+)")
def check_equal(context, left, right):
    return left.value == right.value


Line = namedtuple('Line', ['index', 'indent', 'keyword', 'sentence'])


class StopRecursivity(Exception):

    def __init__(self, indent):
        self.indent = indent


class Rule:

    def __init__(self, name, root):
        assert root, 'Cannot create a rule without root'
        self.root = root
        self.name = name

    def assess(self, context, condition=None, parent=None, overall=True):
        if condition is None:
            condition = self.root
        status = condition.assess(context)
        overall = overall and status
        if not status and status.condition.no_status:
            # Stop recursion.
            return parent
        elif parent is not None:
            status.parent = parent
            parent.children.append(status)
        for action in condition.actions:
            if overall:
                action.act(context)
        for child in condition.children:
            self.assess(context, child, status, overall)
        return status

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
                actions.append(
                    Action(curr.sentence, path=name, line=curr.index))
            if actions and (next_.indent < curr.indent or next_.keyword == 'si'):
                parent.actions = actions
                actions = []
            if next_.indent < curr.indent:
                raise StopRecursivity(indent=next_.indent)
                # Move back one step up in recursivity.
            if next_.indent > curr.indent:
                if next_.keyword in ('si', 'alors') and terms:
                    current = Condition(terms[:], connective,
                                        level=int(curr.indent/4), path=name,
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
    def process(rule, context):
        try:
            return rule.assess(context)
        except NoDataError as err:
            # Give more context.
            err.args = (f'{err} (from `{rule}`)',)
            raise

    def __repr__(self):
        return f'<Rule: {self.name}>'
