from . import routine
from .validators import validate


async def simulate(**context):
    # Prepare context
    routine.add_constants(context)
    routine.flatten(context)
    routine.preload_financements(context)
    validate(context)
    routine.insee_commune_to_region(context)
    await routine.populate_formation(context)
    routine.idcc_to_organismes(context)

    # Compute financements eligibles
    routine.check_eligibilite(context)

    # Compute organisme, prise en charge, rémunération per financement
    for financement in context['financements'].values():
        routine.populate_financement(context.copy(), financement)

    return context['financements'].values()
