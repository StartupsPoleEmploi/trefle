import base64
import bz2
import os
import sys
from urllib.parse import parse_qs, urlparse

import phpserialize

from .config import LABELS, SCHEMA
from .exceptions import NoDataError
from .routine import populate_formation
from .validators import validate


def yellow(s):
    return f'\x1b[1;33m{s}\x1b[0m'


def green(s):
    return f'\x1b[1;32m{s}\x1b[0m'


def red(s):
    return f'\x1b[1;31m{s}\x1b[0m'


def trace_condition(condition):
    assess_orig = condition.assess

    def assess_wrapper(**data):
        status = assess_orig(**data)
        condition._return_values.append(status)

        params = {}
        for param in condition.params.values():
            if param.raw not in LABELS:
                # Do not redisplay raw static values
                continue
            try:
                value = param.get(**data)
            except NoDataError:  # No data were provided for this value.
                value = None
            params[param.raw] = value
        condition._called_with.append(params)
        return status

    condition.assess = assess_wrapper
    condition._return_values = []
    condition._called_with = []
    for sub in condition.conditions:
        trace_condition(sub)


def trace_rule(rule):
    for condition in rule.conditions:
        trace_condition(condition)


async def data_from_lbf_url(url):
    charmap = os.environ.get('LBF_CHARMAP')
    if not charmap:
        sys.exit("You need the LBF_CHARMAP env var to be set. It's on the "
                 "form ab,cd…")
    charmap = {from_: to for from_, to in charmap.split(',')}

    encrypted = parse_qs(urlparse(url).query)['a'][0]
    encrypted = "".join(charmap[char] for char in encrypted[8:])
    serialized = base64.b64decode(encrypted)
    serialized = bz2.decompress(serialized)
    args = phpserialize.loads(serialized)

    keymap = {
        # TODO deal with age
        # b'birthdate': b'20/10/1978',
        b'droitprive': 'beneficiaire.droit_prive',
        b'salaire': 'beneficiaire.remuneration',
        b'situation_creditheurescpf': 'beneficiaire.solde_cpf',
        b'contrat': 'beneficiaire.contrat',
        b'experience': 'beneficiaire.experience_professionnelle',
        b'moistravailleencdd': 'beneficiaire.mois_travailles_en_cdd',
        b'ancienneteentrepriseactuelle': 'beneficiaire.anciennete_entreprise_actuelle',
        b'naf': 'beneficiaire.entreprise.naf',
        b'idcc': 'beneficiaire.entreprise.idcc',
        b'region': 'beneficiaire.entreprise.region',
        b'commune': 'beneficiaire.entreprise.commune',
        b'idformintercarif': 'formation.numero',
    }

    data = {keymap[key]: value.decode() for key, value in args.items()
            if key in keymap}
    try:
        validate(data)
    except Exception as err:
        print('Error validating data.')
        print(data)
        sys.exit(err)
    await populate_formation(data)
    del data['formation.numero']
    return data


def make_feature(data, financements, name='Donne-moi un nom'):
    header = f"Scénario: {name}\n    "
    steps = ["Soit un bénéficiaire et une formation"]

    for key, value in data.items():
        schema = SCHEMA[key]
        label = schema['label']
        if 'enum' in schema:
            value = schema['enum'][value]
        if isinstance(value, str):
            value = f'«{value}»'
        if value != 0 and not value:
            continue
        if key == 'formation.regions_coparef':
            for val in value:
                regions = SCHEMA['beneficiaire.entreprise.region']['enum']
                val = regions[val]
                steps.append(f"Et c'est une formation éligible région «{val}»")
                continue
        if isinstance(value, (list, tuple, set)):
            value = '[' + ','.join(str(v) for v in value) + ']'
        elif isinstance(value, bool):
            # Et c'est un bénéficiaire de droit privé
            article = 'un' if schema.get('gender') == 'masculine' else 'une'
            if value:
                steps.append(f"Et c'est {article} {label}")
            else:
                steps.append(f"Et ce n'est pas {article} {label}")
        else:
            article = 'le ' if schema.get('gender') == 'masculine' else 'la '
            if schema.get('number') == 'plural':
                article = 'les '
            elif label[0].lower() in 'aeiouy':
                article = "l'"
            # Et le code CPF de la formation vaut 200
            steps.append(f"Et {article}{label} vaut {value}")

    steps.append("Quand je demande un calcul de financement")
    for financement in financements:
        # Quand je sélectionne le financement «CPF hors temps de travail»
        steps.append(f"Quand je sélectionne le financement "
                     f"«{financement['nom']}»")
        # Alors l'organisme tutelle est «INTERGROS»
        steps.append(f"Alors l'organisme tutelle est "
                     f"«{financement['organisme']['nom']}»")
        # Et le montant de prise en charge vaut 2000
        steps.append(f"Et le montant de prise en charge vaut "
                     f"{financement['prise_en_charge']}")
        steps.append(f"Et la rémunération vaut {financement['remuneration']}")
    return header + '\n    '.join(steps)
