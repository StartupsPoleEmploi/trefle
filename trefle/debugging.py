import base64
import bz2
import os
import sys
from datetime import datetime
from pathlib import Path
from urllib.parse import parse_qsl, urlparse

import phpserialize
from behave.runner_util import parse_features
from unidecode import unidecode

from .config import SCHEMA, FINANCEMENTS
from .helpers import flatten


SCENARIOS = []


def yellow(s):
    return f"\x1b[1;33m{s}\x1b[0m"


def green(s):
    return f"\x1b[1;32m{s}\x1b[0m"


def red(s):
    return f"\x1b[1;31m{s}\x1b[0m"


def trace_condition(condition):
    assess_orig = condition.assess

    def assess_wrapper(context):
        status = assess_orig(context)
        condition._return_values.append(bool(status))

        params = {}
        for param in status.params.values():
            if param.json:
                params.update(param.json)
        if params:
            condition._called_with.append(params)
        return status

    condition.assess = assess_wrapper
    condition._return_values = []
    condition._called_with = []
    for sub in condition.terms:
        trace_condition(sub)
    for child in condition.children:
        trace_condition(child)


def data_from_lbf_url(url):
    charmap = os.environ.get("LBF_CHARMAP")
    if not charmap:
        sys.exit(
            "You need the LBF_CHARMAP env var to be set. It's on the " "form ab,cd…"
        )
    charmap = {from_: to for from_, to in charmap.split(",")}

    args = dict(parse_qsl(urlparse(url).query))

    try:
        encrypted = args["a"]
        encrypted = "".join(charmap[char] for char in encrypted[8:])
        serialized = base64.b64decode(encrypted)
        serialized = bz2.decompress(serialized)
        data = phpserialize.loads(serialized, decode_strings=True)
        data = flatten(data)
    except KeyError as err:
        sys.exit(f"Url parsing error : {err}")

    return data


def make_scenario(data, financements, name="Donne-moi un nom"):
    header = f"Scénario: {name}\n    "
    steps = ["Soit un bénéficiaire et une formation"]

    for key, value in data.items():
        if key not in SCHEMA or key.startswith(("constante", "formation.numero")):
            continue
        schema = SCHEMA[key]
        label = schema["label"]
        enum = schema.get("enum")
        if enum and value is not None:
            if isinstance(value, (list, tuple, set)):
                value = [f"«{enum[v]}»" for v in value]
            elif value is not '':
                value = enum[value]
        if isinstance(value, str):
            value = f"«{value}»"
        if isinstance(value, datetime):
            value = f"«{value.strftime('%d/%m/%Y')}»"
        if value != 0 and not value:
            continue
        if key == "formation.regions_coparef":
            for val in value:
                regions = SCHEMA["beneficiaire.entreprise.region"]["enum"]
                if val not in regions:
                    # TODO: log anomalies in a file to share them with catalog
                    # producer?
                    print(f"Région inconnue (ancienne région?): {val}")
                    continue
                val = regions[val]
                steps.append(f"Et c'est une formation éligible région «{val}»")
                continue
        if isinstance(value, bool):
            # Et c'est un bénéficiaire de droit privé
            article = "un" if schema.get("gender") == "masculine" else "une"
            if value:
                steps.append(f"Et c'est {article} {label}")
            else:
                steps.append(f"Et ce n'est pas {article} {label}")
        else:
            if isinstance(value, (list, set)):
                value = "[" + ",".join(str(v) for v in value) + "]"
            article = "le " if schema.get("gender") == "masculine" else "la "
            if schema.get("number") == "plural":
                article = "les "
            elif unidecode(label[0].lower()) in "aeiouy":
                article = "l'"
            verb = "valent" if schema.get("number") == "plural" else "vaut"
            # Et le code CPF de la formation vaut 200
            steps.append(f"Et {article}{label} {verb} {value}")

    steps.append("Quand je demande un calcul de financement")
    for financement in financements:
        if financement.get("eligible"):
            # Quand je sélectionne le financement «CPF hors temps de travail»
            steps.append(
                f"Quand je sélectionne le financement " f"«{financement['intitule']}»"
            )
            keys = [
                "remuneration",
                "prise_en_charge",
                "plafond_prise_en_charge",
                "rff",
                "debut_rff",
                "fin_rff",
                "fin_remuneration",
            ]
            keyword = "Alors"
            for key in keys:
                if financement.get(key) is not None:
                    label = SCHEMA[f"financement.{key}"]["label"]
                    value = financement[key]
                    if isinstance(value, str):
                        value = f"«{value}»"
                    if isinstance(value, datetime):
                        value = f"«{value.strftime('%d/%m/%Y')}»"
                    steps.append(f"{keyword} la {label} vaut {value}")
                    keyword = "Et"
            if financement.get("organisme"):
                steps.append(
                    f"Et l'organisme à contacter est "
                    f"«{financement['organisme']['nom']}»"
                )
        else:
            steps.append(
                f"Alors le financement «{financement['intitule']}» " "n'est pas proposé"
            )
    return header + "\n    ".join(steps)


def load_scenarios():
    paths = (Path(__file__).parent / "config/features/").glob("*.feature")
    features = parse_features([str(p) for p in paths], language="fr")
    scenarios = []
    for feature in features:
        for scenario in feature.scenarios:
            scenarios.append(load_scenario(feature, scenario))
    return scenarios


def load_scenario(feature, scenario):
    scenario.tags.append(feature.name.lower())
    steps = [load_step(scenario, step) for step in scenario.steps]
    return {
        "name": scenario.name,
        "filename": scenario.filename,
        "line": scenario.line,
        "raw": "\n".join("{keyword} {name}".format(**step) for step in steps),
        "tags": set(scenario.tags),
    }


def load_step(scenario, step):
    scenario_tag_from_step(scenario, step)
    return {"keyword": step.keyword, "name": step.name}


def scenario_tag_from_step(scenario, step):
    if step.step_type == "given":
        if step.name == "c'est un bénéficiaire de droit privé":
            scenario.tags.append("salarié")
        elif step.name == "c'est un travailleur handicapé":
            scenario.tags.append("travailleur handicapé")
        elif step.name == "c'est un demandeur d'emploi":
            scenario.tags.append("de")
        prefixes = [
            "c'est une formation éligible région",
            "la région de l'établissement du bénéficiaire vaut",
            "la région du bénéficiaire vaut",
            "le type de contrat du bénéficiaire vaut",
        ]
        for prefix in prefixes:
            if step.name.startswith(prefix):
                scenario.tags.append(step.name[len(prefix) + 2 : -1].lower())
        prefix = "l'âge du bénéficiaire vaut"
        if step.name.startswith(prefix):
            age = int(step.name[len(prefix) + 1 :])
            if age < 26:
                scenario.tags.append("moins de 26")
            if age < 18:
                scenario.tags.append("moins de 18")
    elif step.step_type == "when":
        prefix = "je sélectionne le financement"
        if step.name.startswith(prefix):
            name = step.name[len(prefix) + 2 : -1]
            for financement in FINANCEMENTS:
                if financement["intitule"] == name:
                    scenario.tags.extend([t.lower() for t in financement["tags"]])


SCENARIOS = load_scenarios()
