from .core import (IDCC, RULES, Label, Pointer, Rule, action)


@action(r"le financement est éligible")
def set_eligible(context, status):
    context['financement.eligible'] = True


@action(r"(l'|les? |la )(?P<key>.+?) est égale? à (?P<rate>[\d\.]+)% (de la|du) (?P<value>.+)$")
def set_percent(context, status, key: Label, rate: float, value: Pointer):
    context[key] = round(value.get(context) * rate / 100, 2)


@action(r"(l'|les? |la )(?P<key>.+?) (vaut|est) (l'|les? |la )?(?P<value>.+)$")
@action(r"(l'|les? |la )(?P<key>.+?) est égale? (à la |à l'|à |aux? )?(?P<value>.+)$")
def set_value(context, status, key: Label, value: Pointer):
    context[key] = value.get(context)


@action(r"c'est une? (?P<key>.+)")
def set_true(context, status, key: Label):
    context[key] = True


@action(r"appliquer les règles (de )?(l'|le |la )?(?P<rule>.+)")
def include(context, status, rule: Pointer):
    rule = rule.get(context)
    name = f'rules/{rule}.rules'
    rules = RULES[name]
    for rule in rules:
        Rule.process(rule, context, status=status)


@action(r"il n'y a pas de (?P<key>.+)$")
def unset_key(context, status, key: Label):
    try:
        del context[key]
    except KeyError:
        pass


@action(r"définir les organismes paritaires")
def define_organisme(context, status):
    idcc = context['beneficiaire.entreprise.idcc']
    # Allow to force value in input data.
    if 'beneficiaire.entreprise.opca' not in context:
        context['beneficiaire.entreprise.opca'] = IDCC[idcc]['OPCA']
    if 'beneficiaire.entreprise.opacif' not in context:
        context['beneficiaire.entreprise.opacif'] = IDCC[idcc]['OPACIF']
