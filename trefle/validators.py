from .rules import VARIABLES

validators = []

TRUE_VALUES = ('oui', 'yes', 'true', 'on')
FALSE_VALUES = ('non', 'no', 'false', 'off')


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


TYPES = {
    'boolean': to_bool,
    'number': float,
    'integer': to_int,
}


def validator(func):
    validators.append(func)
    return func


def validate(data):
    # Check all fields at once, more user friendly.
    errors = {}
    for name, schema in VARIABLES.items():
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
        func = TYPES.get(type_)
        if func:
            try:
                value = func(value)
            except (ValueError, TypeError):
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
            f"`{value}` n'est pas au format {schema['pattern']}")
    return value
