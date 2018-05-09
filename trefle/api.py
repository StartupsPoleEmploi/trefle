import logging
from http import HTTPStatus

from roll import Roll, HttpError
from roll.extensions import cors

from .core import simulate
from .openapis import SCHEMA

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
    logger.debug(f'HttpError: status={error.status}, message={error.message}, '
                 f'request={request.body}')


@app.route('/financement', methods=['POST'])
async def simulate_(request, response):
    try:
        financements = simulate(**request.json)
    except ValueError as err:
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY, err.args[0])
    eligible = request.query.bool('eligible', None)
    if eligible is not None:
        financements = [f for f in financements if f['eligible'] == eligible]
    response.json = {'financements': financements}


@app.route('/schema')
async def schema(request, response):
    response.json = SCHEMA
