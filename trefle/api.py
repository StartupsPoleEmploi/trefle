from http import HTTPStatus

from roll import HttpError, Roll
from roll.extensions import cors
import ujson as json

from . import VERSION, simulate, get_financements
from .config import FINANCEMENTS, GLOSSARY, NAF, IDCC, RAW_RULES, SCHEMA
from .debugging import data_from_lbf_url, make_scenario, SCENARIOS
from .exceptions import DataError
from .legacy import simulate_legacy
from .loggers import log_simulate, logger
from .openapis import OPENAPI
from .routine import get_formation_json, search_term

app = Roll()
cors(app)


@app.listen("response")
async def expose_version(request, response):
    """Ajout d'un header d'information pour la version

    :param request:
    :param response:
    """
    response.headers["Version"] = VERSION


@app.listen("error")
async def json_error_response(request, response, error):
    """Retour en json des erreurs

    :param request: requête HTTP
    :param response: réponse de l'API
    :param error: message de l'erreur
    """
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
    """Appel api de simulation

    Paramètrage de la requête:
    - eligible=1 ne renvoie que les financements éligibles
    - explain=1 renvoie les régles explicites qui s'appliquent pour l'élégibilité
    - scenario=1 renvoie des scénarios associés aux financements

    :param request: données en JSON envoyées en POST
    :param response: résultats en JSON de la simulation (la liste des financements)
    """
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


# Renvoie les financements en mode legacy (TMF)
app.route("/legacy", methods=["POST"])(simulate_legacy)


@app.route("/schema")
async def schema(request, response):
    """Renvoi le schéma des données en JSON

    :param request:
    :param response:
    """
    response.json = OPENAPI


@app.route("/naf")
async def naf(request, response):
    """Renvoi la liste JSON des codes NAF à la recherche

    exemple: /naf?q=charpentier

    :param request: q=(string|integer)
    :param response: JSON [{clé:{"code":clé, "label":label}},]
    """
    response.json = search_term(NAF, request.query.get("q"))


@app.route("/idcc")
async def idcc(request, response):
    """Renvoi la liste JSON des codes IDCC correspondant à la recherche

    exemple: /idcc?q=charpentier

    :param request: q=(string|int)
    :param response: JSON [{clé:{"convention collective":item1,"OPCO":item2}},]
    """
    response.json = search_term(IDCC, request.query.get("q"))


@app.route("/explore/schema")
async def explore_schema(request, response):
    """Renvoi le schéma de donnée en JSON

    :param request:
    :param response:
    """
    response.json = SCHEMA


@app.route("/explore/rules")
async def explore_rules(request, response):
    """Renvoi la liste des règles en JSON

    :param request:
    :param response:
    """
    response.json = RAW_RULES


@app.route("/explore/glossary")
async def explore_glossary(request, response):
    """Renvoi les entrées du glossaires en JSON

    :param request:
    :param response:
    """
    response.json = GLOSSARY


@app.route("/explore/financements")
async def explore_financements(request, response):
    """Renvoi la liste des financements en JSON

    :param request:
    :param response:
    """
    response.json = FINANCEMENTS


@app.route("/explore/scenarios")
async def explore_scenarios(request, response):
    """Renvoi la liste des scénarios en JSON

    :param request:
    :param response:
    """
    response.json = SCENARIOS


@app.route("/explore/catalog")
async def explore_catalog(request, response):
    """Interroge le catalogue de formation en foncion d'un id

    :param request: id du catalogue de formation
    :param response: JSON des données de formation
    """
    data = await get_formation_json(request.query.get("id"))
    response.body = json.dumps(data, indent=2, ensure_ascii=False)


@app.route("/explore/decode-lbf-url")
async def decode_lbf_url(request, response):
    """Décode une url LBF de simulation de financement

    :param request: url codé LBF de simulation de financement
    :param response: JSON des paramètres décodées
    """
    response.json = data_from_lbf_url(request.query.get("url"))
