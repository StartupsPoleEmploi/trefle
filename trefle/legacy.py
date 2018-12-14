from http import HTTPStatus

from roll import HttpError

from trefle import simulate, get_financements
from trefle.exceptions import DataError
from trefle.loggers import log_simulate


FAMILLE_MAPPING = {
    "POEC": "Actions collectives",
    "AFPR": "Formation / emploi",
    "contrat apprentissage": "Formation / emploi",
    "contrat professionnalisation": "Formation / emploi",
    "CIF": "CIF",
    "CPF": "CPF",
    "AFC": "Actions collectives",
    "individuel": "Financement individuel",
    "collectif": "Actions collectives",
}


async def simulate_legacy(request, response):
    context = request.json
    context["individu"]["departementHabitation"] = context["individu"][
        "departementHabitation"
    ].upper()
    financements = get_financements(tags=request.query.list("tags", []))
    try:
        await simulate(context, financements)
    except DataError as err:
        error = {err.key: err.error}
        log_simulate(context, errors=error)
        raise HttpError(HTTPStatus.BAD_REQUEST, error)

    financements = [f for f in financements if f["eligible"]]
    log_simulate(context, financements=financements)
    mapped = []
    for financement in financements:
        for tag, label in FAMILLE_MAPPING.items():
            if tag in financement.tags:
                famille = label
                break
        else:
            famille = "Formation / emploi"

        # codes financeur actually retrieve from ad
        codes_financeur = context["formation.codes_financeur"] or []

        if financement.type_lbf == "aif" and context.get(
            "formation.bilan_de_competences"
        ):
            financement.type_lbf = "aifbilancompetence"

        if financement.type_lbf == "aif" and context.get("formation.permisb"):
            financement.type_lbf = "finindividuelpermisb"

        if (
            financement.type_lbf == "afprpoei"
            and context.get("beneficiaire.departement") == "971"
        ):
            financement.type_lbf = "poei"

        data = {
            "libelle": financement.intitule,
            "donneeConsolidees": {
                "description": financement.demarches,
                "infoComplementaires": financement.description,
                "cout": financement.prise_en_charge_texte,
                "remuneration": financement.remuneration_texte,
            },
            "donneeStructurees": {
                "familleDispositif": famille,
                "typeDispositif": financement.type_lbf,
                "priorite": financement.priorite_lbf,
                "codesFinanceur": list(map(str, codes_financeur)),
                "cout": {
                    "resteACharge": "partiellement"
                    in financement.prise_en_charge_texte,  # TODO see in PHP code logic to determine this bool value
                    "financeePE": financement.financee_pe,
                    "financableCpf": financement.cpf_mobilisable,
                    "cumulable": financement.cumulable,  # TODO voir avec Armelle pour fixer cette valeur dans financement.yml
                },
            },
        }
        if financement.remuneration:
            data["donneeStructurees"]["remunerations"] = [
                {"montant": financement.remuneration, "nature": "brut"}
            ]

        if financement.plafond_prix_horaire and financement.type_lbf == "cpf":
            data["donneeStructurees"]["cout"]["montant"] = "%.2f" % (
                context.get("beneficiaire.solde_cpf") * financement.plafond_prix_horaire
            )
        elif financement.get("plafond_prise_en_charge") not in [0, None]:
            if financement.type_lbf == "aifartisan":
                data["donneeStructurees"]["cout"]["montant"] = "%.2f" % financement.get(
                    "plafond_prise_en_charge"
                )
            elif financement.type_lbf != "cpf":
                data["donneeStructurees"]["cout"]["plafond"] = "%.2f" % financement.get(
                    "plafond_prise_en_charge"
                )
        if not financement.remuneration_texte:
            if financement.remuneration:
                financement.remuneration_texte = (
                    f"Vous percevrez {financement.remuneration} € brut / mois"
                )
            else:
                financement.remuneration_texte = f"Pas de rémunération spécifique"

        mapped.append(data)
    response.json = {"financements": mapped}
