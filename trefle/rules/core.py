import inspect
import re
from collections import namedtuple
from datetime import datetime

from ..exceptions import (DataError, NoDataError, NoStepError, ParsingError,
                          WrongPointerError)
from ..helpers import count_indent, isfloat

SCHEMA = {}
LABELS = {}
RULES = {}
IDCC = {}
DATE_PATTERN = re.compile(r'\d{2}/\d{2}/\d{4}')


def parse_value(value, default=...):
    if value[0] == '«' and value[-1] == '»':
        value = value[1:-1]
        if DATE_PATTERN.match(value):
            value = datetime.strptime(value, '%d/%m/%Y')
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
        self.key = None
        self.compile()

    def __repr__(self):
        return f'<Pointer: {self.raw}>'

    def compile(self):
        self.value = parse_value(self.raw)
        if self.value is ...:  # This is an actual schema pointer.
            try:
                self.key = LABELS[self.raw]
            except KeyError:
                raise WrongPointerError(self.raw)

    def get(self, context):
        if self.key:
            return context[self.key]
        return self.value

    def resolve_label(self, value, labels):
        try:
            value = labels[value]
        except KeyError:
            if value not in labels.values():
                raise WrongPointerError(f'Wrong value `{value}`')
        return value

    def resolve_labels(self, *keys):
        labels = {}
        for key in keys:
            labels.update(SCHEMA[key].get('labels', {}))
        if self.key or not labels:
            return
        if isinstance(self.value, list):
            self.value = [self.resolve_label(v, labels) for v in self.value]
        else:
            self.value = self.resolve_label(self.value, labels)


def action(pattern):

    def wrapper(func):
        Action.register(pattern, func)
        return func

    return wrapper


def condition(pattern):

    def wrapper(func):
        func.reason = None
        func.private = False
        Condition.register(pattern, func)
        return func

    return wrapper


def reason(msg):

    def wrapper(func):
        func.reason = msg
        return func

    return wrapper


def private(func):
    # Make this condition not visible for final status output.
    func.private = True
    return func


class Value:

    def __init__(self, pointer, context):
        self.value = pointer.get(context)
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
        if self.children:
            out['children'] = [c.json for c in self.children]
        return out


class Step:

    def __init__(self, path=None, line=0):
        self.func = None
        self.params = {}
        self.path = path
        self.line = line
        self.pattern = None

    def __repr__(self):
        return f'<{self.__class__.__name__}: {self} ({self.path}:{self.line})>'

    def __str__(self):
        return self.raw

    def parse_raw(self):
        for pattern, func in self.PATTERNS.items():
            match = pattern.match(self.raw)
            if match:
                self.func = func
                self.pattern = pattern.pattern
                break
        else:
            raise NoStepError(f'No pattern matches step: `{self!r}`')
        return match.groupdict()

    @property
    def spec(self):
        spec = inspect.signature(self.func)
        return list(spec.parameters.items())[1:]  # Skip context.

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
                err.args = (f'`{err}` (in `{self!r}`, '
                            f'pattern: {self.pattern})',)
                raise
            self.params[name] = value

    @classmethod
    def register(cls, pattern, func):
        cls.PATTERNS[re.compile(pattern)] = func


