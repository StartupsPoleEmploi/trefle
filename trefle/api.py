import json
from http import HTTPStatus

from roll import Roll, HttpError
from roll.extensions import cors

from .core import simulate
from .openapis import SCHEMA


app = Roll()
cors(app)


@app.route('/financement', methods=['POST'])
async def simulate_(request, response):
    try:
        financements = simulate(**request.json)
    except ValueError as err:
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY,
                        json.dumps(err.args[0]))
    response.json = {'collection': financements}


@app.route('/schema')
async def schema(request, response):
    response.json = SCHEMA
