import datetime
import re
from http import HTTPStatus

import gitlab
import hashlib

from roll import HttpError, Roll
from roll.extensions import cors

import ujson as json

from . import VERSION, get_financements, get_remunerations, simulate
from . import routine
from .config import AUTHORIZED, FINANCEMENTS, COMMIT_AUTHORIZED, GLOSSARY, IDCC, NAF, CERTIFINFO, RAW_RULES, SCHEMA, GITLAB_TOKEN
from .context import Context
from .debugging import SCENARIOS, data_from_lbf_url, make_scenario
from .exceptions import DataError, UnauthorizedAccess, NotModifiedError
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


@app.route("/financement", methods=["POST"])
async def simulate_(request, response):
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
            k: v for k, v in context.items()
            if k in SCHEMA and "label" in SCHEMA[k]}
    if request.query.bool("scenario", False):
        body["scenario"] = make_scenario(context, financements)
    response.json = body

    log_simulate(context, financements=financements)


# TODO : add pointer error for bad region number + test
@app.route("/remuneration", methods=["POST"])
async def remuneration_(request, response):
    data = request.json
    remunerations = get_remunerations(tags=request.query.list("tags", []))
    try:
        flatten(data)
        context = Context(data.copy())
        routine.extrapolate_context(context)
        routine.preprocess(context)
        for remuneration in remunerations:
            copy = context.copy()
            routine.check_remuneration(context, remuneration)
            data.update(copy.cleaned_data)

        # FIXME (limits of the single-store-all context object)
        # Clean keys not meant to be exposed
        for key in list(data.keys()):
            if key.startswith("remuneration"):
                del data[key]

    except DataError as err:
        error = {err.key: err.error}
        log_simulate(context, errors=error)
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY, error)

    # TODO: explain only for financement see routine.py check_remuneration
    # explain = request.query.bool("explain", False)
    # for remuneration in remunerations:
    #     remuneration["explain"] = (
    #         [s.json for s in remunerations["explain"]] if explain else None
    #     )

    body = {"remunerations": remunerations}
    # if request.query.bool("context", False):
    #     body["context"] = {
    #         k: v for k, v in context.items()
    #         if k in SCHEMA and "label" in SCHEMA[k]}
    response.json = body
    """
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
    """


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
    data = request.json
    date = datetime.datetime.today().strftime('%y%m%d')
    authsuccess = False
    for authorized in AUTHORIZED:
        aemail = authorized['email']
        apassword = authorized['password']
        afile = authorized['file']
        atoken = hash(f"{aemail}.{apassword}.{date}")
        if data.get('email') == aemail and data.get('password') == apassword:
            try:
                if re.match(afile, data.get('file')):
                    authsuccess = True
                    logger.debug(f"authentification succeed for {data.get('file')} modification")
                    break
                else:
                    raise HttpError(HTTPStatus.UNAUTHORIZED,
                                    'Non authorisé à modifier le fichier.')
            except re.error:
                raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY,
                                'Le motif de fichier autorisé est invalide.')
        else:
            continue

    if data.get('token') != atoken and not authsuccess:
        raise HttpError(HTTPStatus.UNAUTHORIZED,
                        'Le token n\'est pas reconnu.')
    elif data.get('token','') == '' and not authsuccess:
        raise HttpError(HTTPStatus.UNAUTHORIZED,
                        'Email ou mot de passe non reconnu.')
    else:
        response.json = {'token': atoken}
        logger.debug(f"authentification succeed for {data.get('file')} modification")


@app.route("/source/modified")
async def source_modified(request, response):
    gl = gitlab.Gitlab('https://git.beta.pole-emploi.fr', private_token=GITLAB_TOKEN)
    project = gl.projects.get('open-source/trefle', lazy=True)
    branch = f"modification-{fold_name(request.query.get('branch','')).lower()}"
    branches = project.branches.list(search=f'^RULE-{branch}')
    modified = {}
    for branch in branches:
        commit = project.commits.get(branch.get_id()).diff()
        modified[branch.attributes.get('commit').get('short_id')] = {
            'id': branch.attributes.get('commit').get('id'),
            'branch': branch.name,
            'title': branch.attributes.get('commit').get('title'),
            'message': branch.attributes.get('commit').get('message'),
            'author_name': branch.attributes.get('commit').get('author_name'),
            'date': branch.attributes.get('commit').get('authored_date'),
            'file': commit[0].get('new_path'),  # NOTE: only one commit per branch
            'diff': commit[0].get('diff')
            }
    response.json = modified


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
        raise HttpError(HTTPStatus.UNPROCESSABLE_ENTITY, message=err)
    # now = datetime.datetime.today().strftime('%y%m%d%H%M')
    # request_data = request.json
    # commit_message = request_data.get('comment')
    # filename = request_data.get('filename')
    # content = request_data.get('content')
    # mail = request_data.get('author_email')
    # name = request_data.get('author_name')

    # gl = gitlab.Gitlab('https://git.beta.pole-emploi.fr', private_token=GITLAB_TOKEN)
    # project = gl.projects.get('open-source/trefle', lazy=True)
    # branch = f"modification-{fold_name(request_data.get('title')).lower()}"

    # original_fingerprint = hash(project.files.get(filename,
    #                                               ref='master').decode().decode())
    # modified_fingerprint = hash(content)
    # is_modified = original_fingerprint != modified_fingerprint

    # data = {
    #     'branch': f'RULE-{branch}-{now}',
    #     'start_branch': 'master',
    #     'commit_message': commit_message,
    #     'author_email': mail,
    #     'author_name': name,
    #     'actions': [
    #         {
    #             'action': 'update',
    #             'file_path': filename,
    #             'content': content,
    #         }
    #     ]
    # }

    # if not is_modified:
    #     raise HttpError(HTTPStatus.NOT_MODIFIED, message="Aucune modification apportée")

    # if mail in COMMIT_AUTHORIZED:
    #     commit = project.commits.create(data)
    # else:
    #     raise HttpError(HTTPStatus.UNAUTHORIZED, 'Code vide ou invalide')

    # response.json = commit.attributes
