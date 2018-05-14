from . import routine
from .validators import validate


async def simulate(**data):
    # Prepare data
    routine.add_constants(data)
    routine.flatten(data)
    routine.preload_financements(data)
    validate(data)
    await routine.populate_formation(data)
    routine.idcc_to_organismes(data)

    # Compute financements eligibles
    routine.check_eligibilite(data)

    # Compute organisme, prise en charge, rémunération per financement
    for financement in data['financements'].values():
        routine.populate_financement(data.copy(), financement)

    return data['financements'].values()
