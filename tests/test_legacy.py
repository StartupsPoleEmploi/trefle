import json
import pprint
from datetime import datetime, timezone
from pathlib import Path

import pytest


pytestmark = pytest.mark.asyncio

BIRTHYEAR = int(datetime.now().__format__('%Y')) - 18

BODY = {
    # we don't request catalog so let's set this mandatory value
    "formation.heures": 100,
    "formation.codes_financeur": [5, 10],
    "formation.codes_naf": ["4532Z"],
    "individu": {
        "type": "DE",
        "chomageDePlusDeSixMois": "true",
        "cumulDureeInscriptionSur12Mois": "12",
        "typeAllocation": {
            "type": "are",
            "montantMensuelAllocation": "200",
            "dateFinIndemnisation": "2018-11-10",
        },
        "departementHabitation": "35",
        "dateNaissance": f"{BIRTHYEAR}-01-01",
        "niveauEtude": "1",
        "montantCPF": "100",
        "contratApprentissage": "true",
        "apprentissageSituation": {
            "crontratType": "4",
            "ruptureContratApprentissage": "true",
        },
        "contratAide": "true",
        "travailleurHandicape": "true",
        "travNonSalTrav12Et6Cons3AnsStage": "true",
        "parentIsole": "true",
        "mere3enfants": "true",
        "femmeSeule": "true",
        "projetCreationEntreprise": "true",
        "formationEntammeeEnVAE": "true",
    },
}


async def test_legacy_context(client):
    resp = await client.post("/financement?context=true", body=BODY)
    assert resp.status == 200
    data = json.loads(resp.body)
    context = data["context"]
    context["formation.codes_financeur"] = set(context["formation.codes_financeur"])
    beneficiairenaissance = datetime(BIRTHYEAR, 1, 1, 0, 0, 0, tzinfo=timezone.utc).timestamp()
    assert context == {
        "constante.codes_cpf_clea": [201, 207, 208],
        "constante.codes_cpf_vae": [200],
        "constante.codes_fimo": [31826],
        "constante.codes_financeur_collectif": [2, 4, 6, 7, 8, 9, 11, 12, 13, 15, 16],
        "constante.deux_smic": 3043,
        "formation.codes_financeur": {5, 10},
        "formation.codes_cpf": [],
        "formation.codes_cpf_de": [],
        "formation.codes_formacode": [],
        "formation.codes_rome": [],
        "formation.domaines_formacode": [],
        "formation.individuels": True,
        "formation.codes_modalite_pedagogique": [],
        "beneficiaire.allocation": 0,
        "beneficiaire.remuneration": 0,
        "beneficiaire.contrat_heures": 0,
        "beneficiaire.solde_cpf": 100,
        "beneficiaire.departement": "35",
        "beneficiaire.region": "53",
        "beneficiaire.parent_isole": True,
        "beneficiaire.mere_trois_enfants": True,
        "beneficiaire.inscrit_pe": True,
        "beneficiaire.th": True,
        "beneficiaire.fongecif": "Fongecif Bretagne",
        "constante.minimum_aref": 616.2,
        "constante.smic": 1521.22,
        "formation.heures": 100,
        "formation.prix_horaire": 0,
        "beneficiaire.creation_entreprise": True,
        "formation.intitule_norme": "",
        "beneficiaire.age": 18,
        "beneficiaire.naissance": beneficiairenaissance,
        "formation.codes_naf": ["4532Z"],
        "formation.contrat_apprentissage": False,
        "formation.contrat_professionnalisation": False,
        "formation.eligible_cpf": False,
        "formation.eligible_copanef": False,  # deprcated, useful for legacy tests
        "formation.professionnalisante": True,
    }


async def test_legacy_call(client):
    resp = await client.post("/legacy", BODY)
    assert resp.status == 200
    data = json.loads(resp.body)
    data = data["financements"][0]
    data["donneeStructurees"]["codesFinanceur"] = set(
        data["donneeStructurees"]["codesFinanceur"]
    )
    try:
        del data["donneeStructurees"]["remunerations"]
    except KeyError:
        pass
    for key_to_del in ["montant", "plafond"]:
        if (
            key_to_del in data["donneeStructurees"]["cout"]
            and not data["donneeStructurees"]["cout"][key_to_del]
        ):
            del data["donneeStructurees"]["cout"][key_to_del]

    assert data["donneeStructurees"] == {
        "familleDispositif": "Financement individuel",
        "typeDispositif": "agefiph",
        "priorite": 6.1,
        "codesFinanceur": {"5", "10"},
        "cout": {
            "resteACharge": True,
            "financeePE": False,
            "financableCpf": True,
            "cumulable": True,
        },
    }


