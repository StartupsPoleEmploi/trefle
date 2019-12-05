import pkg_resources

from . import config
from . import routine
from .context import Context
from .helpers import flatten

config.init()

VERSION = pkg_resources.get_distribution(__package__).version


async def simulate(data, financements):
    # Prepare context
    flatten(data)
    context = Context(data.copy())
    await routine.populate_formation(context)
    routine.extrapolate_context(context)
    routine.preprocess(context)

    # Compute organisme, prise en charge, rémunération per financement
    for financement in financements:
        copy = context.copy()
        routine.check_financement(copy, financement)
        # Do our best to show cleaned data to user eyes.
        data.update(copy.cleaned_data)

    # FIXME (limits of the single-store-all context object)
    # Clean keys not meant to be exposed
    for key in list(data.keys()):
        if key.startswith("financement"):
            del data[key]


def get_financements(tags=None):
    financements = [config.Financement(f) for f in config.FINANCEMENTS]
    for tag in tags or []:
        financements = [f for f in financements if tag in f["tags"]]
    return financements


def get_remunerations(tags=None):
    remunerations = [config.Remuneration(f) for f in config.REMUNERATIONS]
    for tag in tags or []:
        remunerations = [f for f in remunerations if tag in f["tags"]]
    return remunerations
