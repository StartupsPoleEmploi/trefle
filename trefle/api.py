import logging
from http import HTTPStatus

from roll import Roll, HttpError
from roll.extensions import cors

from .core import simulate
from .openapis import OPENAPI

logger = logging.getLogger('trefle')
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())

app = Roll()
cors(app)


@app.listen('error')
async def json_error_response(request, response, error):
    body = error.message
    if isinstance(body, (str, bytes)):
        body = {'error': body}
    response.json = body
    if error.status != HTTPStatus.NOT_FOUND:
        logger.debug(f'HttpError: status={error.status}, '
                     f'message={error.message}, request={request.body}')


@app.route('/financement', methods=['POST'])
async def simulate_(request, response):
    try:
        financements = await simulate(**request.json)
    except ValueError as err:
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY, err.args[0])

    eligible = request.query.bool('eligible', None)
    if eligible is not None:
        financements = [f for f in financements if f['eligible'] == eligible]
    for tag in request.query.list('tags', []):
        financements = [f for f in financements if tag in f['tags']]
    response.json = {'financements': financements}


@app.route('/schema')
async def schema(request, response):
    response.json = OPENAPI
