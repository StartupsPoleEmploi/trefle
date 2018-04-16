from pathlib import Path

import yaml

from . import routine
from .rules import CONSTANTS, RULES


def simulate(**data):
    passed, failed = [], []
    data.update(CONSTANTS)
    routine.idcc_to_organismes(data)
    routine.check_eligibilite(data, rules=RULES)
    routine.check_scenarios(data)
    return data['scenarios.eligibles'], data['scenarios.non_eligibles']
