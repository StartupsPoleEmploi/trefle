from ..exceptions import DataError, NoDataError

from .core import IDCC, RULES, Label, Pointer, Rule, action


@action(r"le financement est éligible")
def set_eligible(context):
    context["financement.eligible"] = True


@action(
    r"(l'|les? |la )(?P<key>.+?) est égale? à (?P<rate>[\d\.]+)% (de la|du) (?P<value>.+)$"
)
def set_percent(context, key: Label, rate: float, value: Pointer):
    context[key] = round(value.get(context) * rate / 100, 2)


@action(r"(l'|les? |la )(?P<key>.+?) (vaut|est) (l'|les? |la )?(?P<value>.+)$")
@action(r"(l'|les? |la )(?P<key>.+?) est égale? (à la |à l'|à |aux? )?(?P<value>.+)$")
def set_value(context, key: Label, value: Pointer):
    context[key] = value.get(context)


@action(r"c'est une? (?P<key>.+)")
def set_true(context, key: Label):
    context[key] = True


@action(r"appliquer les règles (de )?(l'|le |la )?(?P<rule>.+)")
def include(context, rule: Pointer):
    name = rule.get(context)
    if not name.endswith(".rules"):
        name = name + ".rules"
    rules = RULES[name]
    statuses = []
    for rule in rules:
        statuses.extend(Rule.process(rule, context))
    return statuses


@action(r"il n'y a pas de (?P<key>.+)$")
def unset_key(context, key: Label):
    try:
        del context[key]
    except KeyError:
        pass


@action(r"définir les organismes paritaires")
def define_organisme(context):
    try:
        idcc = context["beneficiaire.entreprise.idcc"]
    except NoDataError as err:
        # Raise even if the financement is not eligible (which is always the
        # case when this action is called)
        raise DataError(err.error, err.key)
    # Allow to force value in input data.
    if "beneficiaire.entreprise.opco" not in context:
        context["beneficiaire.entreprise.opco"] = IDCC[idcc]["OPCO"]
    if "beneficiaire.entreprise.opacif" not in context:
        context["beneficiaire.entreprise.opacif"] = IDCC[idcc]["OPACIF"]
