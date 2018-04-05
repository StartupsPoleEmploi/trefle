from roll import Roll

from .core import simulate as do_simulate


app = Roll()


@app.route('/', methods=['POST'])
async def simulate(request, response):
    passed, failed = do_simulate(**request.json)
    response.json = {'passed': passed, 'failed': failed}
