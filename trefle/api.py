import datetime
import os
import re
from http import HTTPStatus

import gitlab

from roll import HttpError, Roll
from roll.extensions import cors

import ujson as json

from . import (
    VERSION,
    get_financements,
    get_remunerations,
    simulate,
    simulate_remuneration,
)
from . import routine
from .config import AUTHORIZED, FINANCEMENTS, COMMIT_AUTHORIZED, GLOSSARY, IDCC, NAF, CERTIFINFO, RAW_RULES, SCHEMA, GITLAB_TOKEN
from .context import Context
from .debugging import SCENARIOS, data_from_lbf_url, make_scenario
from .exceptions import DataError, NotModifiedError, UnauthorizedAccess
from .helpers import flatten, fold_name
from .legacy import simulate_legacy
from .loggers import log_simulate, logger
from .openapis import OPENAPI
from .routine import get_formation_json, search_term
from .source import submit_modification

app = Roll()
cors(app)


@app.listen("response")
async def expose_version(request, response):
    response.headers["Version"] = VERSION


@app.listen("error")
async def json_error_response(request, response, error):
    if isinstance(error.message, (str, bytes)):
        error.message = {"error": error.message}
    response.json = error.message
    if error.status != HTTPStatus.NOT_FOUND:
        logger.debug(
            f"HttpError: status={error.status}, version={VERSION}, "
            f"message={response.body}, request={request.body}, url={request.url}"
        )


@app.route("/healthcheck")
async def healthcheck(request, response):
    response.json = {
        "status": "running",
        "version": f"{VERSION}",
        "last version": f"{os.environ.get('VERSION', 'NaN')}",
        "back version": f"{os.environ.get('OLD_VERSION', 'NaN')}",
    }


@app.route("/financement", methods=["POST"])
async def simulate_(request, response):
    context = request.json
    financements = get_financements(tags=request.query.list("tags", []))
    try:
        await simulate(context, financements)
    except DataError as err:
        error = {err.key: err.error}
        log_simulate(request, response, context, errors=error)
        raise HttpError(HTTPStatus.BAD_REQUEST, error)

    eligible = request.query.bool("eligible", None)
    if eligible is not None:
        financements = [f for f in financements if f["eligible"] == eligible]
    else:
        financements = sorted(
            financements, key=lambda value: value["eligible"], reverse=True
        )

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

    log_simulate(request, response, context, financements=financements)


# TODO : add pointer error for bad region number + test
@app.route("/remuneration-aide", methods=["POST"])
async def remuneration_(request, response):
    context = request.json
    remunerations = get_remunerations(tags=request.query.list("tags", []))
    try:
        await simulate_remuneration(context, remunerations)
    except DataError as err:
        error = {err.key: err.error}
        log_simulate(request, response, context, errors=error)
        raise HttpError(HTTPStatus.BAR_REQUEST, error)

    eligible = request.query.bool("eligible", None)
    if eligible is not None:
        remunerations = [r for r in remunerations if r["eligible"] == eligible]
    else:
        remunerations = sorted(
            remunerations, key=lambda value: value["eligible"], reverse=True
        )
    explain = request.query.bool("explain", False)
    for remuneration in remunerations:
        remuneration["explain"] = (
            [s.json for s in remunerations["explain"]] if explain else None
        )

    body = {"remunerations": remunerations}
    if request.query.bool("context", False):
        body["context"] = {
            k: v for k, v in context.items()
            if k in SCHEMA and "label" in SCHEMA[k]}
    response.json = body


app.route("/legacy", methods=["POST"])(simulate_legacy)


@app.route("/schema")
async def schema(request, response):
    response.json = OPENAPI


@app.route("/naf")
async def naf(request, response):
    response.json = search_term(NAF, request.query.get("q"))


@app.route("/idcc")
async def idcc(request, response):
    response.json = search_term(IDCC, request.query.get("q"))


@app.route("/certifinfo")
async def certifinfo(request, response):
    response.json = search_term(CERTIFINFO, request.query.get("q"))


@app.route("/explore/schema")
async def explore_schema(request, response):
    response.json = SCHEMA


@app.route("/explore/rules")
async def explore_rules(request, response):
    response.json = RAW_RULES


@app.route("/explore/glossary")
async def explore_glossary(request, response):
    response.json = GLOSSARY


@app.route("/explore/financements")
async def explore_financements(request, response):
    response.json = FINANCEMENTS


