import csv
import json
import os
import re
import sys
from collections import defaultdict
from pathlib import Path

import yaml

from ..exceptions import NoStepError, ParsingError, WrongPointerError
from ..helpers import fold_name
from ..rules import Rule, SCHEMA, LABELS, RULES, IDCC


CONSTANTS = {}
FINANCEMENTS = []
REMUNERATIONS = []
ORGANISMES = {}
ROOT = Path(__file__).parent
RAW_RULES = {}
GLOSSARY = {}
NAF = {}
CERTIFINFO = {}
FEATURES = {}

CATALOG_USER = os.environ.get("CATALOG_USER", "tata")
CATALOG_KEY = os.environ.get("CATALOG_KEY", "toto")
CATALOG_URL = os.environ.get(
    "CATALOG_URL", "https://labonneformation.beta.pole-emploi.fr/api/v1/detail"
)
GITLAB_URL = os.environ.get("GITLAB_URL", "https://git.beta.pole-emploi.fr")
GITLAB_PROJECT = os.environ.get("GITLAB_PROJECT", "open-source/trefle")
GITLAB_TOKEN = os.environ.get("GITLAB_TOKEN", "need-private-access-token")
COMMIT_AUTHORIZED = []
AUTHORIZED = []


def load_schema(data, output=None, namespace=None):
    if output is None:
        output = {}
    if namespace is None:
        namespace = []
    for key, more in data.items():
        ns = namespace.copy()
        ns.append(key)
        if "type" in more:  # We have a variable.
            name = ".".join(ns)
            output[name] = more
            if ns[0] == "constante":
                CONSTANTS[name] = more["value"]
            if "label" in more:
                LABELS[more["label"]] = name
            enum = more.get("enum") or more.get("items", {}).get("enum")
            if enum:
                more["enum"] = enum  # Always store it at the schema root.
                more["labels"] = {}
                for key, label in enum.items():
                    more["labels"][label] = key
            if "pattern" in more:
                more["pattern"] = re.compile(more["pattern"])
            if "alias" in more and not isinstance(more["alias"], list):
                more["alias"] = [more["alias"]]
        else:
            load_schema(more, output, ns)
    return output


def load_financements():
    with (ROOT / "financements.yml").open() as f:
        data = yaml.safe_load(f.read())
    for id_, props in data.items():
        props.setdefault("intitule", id_)
        props["eligible"] = False
        FINANCEMENTS.append(props)


def load_remunerations():
    with (ROOT / "remunerations.yml").open() as f:
        data = yaml.safe_load(f.read())
    for id_, props in data.items():
        props.setdefault("intitule", id_)
        REMUNERATIONS.append(props)


def load_naf(data):
    # Data from https://www.insee.fr/fr/information/2406147
    from ..validators import format_naf

    out = {}
    reader = csv.DictReader(data.split("\n"), delimiter=";")
    for line in reader:
        if not line or len(line["code"]) != 6:
            continue
        code = format_naf(line["code"])
        name = line["name"]
        out[code] = {'code': code, 'name': name}
    return out


def load_authorisations(data):
    out = []
    reader = csv.DictReader(data.split("\n"), delimiter=",", skipinitialspace=True)
    for line in reader:
        email = line["email"]
        password = line["password"]
        _file = line["file"]
        out.append({'email': email, 'password': password, 'file': _file})
    return out


def load_rules(path):
    with path.open() as rules_file:
        datas = rules_file.read().split('---\n', 1)
        data = datas[0]
        comment = datas[1] if len(datas) == 2 else ''
        # Don't use local path in rule id, so we can call it from a Pointer
        # value.
        id_ = path.name
        if path.name in RAW_RULES:
            raise ValueError(f"Rule {path.name} already exists!")
        RAW_RULES[id_] = {
            "data": data,
            "path": str(path.relative_to(ROOT / "rules")),
            "name": path.stem,
            "comment": comment,
        }
        try:
            return id_, Rule.load(data.splitlines(), id_)
        except (NoStepError, ParsingError, WrongPointerError) as err:
            sys.exit(f"Project loading failed: {err!r}")
        except Exception as err:
            print(f"Project loading failed on rule {path}: {err!r}")
            raise


def load_dir_rules(root):
    paths = (root).glob("**/*.rules")
    for path in sorted(paths, key=lambda p: fold_name(str(p))):
        yield load_rules(path)


def load_features():
    paths = (ROOT / "features").glob("*.feature")
    for path in sorted(paths, key=lambda p: p.name.lower()):
        raw = path.read_text()
        id_ = str(path.relative_to(ROOT))
        FEATURES[id_] = {"raw": raw, "path": id_, "name": path.stem}


class SmartDict(dict):
    def __getattr__(self, key):
        return self.get(key)

    def __setattr__(self, key, value):
        self[key] = value


class Financement(SmartDict):
    def format(self):
        """Allow to use financement properties as vars in text values."""
        for key in [
            "demarches",
            "description",
            "en_savoir_plus",
            "remuneration_texte",
            "prise_en_charge_texte",
        ]:
            setattr(self, key, (getattr(self, key) or "").format(**self))


class Organisme(SmartDict):
    ...


class Remuneration(SmartDict):
    ...


def init():
    print("Initializing config")
    with (ROOT / "schema.yml").open() as f:
        SCHEMA.update(load_schema(yaml.safe_load(f.read())))
    for id_, rules in load_dir_rules(ROOT / "rules"):
        RULES[id_] = rules
    load_financements()
    load_remunerations()
    with (ROOT / "organismes.yml").open() as f:
        for name, data in yaml.safe_load(f.read()).items():
            organisme = data
            data["nom"] = name
            ORGANISMES[name] = organisme
            # Also add a folded key, for user input sourced name.
            ORGANISMES[fold_name(name)] = organisme
    with (ROOT / "idcc.yml").open() as f:
        IDCC.update(yaml.safe_load(f.read()))
    with (ROOT / "glossaire.yml").open() as f:
        GLOSSARY.update(yaml.safe_load(f.read()))
    with (ROOT / "naf.csv").open() as f:
        NAF.update(load_naf(f.read()))
    with (ROOT / "certifinfo.json").open() as f:
        CERTIFINFO.update(json.loads(f.read()))
    with (ROOT / "authorisations.csv").open('a+') as f:
        f.seek(0)
        AUTHORIZED.extend(load_authorisations(f.read()))
    for auth in AUTHORIZED:
        COMMIT_AUTHORIZED.append(auth.get('email', ''))

    load_features()
    print("Done initializing config")
