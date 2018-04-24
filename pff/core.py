from . import routine
from .rules import CONSTANTS, RULES


def simulate(**data):
    data.update(CONSTANTS)
    routine.validate_data(data)
    routine.populate_formation(data)
    routine.idcc_to_organismes(data)
    routine.check_eligibilite(data, rules=RULES)
    routine.check_scenarios(data)
    # print(data)
    return data['scenarios.eligibles'], data['scenarios.non_eligibles']
