from collections import namedtuple
import inspect
import re

from .exceptions import NoDataError, WrongPointerError, NoStepError

SCHEMA = {}
LABELS = {}


def Label(v):
    """Used as annotation for casting to variable id from variable label."""
    try:
        return LABELS[v]
    except KeyError:
        raise WrongPointerError(v)


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

    def __init__(self, raw):
        self.raw = raw
        self.get = None
        self.default = None
        self.key = None
        self.compile()

    def __repr__(self):
        return f'<LazyValue: {self.raw}>'

    def compile(self):
        value = ...
        if self.raw[0] == '«' and self.raw[-1] == '»':
            value = self.raw[1:-1]
            if value in LABELS:
                # This is an enum.
                # FIXME: Should we have a dedicated registry instead?
                value = LABELS[value]
        elif self.raw[0] == '[' and self.raw[-1] == ']':
            value = self.raw[1:-1].split(',')  # TODO: type of members/constant
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
            self.default = SCHEMA[self.key].get('default')
        if value is not ...:
            self.get = lambda **d: value

    def _get(self, **context):
        try:
            return context[self.key]
        except KeyError:
            if self.default is not None:
                return self.default
            raise NoDataError(self.raw)


def action(pattern):

    def wrapper(func):
        Action.PATTERNS[re.compile(pattern)] = func
        return func

    return wrapper


def condition(pattern):

    def wrapper(func):
        Condition.PATTERNS[re.compile(pattern)] = func
        return func

    return wrapper


class Step:

    def __repr__(self):
        return f'<{self.__class__.__name__}: {self.raw}>'

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
        for name, param in spec.parameters.items():
            if name == 'context':
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

    def act(self, context):
        try:
            self.func(context, **self.params)
        except NoDataError as err:
            raise NoDataError(f'No data for `{err}` in `{self.raw}`')


class Condition(Step):

    PATTERNS = {}
    AND = 'ET'
    OR = 'OU'

    def __init__(self, terms, connective=None):
        assert terms, 'Cannot create a Condition without terms'
        self.params = {}
        self.conditions = []
        self.negative = False
        self.connective = connective or self.AND
        self.raw = f' {self.connective} '.join(terms)
        if len(terms) == 1:
            terms = terms[0].split(', et ')
            if len(terms) > 1:
                self.connective = self.AND
            else:
                terms = terms[0].split(', ou ')
                if len(terms) > 1:
                    self.connective = self.OR
        if len(terms) > 1:
            self.conditions = [Condition([t]) for t in terms]
        else:
            self.compile()

    def assess(self, **context):
        if self.conditions:
            if self.connective == self.OR:
                return any([c.assess(**context) for c in self.conditions])
            return all([c.assess(**context) for c in self.conditions])
        try:
            return self.func(context, **self.params)
        except NoDataError:
            return False
        except Exception as err:
            # Give more context.
            params = ' AND '.join(f'{value.raw}={value.get(**context)}'
                                  for value in self.params.values())
            err.args = (f'{err} (in `{self.raw}`, where {params})',)
            raise


@action(r"(l'|les? |la )(?P<key>.+) (vaut|est) (?P<value>[\w«» +\-'\.]+)$")
@action(r"(l'|les? |la )(?P<key>.+) est égale? (à la|à|aux?)? (?P<value>[\w«» +\-\.']+)$")
def set_value(context, key: Label, value: LazyValue):
    context[key] = value.get(**context)


@action(r"(l'|les? |la )(?P<key>.+) est égale? à (?P<rate>[\d\.]+)% (de la|du) (?P<value>[\w«» +\-\.']+)$")
def set_percent(context, key: Label, rate: float, value: LazyValue):
    context[key] = value.get(**context) * rate / 100


@action(r"définir le financement «(?P<name>[\w +-]+)» comme éligible")
def set_financement_eligible(context, name):
    if name not in context['financements']:
        raise ValueError(f'Unknown financement `{name}`')
    context['financements'][name]['eligible'] = True


@action(r"il n'y a pas de (?P<key>[\w ]+)$")
def unset_key(context, key: Label):
    try:
        del context[key]
    except KeyError:
        pass


@condition(r"c'est une? (?P<key>.+)")
def check_true(context, key: LazyValue):
    return key.get(**context) is True


@condition(r"ce n'est pas une? (?P<key>.+)")
def check_false(context, key: LazyValue):
    return key.get(**context) is False


@condition(r"le financement est de type (?P<tag>.+)")
def check_type(context, tag: LazyValue):
    return tag.get(**context) in context['financement.tags']


@condition(r"(l'|les? |la )(?P<left>.+) est supérieure? à (?P<right>[\w ]+)")
def check_gt(context, left: LazyValue, right: LazyValue):
    return left.get(**context) > right.get(**context)