class Action(Step):

    PATTERNS = {}
    DEFAULT_TYPE = str

    def __init__(self, raw, path=None, line=0):
        super().__init__(path, line)
        self.raw = raw
        self.compile()

    def act(self, context, status):
        try:
            return self.func(context, **self.params)
        except NoDataError:
            # This allows to have "generic action" in region/OPCA files that
            # can be written without checking explicitly if the financement is
            # éligible, and we want to make the data required only when this is
            # the case.
            if context.get('financement.eligible'):
                raise


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
        if isinstance(terms[0], str):
            terms = [terms]
        if len(terms) == 1 and len(terms[0]) == 1:
            terms = self.split_inline_conditions(terms)
        # no inline condition detected
        if len(terms) == 1 and len(terms[0]) == 1:
            self.load_single(terms[0][0])
        elif len(terms) == 1:
            self.load_and_terms(terms[0])
        else:
            self.load_or_terms(terms)

    def split_inline_conditions(self, terms):
        term = terms[0][0]
        if ', ou ' in term:
            return [[t] for t in term.split(', ou ')]
        if ', et ' in term:
            return [term.split(', et ')]
        return terms

    def load_or_terms(self, terms):
        self.connective = self.OR
        self.terms = [Condition([t], level=self.level, path=self.path,
                                line=self.line) for t in terms]
        self.raw = f' {self.connective} '.join(str(t) for t in self.terms)

    def load_and_terms(self, terms):
        self.terms = [Condition([[t]], level=self.level, path=self.path,
                                line=self.line) for t in terms]
        self.raw = f' {self.connective} '.join(str(t) for t in self.terms)

    def load_single(self, term):
        self.raw = term
        self.compile()
        self.negative = ' pas ' in self.pattern

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
                # Negative conditions are True by default, positive are False.
                status.status = self.negative
                label = SCHEMA.get(err.key, {}).get('label', err.key)
                status.reason = f"Donnée manquante pour «{label}»"
            except DataError:
                raise
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
    def private(self):
        return self.func and self.func.private

    def compile(self):
        super().compile()
        keys = [pointer.key for pointer in self.params.values() if pointer.key]
        for pointer in self.params.values():
            try:
                pointer.resolve_labels(*keys)
            except WrongPointerError as err:
                err.args = (f'{err} (in `{self!r}`)',)
                raise


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
        statuses = []

        def graft(substatuses):
            if status is not None:
                status.children.extend(substatuses)
                for substatus in substatuses:
                    substatus.parent = status
            else:
                statuses.extend(substatuses)

        overall = overall and status
        if status.condition.private:
            if status:
                status = parent  # Skip from explain tree.
            else:
                # Stop recursion.
                return statuses
        else:
            statuses.append(status)

        for action in condition.actions:
            if overall:
                substatuses = action.act(context, status)
                if substatuses:
                    graft(substatuses)
        for child in condition.children:
            substatuses = self.assess(context, child, status, overall)
            if substatuses:
                graft(substatuses)
        return statuses

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
        or_terms = []  # One or more terms of a condition.
        and_terms = []  # One or more terms of a condition.
        connective = None
        for (prev, curr, next_) in lines:
            if curr.indent % 4 != 0:
                raise ParsingError('Wrong indentation', name, curr)
            if curr.indent != prev.indent and curr.keyword not in ['si', 'alors']:
                raise ParsingError('Wrong keyword', name, curr)
            if curr.indent != prev.indent and not parent:
                raise ParsingError('Wrong indentation', name, curr)
            if curr.keyword == 'si' or (and_terms and curr.keyword in ('et', 'ou')):
                if curr.keyword == 'ou':
                    or_terms.append(and_terms[:])
                    and_terms = []
                    and_terms.append(curr.sentence)
                else:
                    and_terms.append(curr.sentence)
                if not connective:
                    connective = Condition.OR if curr.keyword == 'ou' else Condition.AND
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
                if next_.keyword in ('si', 'alors') and and_terms:
                    or_terms.append(and_terms[:])
                    current = Condition(or_terms[:], connective,
                                        level=int(curr.indent/4), path=name,
                                        line=curr.index)
                    if curr.indent == 0:
                        rules.append(Rule(name, current))
                        parent = current
                    else:
                        parent.children.append(current)
                    or_terms = []
                    and_terms = []
                    connective = None
                try:
                    Rule.load(lines, name, rules, current)
                except StopRecursivity as err:
                    if err.indent < curr.indent:
                        raise
                    continue  # We are on the right level.
        return rules

    @staticmethod
    def process(rule, context, status=None):
        try:
            return rule.assess(context, parent=status)
        except NoDataError as err:
            # Give more context.
            err.args = (f'`{err}` (from `{rule}`)',)
            raise

    def __repr__(self):
        return f'<Rule: {self.name}>'
