import logging
import pkg_resources
from http import HTTPStatus

from roll import HttpError, Roll
from roll.extensions import cors

from .config import RAW_RULES, SCHEMA, GLOSSARY
from .core import simulate
from .debugging import data_from_lbf_url, make_feature
from .openapis import OPENAPI

logger = logging.getLogger('trefle')
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())

app = Roll()
cors(app)


VERSION = pkg_resources.get_distribution(__package__).version


@app.listen('response')
async def expose_version(request, response):
    response.headers['Version'] = VERSION


@app.listen('error')
async def json_error_response(request, response, error):
    body = error.message
    if isinstance(body, (str, bytes)):
        body = {'error': body}
    response.json = body
    if error.status != HTTPStatus.NOT_FOUND:
        logger.debug(f'HttpError: status={error.status}, version={VERSION}, '
                     f'message={response.body}, request={request.body}')


@app.route('/financement', methods=['POST'])
async def simulate_(request, response):
    context = request.json
    try:
        financements = await simulate(context)
    except ValueError as err:
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY, err.args[0])

    eligible = request.query.bool('eligible', None)
    if eligible is not None:
        financements = [f for f in financements if f['eligible'] == eligible]
    for tag in request.query.list('tags', []):
        financements = [f for f in financements if tag in f['tags']]
    body = {'financements': financements}
    del context['financements']
    if request.query.bool('context', False):
        body['context'] = {k: {'label': SCHEMA[k]['label'], 'value': v}
                           for k, v in context.items()
                           if k in SCHEMA and 'label' in SCHEMA[k]}
    if request.query.bool('scenario', False):
        body['scenario'] = make_feature(context, financements)
    response.json = body


@app.route('/schema')
async def schema(request, response):
    response.json = OPENAPI


@app.route('/explore/schema')
async def explore_schema(request, response):
    response.json = SCHEMA


@app.route('/explore/rules')
async def explore_rules(request, response):
    response.json = RAW_RULES


@app.route('/explore/glossary')
async def explore_glossary(request, response):
    response.json = GLOSSARY


@app.route('/explore/decode-lbf-url')
async def decode_lbf_url(request, response):
    try:
        response.json = data_from_lbf_url(request.query.get('url'))
    except ValueError as err:
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY, err.args[0])
