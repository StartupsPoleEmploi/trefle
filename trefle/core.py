from . import routine
from .config import FINANCEMENTS
from .context import Context
from .helpers import flatten


async def simulate(data):
    # Prepare context
    flatten(data)
    context = Context(data)
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