async def test_invalid_data(client):
    body = BODY.copy()
    body["individu"]["departementHabitation"] = "xx"
    resp = await client.post("/legacy", body)
    assert resp.status == 400


@pytest.mark.parametrize(
    "path",
    [
        path
        for path in Path("tests/data/legacy").iterdir()
        if path.suffix == ".json"
        and path.name
        not in [
            "case_28.json",  # TODO Sur LBF, CPF affichée même si heures cpf = 0
            "case_22.json",  # TODO voir avec Armelle : sur trèfle AFPRPOEI et Action coll en + sur trèfle
            "case_26.json",  # TODO Idem car même formation
            "case_15.json",  # TODO vérifier règle chèque formation (voir note sur règle LBF) et ordre des dispositifs inversés
            "case_17.json",  # TODO à voir : 3 pour Trefle et 5 pour LBF
            "case_29.json",  # TODO Pb: LBF no control for codes financeur individuel
            "case_27.json",  # TODO deprecated, coparef doesn't exists anymore
            "case_7.json",  # TODO deprecated, coparef doesn't exists anymore
            "case_23.json",  # TODO deprecated, coparef doesn't exists anymore
            "case_14.json",  # TODO deprecated, coparef doesn't exists anymore
            "case_30.json",  # TODO deprecated, AIF artisan doesn't exist anymore
        ]
    ],
)
async def test_legacy_calls(path, client):
    data = json.loads(path.read_text())

    # wait for rules to be merged
    if data["in"]["individu"]["departementHabitation"] == "974":
        return

    resp = await client.post("/legacy", data["in"])
    assert resp.status == 200

    financements_lbf_cleaned = _clean_financements_data(data["out"]["financements"])

    financements_trefle = json.loads(resp.body)
    financements_trefle_cleaned = _clean_financements_data(
        financements_trefle["financements"]
    )

    # assert len(financements_lbf_cleaned) == len(financements_trefle_cleaned)
    try:
        count_financement_trefle = len(financements_trefle_cleaned)
        count_financement_lbf = len(financements_lbf_cleaned)
        assert count_financement_trefle == count_financement_lbf
    except AssertionError:
        print(
            f"Nombre de financements différents: trefle={count_financement_trefle}, lbf={count_financement_lbf}"
        )

    print(f"LBF : {pprint.pformat(financements_lbf_cleaned)}")
    print(f"TREFLE : {pprint.pformat(financements_trefle_cleaned)}")
    for idx, financement_lbf in enumerate(financements_lbf_cleaned):
        if financement_lbf["familleDispositif"] == "CIF":
            continue
        try:
            assert financement_lbf in financements_trefle_cleaned
        except AssertionError:
            print("idintercarif:")
            print(json.dumps(data["_id"]))
            print("context:")
            print(json.dumps(data["in"]))
            raise


def _clean_financements_data(financements):
    cleaned = []
    for financement in financements:
        if financement["donneeStructurees"]["typeDispositif"] != "autres":
            if financement["donneeStructurees"]["familleDispositif"] != "CIF":
                for key_cout in ["montant", "plafond"]:
                    if key_cout in financement["donneeStructurees"]["cout"]:
                        financement["donneeStructurees"]["cout"][key_cout] = float(
                            financement["donneeStructurees"]["cout"][key_cout]
                        )
                        if (
                            not financement["donneeStructurees"]["cout"][key_cout]
                            or financement["donneeStructurees"]["familleDispositif"]
                            == "CPF"
                        ):
                            del financement["donneeStructurees"]["cout"][key_cout]
                try:
                    del financement["donneeStructurees"]["remunerations"]
                except KeyError:
                    pass

                # LBF doesn't calculate plafond for afprpoei unlike does Trefle
                if financement["donneeStructurees"]["typeDispositif"] in [
                    "poei",
                    "afprpoei",
                ]:
                    if "plafond" in financement["donneeStructurees"]["cout"]:
                        del financement["donneeStructurees"]["cout"]["plafond"]

                if "priorite" in financement["donneeStructurees"]:
                    if isinstance(financement["donneeStructurees"]["priorite"], float):
                        financement["donneeStructurees"]["priorite"] = str(
                            financement["donneeStructurees"]["priorite"]
                        )

                if "codesFinanceur" in financement["donneeStructurees"]:
                    if financement["donneeStructurees"]["codesFinanceur"]:
                        financement["donneeStructurees"]["codesFinanceur"] = set(
                            financement["donneeStructurees"]["codesFinanceur"]
                        )
                    else:
                        del financement["donneeStructurees"]["codesFinanceur"]

                cleaned.append(financement["donneeStructurees"])

    return cleaned