@app.route("/explore/scenarios")
async def explore_scenarios(request, response):
    response.json = SCENARIOS


@app.route("/explore/catalog")
async def explore_catalog(request, response):
    data = await get_formation_json(request.query.get("id"))
    response.body = json.dumps(data, indent=2, ensure_ascii=False)


@app.route("/explore/decode-lbf-url")
async def decode_lbf_url(request, response):
    response.json = data_from_lbf_url(request.query.get("url"))


@app.route("/authentification", ['POST'])
async def authent(request, response):
    # TODO check mail format
    try:
        data = request.json
    except ValueError as err:
        raise HttpError(HTTPStatus.BAD_REQUEST, message=err)

    date = datetime.datetime.today().strftime('%y%m%d')
    authsuccess = False
    for authorized in AUTHORIZED:
        aemail = authorized['email'].lower()
        apassword = authorized['password']
        afile = authorized['file']
        atoken = hash(f"{aemail}.{apassword}.{date}")
        if str(data.get('email')).lower() == aemail and data.get('password') == apassword:
            try:
                if any(bool(re.match(afile, f)) for f in  data.get('file').split("|")):
                    authsuccess = True
                    logger.debug(f"authentification succeed for {data.get('file')} modification")
                    break
                else:
                    raise HttpError(HTTPStatus.UNAUTHORIZED,
                                    f'Authorisé à modifier le fichier \'{afile}\' mais '
                                    + 'non authorisé à modifier le fichier \''
                                    + data.get('file') + '\'.')
            except re.error:
                raise HttpError(HTTPStatus.BAD_REQUEST,
                                'Le motif de fichier autorisé est invalide.')
        else:
            continue

    if not bool(AUTHORIZED):
        raise ValueError("Il n'existe pas encore d'autorisations (fichier"
                         + " authorisations.csv vide ou inexistant).")
    elif data.get('token', '') == '' and not authsuccess:
        raise HttpError(HTTPStatus.UNAUTHORIZED,
                        'Email ou mot de passe non reconnu.')
    elif data.get('token') != atoken and not authsuccess:
        raise HttpError(HTTPStatus.UNAUTHORIZED,
                        'Le token n\'est pas reconnu.')
    else:
        response.json = {'token': atoken}
        logger.debug(f"authentification succeed for {data.get('file')} modification")


@app.route("/source/modified")
async def source_modified(request, response):
    gl = gitlab.Gitlab('https://git.beta.pole-emploi.fr', private_token=GITLAB_TOKEN)
    project = gl.projects.get('open-source/trefle', lazy=True)
    merges = project.mergerequests.list(state="opened", labels=["RULE"])
    branch_filter = ''
    if(request.query.get('branch', '')):
        branch_filter = f"modification-{fold_name(request.query.get('branch','')).lower()}"
    modified = {}
    for merge in merges:
        commits = merge.commits()
        branch_name = f"modification-{fold_name(merge.title).lower()}"
        if(not branch_filter or branch_filter == branch_name):
            for commit in commits:
                diff = commit.diff()[-1]
                modified[commit.attributes.get('short_id')] = {
                    'id': commit.attributes.get('id'),
                    'branch': f"RULE-{branch_name}",
                    'title': commit.attributes.get('title'),
                    'message': commit.attributes.get('message'),
                    'author_name': commit.attributes.get('author_name'),
                    'date': commit.attributes.get('authored_date'),
                    'file': diff.get('new_path'),
                    'diff': diff.get('diff')
                    }
    response.json = modified


@app.route("/source/file")
async def source_file(request, response):
    gl = gitlab.Gitlab('https://git.beta.pole-emploi.fr', private_token=GITLAB_TOKEN)
    project = gl.projects.get('open-source/trefle', lazy=True)
    commit_id = request.query.get('commit_id', '')
    file_name = request.query.get('file', '')
    if(commit_id and file_name):
        response.json = project.files.get(file_path=file_name,
                                          ref=commit_id).decode().decode()


@app.route("/source/save", ['POST'])
async def source_save(request, response):
    # TODO log errors
    try:
        response.json = await submit_modification(request.json)
    except UnauthorizedAccess:
        raise HttpError(HTTPStatus.UNAUTHORIZED, 'Mail non authorisé à soumettre une modification')
    except NotModifiedError:
        raise HttpError(HTTPStatus.NOT_MODIFIED, message="Aucune modification apportée")
    except ValueError as err:
        raise HttpError(HTTPStatus.BAD_REQUEST, message=err)
