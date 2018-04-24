from roll import Roll

from .core import simulate
from .openapis import SCHEMA


app = Roll()


@app.route('/simulate', methods=['POST'])
async def simulate_(request, response):
    passed, failed = simulate(**request.json)
    response.json = {'passed': passed, 'failed': failed}


@app.route('/schema')
async def schema(request, response):
    response.json = SCHEMA
