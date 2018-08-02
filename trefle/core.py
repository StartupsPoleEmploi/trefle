from . import routine
from .config import FINANCEMENTS
from .helpers import flatten
from .validators import validate


async def simulate(context):
    # Prepare context
    flatten(context)
    validate(context)
    routine.add_constants(context)
    routine.insee_commune_to_region(context)
    await routine.populate_formation(context)
    routine.preprocess(context)
    routine.idcc_to_organismes(context)

    financements = [f.copy() for f in FINANCEMENTS]
    # Compute organisme, prise en charge, rémunération per financement
    for financement in financements:
        routine.check_financement(context.copy(), financement)

    return financements
