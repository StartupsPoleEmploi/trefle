from roll import Roll

from .core import simulate


app = Roll()


@app.route('/', methods=['POST'])
async def simulate_(request, response):
    passed, failed = simulate(**request.json)
    response.json = {'passed': passed, 'failed': failed}
