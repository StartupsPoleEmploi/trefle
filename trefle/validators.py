from contextlib import suppress
from datetime import datetime

from .rules import SCHEMA
from .config import IDCC, ORGANISMES, fold_name

validators = []
formatters = {}

TRUE_VALUES = ('oui', 'yes', 'true', 'on', '1')
FALSE_VALUES = ('non', 'no', 'false', 'off', '0')


def formatter(*formats):
    def wrapper(func):
        formatters.update({f: func for f in formats})
        return func
    return wrapper


def validator(func):
    validators.append(func)
    return func


@formatter('boolean')
def format_boolean(value):
    value = str(value).lower()
    if value in TRUE_VALUES:
        return True
    if value in FALSE_VALUES:
        return False
    raise ValueError(f"`{value}` n'est pas de type booléen")


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
    with suppress(ValueError):
        return datetime.strptime(value[:8], '%Y%m%d')

    # Consider the day was invalid, try with month only.
    with suppress(ValueError):
        return datetime.strptime(value[:6], '%Y%m')

    # Consider even the month was invalid, try with year only.
    # But let's raise this time, row will be logged and skipped.
    return datetime.strptime(value[:4], '%Y')


@formatter('remuneration')
def format_remuneration(value):
    value = str(value).replace(',', '.')  # French uses "," as delimiter.
    value = value.replace('€', '')
    value = value.strip()
    if not value:
        value = 0
    return float(value)


def validate(data):
    # Check all fields at once, more user friendly.
    errors = {}
    for name, schema in SCHEMA.items():
        value = data.get(name)
        # Allow to keep retrocompat names.
        if value is None and 'alias' in schema:
            value = data.get(schema['alias'])
        value = validate_field(name, value, schema, errors)
        if name in data or value is not None:  # Do not create None values.
            data[name] = value
    if errors:
        raise ValueError(errors)


def validate_field(name, value, schema, errors):
    for validator_ in validators:
        try:
            value = validator_(schema, value)
        except ValueError as err:
            errors[name] = str(err)
            # Store only one error per field.
            break
    return value


@validator
def validate_required(schema, value):
    if schema.get('required') and value in (None, ''):
        raise ValueError('Ce champ est obligatoire')
    return value


@validator
def validate_format(schema, value):
    if value is not None:
        type_ = schema['type']
        format_ = schema.get('format')
        if type_ == 'array':
            return [validate_format(schema['items'], v) for v in value]
        # If there is formatter, it has precedence, and should take care of the
        # type too (so it can deal with cleaning the data before).
        func = formatters.get(format_, formatters.get(type_))
        if func:
            try:
                value = func(value)
            except TypeError:
                raise ValueError(f"`{value}` n'est pas de type {type_}")
    return value


@validator
def validate_enum(schema, value):
    if value and 'enum' in schema and value not in schema['enum']:
        raise ValueError(
            f"`{value}` ne fait pas partie de {list(schema['enum'].keys())}")
    return value


@validator
def validate_pattern(schema, value):
    if value and 'pattern' in schema and not schema['pattern'].match(value):
        raise ValueError(
            f"`{value}` n'est pas au format {schema['pattern'].pattern}")
    return value
