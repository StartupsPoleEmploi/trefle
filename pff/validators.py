from .rules import VARIABLES

validators = []

TYPES = {
    'boolean': bool,
    'number': float,
    'integer': int,
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
    for validator in validators:
        try:
            value = validator(schema, value)
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
                raise ValueError(f"{value} n'est pas de type {type_}")
    return value
