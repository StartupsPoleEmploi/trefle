from contextlib import suppress
from datetime import datetime

from .config import IDCC, ORGANISMES
from .exceptions import DataError, NoDataError
from .helpers import fold_name
from .rules import SCHEMA

formatters = {}

TRUE_VALUES = ('oui', 'yes', 'true', 'on', '1')
FALSE_VALUES = ('non', 'no', 'false', 'off', '0')


def formatter(*formats):
    def wrapper(func):
        formatters.update({f: func for f in formats})
        return func
    return wrapper


@formatter('boolean')
def format_boolean(value):
    value = str(value).lower()
    if value in TRUE_VALUES:
        return True
    if value in FALSE_VALUES:
        return False
    raise ValueError(f"`{value}` n'est pas de type booléen")


@formatter('float')
def format_float(value):
    try:
        return float(value)
    except ValueError:
        raise ValueError(f"`{value}` n'est pas un nombre")


@formatter('integer')
def format_integer(value):
    """An int converter that allows to cast a float like string.

    int('6.0') would raise a ValueError.
    """
    try:
        return int(float(value))
    except ValueError:
        # French message
        raise ValueError(f"`{value}` n'est pas un nombre")


@formatter('idcc')
def format_idcc(value):
    value = str(value)
    while value and value[0] == '0':
        value = value[1:]
    if value not in IDCC:
        raise ValueError(f"Valeur d'IDCC inconnue: `{value}`")
    return value


@formatter('opca', 'opacif')
def format_organisme(value):
    folded = fold_name(value)
    if folded not in ORGANISMES:
        raise ValueError(f"Organisme inconnu: `{value}`")
    return ORGANISMES[folded]['nom']


@formatter('naf')
def format_naf(value):
    value = value.replace('.', '').upper().replace(' ', '')
    return value.replace('NAF', '').replace('APE', '').strip()


@formatter('domaine_formacode')
def format_domaine_formacode(value):
    return int(str(value)[:3])


@formatter('date')
def format_date(value):
    # LHEO date is quite a mess, let's try to do our best.
    if isinstance(value, int):
        return datetime.fromtimestamp(value)

    with suppress(ValueError):
        return datetime.strptime(value[:8], '%Y%m%d')

    # Consider the day was invalid, try with month only.
    with suppress(ValueError):
        return datetime.strptime(value[:6], '%Y%m')

    # Consider even the month was invalid, try with year only.
    # But let's raise this time, row will be logged and skipped.
    return datetime.strptime(value[:4], '%Y')


@formatter('money')
def format_remuneration(value):
    value = str(value).replace(',', '.')  # French uses "," as delimiter.
    value = value.replace('€', '')
    value = value.strip()
    if not value:
        value = 0
    return float(value)


def validate_field(name, data):
    value = data.get(name)
    try:
        schema = SCHEMA[name]
    except KeyError:
        return value  # FIXME unknown keys (like parent, which is a hack)
    if value is None and 'alias' in schema:
        value = data.get(schema['alias'])
    for validator in [validate_empty, validate_format, validate_enum,
                      validate_pattern]:
        try:
            value = validator(schema, value)
        except ValueError as err:
            raise DataError(str(err), name)
        except NoDataError as err:
            err.key = name
            raise
    return value


def validate_empty(schema, value):
    if value in (None, ''):
        if 'default' in schema:
            return schema['default']
        if schema.get('format') == 'set':
            return set()
        raise NoDataError('Ce champ est obligatoire')
    return value


def validate_format(schema, value):
    if value is not None:
        type_ = schema['type']
        format_ = schema.get('format')
        if type_ == 'array':
            value = [validate_format(schema['items'], v) for v in value]
            if format_ == 'set':
                value = set(value)
            return value
        # If there is formatter, it has precedence, and should take care of the
        # type too (so it can deal with cleaning the data before).
        func = formatters.get(format_, formatters.get(type_))
        if func:
            try:
                value = func(value)
            except TypeError:
                raise ValueError(f"`{value}` n'est pas de type {type_}")
    return value


def validate_enum(schema, value):
    if value and 'enum' in schema and value not in schema['enum']:
        raise ValueError(
            f"`{value}` ne fait pas partie de {list(schema['enum'].keys())}")
    return value


def validate_pattern(schema, value):
    if value and 'pattern' in schema and not schema['pattern'].match(value):
        raise ValueError(
            f"`{value}` n'est pas au format {schema['pattern'].pattern}")
    return value
