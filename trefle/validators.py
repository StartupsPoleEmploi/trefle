from contextlib import suppress
from datetime import datetime

from .rules import SCHEMA
from .config import IDCC, ORGANISMES, fold_name

validators = []

TRUE_VALUES = ('oui', 'yes', 'true', 'on', '1')
FALSE_VALUES = ('non', 'no', 'false', 'off', '0')


def to_bool(value):
    value = str(value).lower()
    if value in TRUE_VALUES:
        return True
    if value in FALSE_VALUES:
        return False
    raise ValueError


def to_int(value):
    """An int converter that allows to cast a float like string.

    int('6.0') will raise a ValueError.
    """
    return int(float(value))


def to_idcc(value):
    while value and value[0] == '0':
        value = value[1:]
    if value not in IDCC:
        raise ValueError(f"Valeur d'IDCC inconnue: `{value}`")
    return value


def to_organisme(value):
    folded = fold_name(value)
    if folded not in ORGANISMES:
        raise ValueError(f"Organisme inconnu: `{value}`")
    return ORGANISMES[folded]['nom']


def to_naf(value):
    return value.replace('.', '').upper()


def to_domaine_formacode(value):
    return int(str(value)[:3])


def to_date(value):
    # LHEO date is quite a mess, let's try to do our best.
    with suppress(ValueError):
        return datetime.strptime(value[:8], '%Y%m%d')

    # Consider the day was invalid, try with month only.
    with suppress(ValueError):
        return datetime.strptime(value[:6], '%Y%m')

    # Consider even the month was invalid, try with year only.
    # But let's raise this time, row will be logged and skipped.
    return datetime.strptime(value[:4], '%Y')


TYPES = {
    'boolean': to_bool,
    'number': float,
    'integer': to_int,
    'string': str,
}

FORMATS = {
    'idcc': to_idcc,
    'naf': to_naf,
    'opca': to_organisme,
    'opacif': to_organisme,
    'domaine_formacode': to_domaine_formacode,
    'date': to_date,
}


def validator(func):
    validators.append(func)
    return func


def validate(data):
    # Check all fields at once, more user friendly.
    errors = {}
    for name, schema in SCHEMA.items():
        value = validate_field(name, data.get(name), schema, errors)
        if name in data:  # Do not create unwanted None values.
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
def validate_type(schema, value):
    if value is not None:
        type_ = schema['type']
        if type_ == 'array':
            return [validate_type(schema['items'], v) for v in value]
        func = TYPES.get(type_)
        if func:
            try:
                value = func(value)
            except (ValueError, TypeError):
                raise ValueError(f"`{value}` n'est pas de type {type_}")
    return value


@validator
def validate_format(schema, value):
    if value is not None:
        format_ = schema.get('format')
        type_ = schema['type']
        if type_ == 'array':
            return [validate_format(schema['items'], v) for v in value]
        func = FORMATS.get(format_)
        if func:
            value = func(value)  # May raise a ValueError
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
