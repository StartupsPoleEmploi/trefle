from contextlib import suppress
from datetime import datetime

from .config import IDCC, ORGANISMES
from .exceptions import DataError, NoDataError
from .helpers import fold_name, TRUE_VALUES, FALSE_VALUES, EMPTY_VALUES
from .rules import SCHEMA

formatters = {}


def formatter(*formats):
    def wrapper(func):
        formatters.update({f: func for f in formats})
        return func

    return wrapper


@formatter("boolean")
def format_boolean(value):
    value = str(value).lower()
    if value in TRUE_VALUES:
        return True
    if value in FALSE_VALUES:
        return False
    raise ValueError(f"`{value}` n'est pas de type booléen")


@formatter("float")
def format_float(value):
    try:
        return float(value)
    except ValueError:
        raise ValueError(f"`{value}` n'est pas un nombre")


@formatter("integer")
def format_integer(value):
    """An int converter that allows to cast a float like string.

    int('6.0') would raise a ValueError.
    """
    return int(format_float(value))


@formatter("idcc")
def format_idcc(value):
    value = str(value)
    while value and value[0] == "0":
        value = value[1:]
    if value not in IDCC:
        raise ValueError(f"Valeur d'IDCC inconnue: `{value}`")
    return value


@formatter("opco", "opacif")
def format_organisme(value):
    folded = fold_name(value)
    if folded not in ORGANISMES:
        raise ValueError(f"Organisme inconnu: `{value}`")
    return ORGANISMES[folded]["nom"]


@formatter("naf")
def format_naf(value):
    value = value.replace(".", "").upper().replace(" ", "")
    return value.replace("NAF", "").replace("APE", "").strip()


@formatter("formacode")
def format_formacode(value):
    value = format_integer(value)
    if value < 10000 or value > 99999:
        raise ValueError(f"Valeur de FORMACODE invalide : `{value}`")
    return value


@formatter("date")
def format_date(value):
    if isinstance(value, datetime):
        return value

    if isinstance(value, int):
        return datetime.fromtimestamp(value)

    # LHEO date is quite a mess, let's try to do our best.
    tries = [
        (10, "%Y-%m-%d"),
        (8, "%Y%m%d"),
        (10, "%d/%m/%Y"),  # From LBF.
        (10, "%Y-%m-%d"),  # From TMF.
        # Consider the day was invalid, try with month only.
        (6, "%Y%m"),
        # Consider even the month was invalid, try with year only.
        # But let's raise this time, row will be logged and skipped.
        (4, "%Y"),
    ]
    for chars, format_ in tries:
        with suppress(ValueError):
            return datetime.strptime(value[:chars], format_)

    raise ValueError(f"`{value}` n'est pas un format de date connu")


@formatter("money")
def format_remuneration(value):
    value = str(value).replace(",", ".")  # French uses "," as delimiter.
    value = value.replace("€", "")
    value = value.strip()
    if not value:
        value = 0
    return float(value)


@formatter("string")
def format_string(value):
    return str(value)


def with_array(func):
    def wrapper(schema, value):
        if value is not None:
            if schema["type"] == "array":
                value = [func(schema["items"], v) for v in value]
                if schema.get("format") == "set":
                    value = set(value)
                return value
        return func(schema, value)

    return wrapper


def validate_field(name, data):
    value = data.get(name)
    try:
        schema = SCHEMA[name]
    except KeyError as err:
        if name not in data:
            raise NoDataError(str(err), name)
        return value  # Pass by the value (consuming a legacy key?).
    if value is None and "alias" in schema:
        for alias in schema["alias"]:
            value = data.get(alias)
            if value is not None:
                break
    for validator in [validate_empty, validate_format, validate_enum, validate_pattern]:
        try:
            value = validator(schema, value)
        except ValueError as err:
            raise DataError(str(err), name)
        except NoDataError as err:
            err.key = name
            raise
    return value


def validate_empty(schema, value):
    if value in EMPTY_VALUES:
        if "default" in schema:
            return schema["default"]
        if schema.get("format") == "set":
            return set()
        raise NoDataError("Ce champ est obligatoire")
    return value


@with_array
def validate_format(schema, value):
    if value is not None:
        type_ = schema["type"]
        format_ = schema.get("format")
        # If there is formatter, it has precedence, and should take care of the
        # type too (so it can deal with cleaning the data before).
        func = formatters.get(format_, formatters.get(type_))
        if func:
            try:
                value = func(value)
            except TypeError:
                raise ValueError(f"`{value}` n'est pas de type {type_}")
    return value


@with_array
def validate_enum(schema, value):
    if value and "enum" in schema and value not in schema["enum"]:
        raise ValueError(
            f"`{value}` ne fait pas partie de {list(schema['enum'].keys())}"
        )
    return value


@with_array
def validate_pattern(schema, value):
    if value and "pattern" in schema and not schema["pattern"].match(value):
        raise ValueError(f"`{value}` n'est pas au format {schema['pattern'].pattern}")
    return value
