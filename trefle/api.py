from http import HTTPStatus

from roll import HttpError, Roll
from roll.extensions import cors

from . import VERSION
from .config import FINANCEMENTS, GLOSSARY, NAF, RAW_RULES, SCHEMA
from .core import simulate
from .debugging import data_from_lbf_url, make_scenario, SCENARIOS
from .loggers import log_simulate, logger
from .openapis import OPENAPI
from .routine import get_formation_xml

app = Roll()
cors(app)


@app.listen('response')
async def expose_version(request, response):
    response.headers['Version'] = VERSION


@app.listen('error')
async def json_error_response(request, response, error):
    if isinstance(error.message, (str, bytes)):
        error.message = {'error': error.message}
    response.json = error.message
    if error.status != HTTPStatus.NOT_FOUND:
        logger.debug(f'HttpError: status={error.status}, version={VERSION}, '
                     f'message={response.body}, request={request.body}')


@app.route('/financement', methods=['POST'])
async def simulate_(request, response):
    context = request.json
    try:
        financements = await simulate(context)
    except ValueError as err:
        if isinstance(err.args[0], dict):
            # FIXME this can be improved
            log_simulate(context, errors=err.args[0])
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY, err.args[0])

    eligible = request.query.bool('eligible', None)
    if eligible is not None:
        financements = [f for f in financements if f['eligible'] == eligible]
    for tag in request.query.list('tags', []):
        financements = [f for f in financements if tag in f['tags']]
    for financement in financements:
        financement['status'] = [s.json for s in financement['status']]
    body = {'financements': financements}
    if request.query.bool('context', False):
        body['context'] = {k: v for k, v in context.items()
                           if k in SCHEMA and 'label' in SCHEMA[k]}
    if request.query.bool('scenario', False):
        body['scenario'] = make_scenario(context, financements)
    response.json = body

    log_simulate(context, financements=financements)


@app.route('/schema')
async def schema(request, response):
    response.json = OPENAPI


@app.route('/naf')
async def naf(request, response):
    response.json = NAF.get(request.query.get('q'), [])


@app.route('/explore/schema')
async def explore_schema(request, response):
    response.json = SCHEMA


@app.route('/explore/rules')
async def explore_rules(request, response):
    response.json = RAW_RULES


@app.route('/explore/glossary')
async def explore_glossary(request, response):
    response.json = GLOSSARY


@app.route('/explore/financements')
async def explore_financements(request, response):
    response.json = FINANCEMENTS


@app.route('/explore/scenarios')
async def explore_scenarios(request, response):
    response.json = SCENARIOS


@app.route('/explore/catalog')
async def explore_catalog(request, response):
    response.body = await get_formation_xml(request.query.get('id'))
    response.headers['Content-Type'] = 'text/xml'


@app.route('/explore/decode-lbf-url')
async def decode_lbf_url(request, response):
    response.json = data_from_lbf_url(request.query.get('url'))
