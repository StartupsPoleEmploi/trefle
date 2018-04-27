from . import routine
from .validators import validate


def simulate(**data):
    routine.add_constants(data)
    routine.flatten(data)
    validate(data)
    routine.populate_formation(data)
    routine.idcc_to_organismes(data)
    routine.check_eligibilite(data)
    routine.check_financements(data)
    return data['financements.eligibles'], data['financements.non_eligibles']
