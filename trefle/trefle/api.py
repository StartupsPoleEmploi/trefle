from http import HTTPStatus

from roll import HttpError, Roll
from roll.extensions import cors

import ujson as json

from . import VERSION, get_financements, get_remunerations, simulate
from . import routine
from .config import FINANCEMENTS, GLOSSARY, IDCC, NAF, RAW_RULES, SCHEMA
from .context import Context
from .debugging import SCENARIOS, data_from_lbf_url, make_scenario
from .exceptions import DataError
from .helpers import flatten
from .legacy import simulate_legacy
from .loggers import log_simulate, logger
from .openapis import OPENAPI
from .routine import get_formation_json, search_term

app = Roll()
cors(app)


@app.listen("response")
async def expose_version(request, response):
    response.headers["Version"] = VERSION


@app.listen("error")
async def json_error_response(request, response, error):
    if isinstance(error.message, (str, bytes)):
        error.message = {"error": error.message}
    response.json = error.message
    if error.status != HTTPStatus.NOT_FOUND:
        logger.debug(
            f"HttpError: status={error.status}, version={VERSION}, "
            f"message={response.body}, request={request.body}"
        )


@app.route("/financement", methods=["POST"])
async def simulate_(request, response):
    context = request.json
    financements = get_financements(tags=request.query.list("tags", []))
    try:
        await simulate(context, financements)
    except DataError as err:
        error = {err.key: err.error}
        log_simulate(context, errors=error)
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY, error)

    eligible = request.query.bool("eligible", None)
    if eligible is not None:
        financements = [f for f in financements if f["eligible"] == eligible]
    else:
        financements = sorted(
            financements, key=lambda value: value["eligible"], reverse=True
        )

    explain = request.query.bool("explain", False)
    for financement in financements:
        financement["explain"] = (
            [s.json for s in financement["explain"]] if explain else None
        )
    body = {"financements": financements}
    if request.query.bool("context", False):
        body["context"] = {
            k: v for k, v in context.items()
            if k in SCHEMA and "label" in SCHEMA[k]}
    if request.query.bool("scenario", False):
        body["scenario"] = make_scenario(context, financements)
    response.json = body

    log_simulate(context, financements=financements)


# TODO : add pointer error for bad region number + test
@app.route("/remuneration", methods=["POST"])
async def remuneration_(request, response):
    data = request.json
    remunerations = get_remunerations(tags=request.query.list("tags", []))
    try:
        flatten(data)
        context = Context(data.copy())
        routine.extrapolate_context(context)
        routine.preprocess(context)
        for remuneration in remunerations:
            copy = context.copy()
            routine.check_remuneration(context, remuneration)
            data.update(copy.cleaned_data)

        # FIXME (limits of the single-store-all context object)
        # Clean keys not meant to be exposed
        for key in list(data.keys()):
            if key.startswith("remuneration"):
                del data[key]

    except DataError as err:
        error = {err.key: err.error}
        log_simulate(context, errors=error)
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY, error)

    # TODO: explain only for financement see routine.py check_remuneration
    # explain = request.query.bool("explain", False)
    # for remuneration in remunerations:
    #     remuneration["explain"] = (
    #         [s.json for s in remunerations["explain"]] if explain else None
    #     )

    body = {"remunerations": remunerations}
    # if request.query.bool("context", False):
    #     body["context"] = {
    #         k: v for k, v in context.items()
    #         if k in SCHEMA and "label" in SCHEMA[k]}
    response.json = body
    """
    try:
        await simulate(context, financements)
    except DataError as err:
        error = {err.key: err.error}
        log_simulate(context, errors=error)
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY, error)

    eligible = request.query.bool("eligible", None)
    if eligible is not None:
        financements = [f for f in financements if f["eligible"] == eligible]
    else:
        financements = sorted(financements, key=lambda value: value["eligible"],
                              reverse=True)

    explain = request.query.bool("explain", False)
    for financement in financements:
        financement["explain"] = (
            [s.json for s in financement["explain"]] if explain else None
        )
    body = {"financements": financements}
    if request.query.bool("context", False):
        body["context"] = {
            k: v for k, v in context.items() if k in SCHEMA and "label" in SCHEMA[k]
        }
    if request.query.bool("scenario", False):
        body["scenario"] = make_scenario(context, financements)
    response.json = body

    log_simulate(context, financements=financements)
    """


app.route("/legacy", methods=["POST"])(simulate_legacy)


@app.route("/schema")
async def schema(request, response):
    response.json = OPENAPI


@app.route("/naf")
async def naf(request, response):
    response.json = search_term(NAF, request.query.get("q"))


@app.route("/idcc")
async def idcc(request, response):
    response.json = search_term(IDCC, request.query.get("q"))


@app.route("/explore/schema")
async def explore_schema(request, response):
    response.json = SCHEMA


@app.route("/explore/rules")
async def explore_rules(request, response):
    response.json = RAW_RULES


@app.route("/explore/glossary")
async def explore_glossary(request, response):
    response.json = GLOSSARY


@app.route("/explore/financements")
async def explore_financements(request, response):
    response.json = FINANCEMENTS


@app.route("/explore/scenarios")
async def explore_scenarios(request, response):
    response.json = SCENARIOS


@app.route("/explore/catalog")
async def explore_catalog(request, response):
    data = await get_formation_json(request.query.get("id"))
    response.body = json.dumps(data, indent=2, ensure_ascii=False)


@app.route("/explore/decode-lbf-url")
async def decode_lbf_url(request, response):
    response.json = data_from_lbf_url(request.query.get("url"))
