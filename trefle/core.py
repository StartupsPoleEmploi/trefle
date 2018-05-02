from . import routine
from .validators import validate


def simulate(**data):
    routine.add_constants(data)
    routine.flatten(data)
    routine.preload_financements(data)
    validate(data)
    routine.populate_formation(data)
    routine.idcc_to_organismes(data)
    routine.check_eligibilite(data)
    routine.populate_financements(data)
    return data['financements'].values()
