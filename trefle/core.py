from . import routine
from .config import FINANCEMENTS
from .context import Context
from .helpers import flatten


async def simulate(data):
    # Prepare context
    flatten(data)
    context = Context(data.copy())
    routine.extrapolate_context(context)
    await routine.populate_formation(context)
    routine.preprocess(context)

    financements = [f.copy() for f in FINANCEMENTS]
    # Compute organisme, prise en charge, rémunération per financement
    for financement in financements:
        copy = context.copy()
        routine.check_financement(copy, financement)
        # Do our best to show cleaned data to user eyes.
        data.update(copy.cleaned_data)

    # FIXME (limits of the single-store-all context object)
    # Clean keys not meant to be exposed (some should not be in context)
    for key in list(data.keys()):
        if key.startswith(('status', 'parent', 'financement')):
            del data[key]

    return financements
