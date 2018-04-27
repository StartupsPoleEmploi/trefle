import json
from http import HTTPStatus

from roll import Roll, HttpError
from roll.extensions import cors

from .core import simulate
from .config import init
from .openapis import SCHEMA


app = Roll()
cors(app)


@app.listen('startup')
async def startup():
    init()


@app.route('/financement', methods=['POST'])
async def simulate_(request, response):
    try:
        passed, failed = simulate(**request.json)
    except ValueError as err:
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY,
                        json.dumps(err.args[0]))
    response.json = {'eligibles': passed, 'non_eligibles': failed}


@app.route('/schema')
async def schema(request, response):
    response.json = SCHEMA