@condition(r"(l'|les? |la )(?P<left>.+) est supérieure? ou égale? à (?P<right>[\w ]+)")
def check_ge(context, left: LazyValue, right: LazyValue):
    return left.get(**context) >= right.get(**context)


@condition(r"(l'|les? |la )(?P<left>.+) est inférieure? à (?P<right>[\w ]+)")
def check_lt(context, left: LazyValue, right: LazyValue):
    return left.get(**context) < right.get(**context)


@condition(r"(l'|les? |la )(?P<left>.+) est inférieure? ou égale? à (?P<right>[\w ]+)")
def check_le(context, left: LazyValue, right: LazyValue):
    return left.get(**context) <= right.get(**context)


@condition(r"(l'|les? |la )(?P<left>.+) contien(nen)?t au moins (une?) des (?P<right>[ \w«»]+)")
def check_share_one(context, left: LazyValue, right: LazyValue):
    return len(set(left.get(**context) or []) & set(right.get(**context) or [])) > 0


@condition(r"(l'|les? |la )(?P<left>.+) fait partie (de l'|de la |des? |du )(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<right>.+) contient (l'|les? |la )?(?P<left>[ \w«»]+)")
def check_contain(context, left: LazyValue, right: LazyValue):
    return left.get(**context) in right.get(**context)


@condition(r"(l'|les? |la )(?P<left>.+) ne fait pas partie (de l'|des? |de la |du )(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<right>.+) ne contient pas (l'|les? |la )?(?P<left>[ \w«»]+)")
def check_not_contain(context, left: LazyValue, right: LazyValue):
    return left.get(**context) not in right.get(**context)


@condition(r"(l'|les? |la )(?P<left>.+) (est|vaut) (?P<right>[\w«» +\-\.']+)")
def check_equal(context, left: LazyValue, right: LazyValue):
    return left.get(**context) == right.get(**context)


Line = namedtuple('Line', ['indent', 'keyword', 'sentence'])


class StopRecursivity(Exception):

    def __init__(self, indent):
        self.indent = indent


class Rule:

    def __init__(self, conditions, actions):
        assert conditions, 'Cannot create a rule without conditions'
        self.conditions = conditions
        self.actions = actions

    def assess(self, **context):
        return all(c.assess(**context) for c in self.conditions)

    @staticmethod
    def iter_lines(iterable):
        previous = Line(0, None, None)
        current = None
        for raw in iterable:
            indent = count_indent(raw)
            line = raw.strip()
            if not line or line.startswith('#'):
                continue
            keyword, sentence = line.split(maxsplit=1)
            keyword = keyword.lower()
            next_ = Line(indent, keyword, sentence)
            if current:
                yield (previous, current, next_)
            previous = current
            current = next_
        yield (previous, current, Line(0, None, None))

    @classmethod
    def load(cls, lines, tree=None, rules=None):
        if rules is None:
            rules = []
            lines = cls.iter_lines(lines)
        # tree of conditions valid until now (higher indentation ihnerits
        # conditions from lower indentations).
        if tree is None:
            tree = []
        actions = []  # One or more actions of a rule.
        terms = []  # One or more terms of a condition.
        connective = None
        for (prev, curr, next_) in lines:
            if curr.keyword == 'si' or (terms and curr.keyword in ('et', 'ou')):
                terms.append(curr.sentence)
                if not connective and curr.keyword == 'ou':
                    connective = Condition.OR
            elif curr.keyword == 'alors' or (actions and curr.keyword == 'et'):
                actions.append(Action(curr.sentence))
            if actions and (next_.indent < curr.indent or next_.keyword == 'si'):
                rules.append(Rule(tree[:], actions))
                actions = []
            if next_.indent < curr.indent:
                raise StopRecursivity(indent=next_.indent)
                # Move back one step up in recursivity.
            if next_.indent > curr.indent:
                inner = tree[:]
                if next_.keyword in ('si', 'alors') and terms:
                    inner.append(Condition(terms[:], connective))
                    terms = []
                    connective = None
                try:
                    Rule.load(lines, inner[:], rules)
                except StopRecursivity as err:
                    if err.indent < curr.indent:
                        raise
                    continue  # We are on the right level.
        return rules

    @staticmethod
    def process(rules, context, failed=None):
        for rule in rules:
            if rule.assess(**context):
                for action in rule.actions:
                    try:
                        action.act(context)
                    except NoDataError as err:
                        # Give more context.
                        err.args = (f'{err} (from `{rule}`)',)
                        raise
            elif failed is not None:
                failed.append(rule)

    def __repr__(self):
        return f'<Rule: {self.conditions} => {self.actions}>'
