from .core import condition, private, reason
from ..helpers import diff_month


@reason("ce n'est pas {key.pointer.raw}")
@condition(r"c'est une? (?P<key>.+)")
def check_true(context, key):
    return key.value is True


@reason("c'est {key.pointer.raw}")
@condition(r"ce n'est pas une? (?P<key>.+)")
def check_false(context, key):
    return key.value is False


@reason("{key.pointer.raw} est définie: {key}")
@condition(r"(l'|les? |la )(?P<key>.+) (n'est|ne sont) pas définie?s?")
def check_none(context, key):
    return key.value in (None, '')


@private
@condition(r"le financement est de type (?P<tag>.+)")
def check_financement_type(context, tag):
    return tag.value in context['financement.tags']


@private
@condition(r"le financement n'est pas de type (?P<tag>.+)")
def check_financement_not_type(context, tag):
    return tag.value not in context['financement.tags']


@private
@condition(r"l'intitulé du financement est (?P<name>.+)")
def check_financement_name(context, name):
    return context['financement.intitule'] == name.value


@reason("{start.pointer.raw} trop ancien par rapport à {end.pointer.raw}")
@condition(r"la durée en mois entre (l'|les? |la )(?P<start>.+?) et (l'|les? |la )(?P<end>.+?) est inférieure ou égale à (?P<amount>.+)")
@condition(r"la durée en mois entre (l'|les? |la )(?P<start>.+?) et (l'|les? |la )(?P<end>.+?) n'est pas supérieure à (?P<amount>.+)")
def check_diff_dates(context, start, end, amount):
    return diff_month(start.value, end.value) <= amount.value


@reason("{left.pointer.raw} vaut {left}, c'est inférieur ou égal au seuil de {right}")
@condition(r"(l'|les? |la )(?P<left>.+) est supérieure? à (l'|les? |la )?(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<left>.+) (n'est|ne sont) pas inférieure?s? ou éga(le?s?|aux)? à (l'|les? |la )?(?P<right>.+)")
def check_gt(context, left, right):
    return left.value > right.value


@reason("{left.pointer.raw} trop faible: {left}, au lieu de {right} au moins")
@condition(r"(l'|les? |la )(?P<left>.+) est supérieure? ou égale? à (l'|les? |la )?(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<left>.+) (n'est|ne sont) pas inférieure?s? à (l'|les? |la )?(?P<right>.+)")
def check_ge(context, left, right):
    return left.value >= right.value


@reason("{left.pointer.raw} trop grande: {left} (le maximum est {right})")
@condition(r"(l'|les? |la )(?P<left>.+?) est inférieure? ou égale? à (?P<rate>[\d\.]+)% (de l'|du |de la |des )?(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<left>.+?) (n'est|ne sont) pas supérieure?s? à (?P<rate>[\d\.]+)% (de l'|du |de la |des )?(?P<right>.+)")
def check_percent_le(context, left, rate, right):
    return left.value <= (right.value * rate.value / 100)


@reason("{left.pointer.raw} trop grande: {left} (le maximum est {right})")
@condition(r"(l'|les? |la )(?P<left>.+) est inférieure? ou égale? à (l'|les? |la )?(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<left>.+) (n'est|ne sont) pas supérieure?s? à (l'|les? |la )?(?P<right>.+)")
def check_le(context, left, right):
    return left.value <= right.value


@reason("{left.pointer.raw} vaut {left}, c'est supérieur ou égal au seuil ({right})")
@condition(r"(l'|les? |la )(?P<left>.+) est inférieure? (à l'|aux? |à la |à )?(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<left>.+) (n'est|ne sont) pas supérieure? ou éga(le?s?|aux) (à l'|aux? |à la |à )?(?P<right>.+)")
def check_lt(context, left, right):
    return left.value < right.value


@reason("«{left}» ne contient pas {right}")
@condition(r"(l'|les? |la )(?P<left>.+) contien(nen)?t au moins une? ([^ ]+ )?(parmi|des) (?P<right>.+)")
def check_share_one(context, left, right):
    return bool(set(left.value or []) & set(right.value or []))


@reason("«{right}» contient {left}")
@condition(r"(l'|les? |la )(?P<left>.+) ne contien(nen)?t aucun (des? |[^ ]+ parmi )?(?P<right>.+)")
def check_not_share_one(context, left, right):
    return not bool(set(left.value or []) & set(right.value or []))


@reason("{left.pointer.raw} («{left}») fait partie de «{right}»")
@condition(r"(l'|les? |la )(?P<left>.+) ne fait pas partie (de l'|des? |de la |du )(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<right>.+) ne contient pas (l'|les? |la )?(?P<left>.+)")
def check_not_contain(context, left, right):
    return left.value not in right.value


@reason("{left.pointer.raw} ({left}) ne fait pas partie de «{right.pointer.raw}» ({right})")
@condition(r"(l'|les? |la )(?P<left>.+) fait partie (de l'|de la |des? |du )(?P<right>.+)")
@condition(r"(l'|les? |la )(?P<right>.+?) contien(nen)?t (l'|les? |la )?(?P<left>.+)")
def check_contain(context, left, right):
    return left.value in right.value


@reason("{left.pointer.raw} vaut «{left}» au lieu de «{right}»")
@condition(r"(l'|les? |la )(?P<left>.+?) (est|vaut) (l'|les? |la )?(?P<right>.+)")
def check_equal(context, left, right):
    return left.value == right.value


@reason("{left.pointer.raw} vaut «{left}» au lieu de «{right}»")
@condition(r"(l'|les? |la )(?P<left>.+?) (n'est|ne vaut) pas (l'|les? |la )?(?P<right>.+)")
def check_not_equal(context, left, right):
    return left.value != right.value
