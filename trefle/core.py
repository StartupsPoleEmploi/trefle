from . import routine
from .rules import CONSTANTS, RULES
from .validators import validate


def simulate(**data):
    data.update(CONSTANTS)
    routine.flatten(data)
    validate(data)
    routine.populate_formation(data)
    routine.idcc_to_organismes(data)
    routine.check_eligibilite(data, rules=RULES)
    routine.check_financements(data)
    return data['financements.eligibles'], data['financements.non_eligibles']