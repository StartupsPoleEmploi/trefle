import asyncio
import re
from math import ceil

import requests
from unidecode import unidecode

from .exceptions import UpstreamError, DataError, NoDataError


DEP_TO_REG = {
    '01': '84', '02': '32', '03': '84', '04': '93', '05': '93', '06': '93',
    '07': '84', '08': '44', '09': '76', '10': '44', '11': '76', '12': '76',
    '13': '93', '14': '28', '15': '84', '16': '75', '17': '75', '18': '24',
    '19': '75', '21': '27', '22': '53', '23': '75', '24': '75', '25': '27',
    '26': '84', '27': '28', '28': '24', '29': '53', '2A': '94', '2B': '94',
    '30': '76', '31': '76', '32': '76', '33': '75', '34': '76', '35': '53',
    '36': '24', '37': '24', '38': '84', '39': '27', '40': '75', '41': '24',
    '42': '84', '43': '84', '44': '52', '45': '24', '46': '76', '47': '75',
    '48': '76', '49': '52', '50': '28', '51': '44', '52': '44', '53': '52',
    '54': '44', '55': '44', '56': '53', '57': '44', '58': '27', '59': '32',
    '60': '32', '61': '28', '62': '32', '63': '84', '64': '75', '65': '76',
    '66': '76', '67': '44', '68': '44', '69': '84', '70': '27', '71': '27',
    '72': '52', '73': '84', '74': '84', '75': '11', '76': '28', '77': '11',
    '78': '11', '79': '75', '80': '32', '81': '76', '82': '76', '83': '93',
    '84': '93', '85': '52', '86': '75', '87': '75', '88': '44', '89': '27',
    '90': '27', '91': '11', '92': '11', '93': '11', '94': '11', '95': '11',
    '971': '01', '972': '02', '973': '03', '974': '04', '976': '06',
    '20': '94',  # When consuming postcode.
}
NON_ALPHA = re.compile(r"[^0-9a-zA-Z]+")


def diff_month(start, end):
    return ((end.year - start.year) * 12
            + (end.month - start.month)
            + round((end.day - start.day) / 30))


def diff_week(start, end):
    # Ceil: we count a week even for a day
    # +1: the end bound is inclusive
    return ceil(((end - start).days + 1) / 7)


def flatten(data, output=None, namespace=None):
    """Turn {'a': {'b': 'value'}} in {'a.b': 'value'}."""
    if output is None:
        output = {}
    if namespace is None:
        namespace = []
    for key, more in data.items():
        ns = namespace.copy()
        ns.append(key)
        if isinstance(more, dict):
            flatten(more, output, ns)
            continue
        name = '.'.join(ns)
        output[name] = more
    data.clear()
    data.update(output)
    return data


async def http_get(url):
    loop = asyncio.get_event_loop()
    response = await loop.run_in_executor(None, requests.get, url)
    if response.status_code >= 500:
        raise UpstreamError(f"UPSTREAM_ERROR: {url} {response.status_code}")
    return response


def isfloat(v):
    try:
        float(v)
    except (ValueError, TypeError):
        return False
    return True


def count_indent(s):
    for i, c in enumerate(s):
        if c != ' ':
            return i
    return len(s)


def fold_name(s):
    return NON_ALPHA.sub('', unidecode(s).upper())


def insee_departement_to_region(context, from_key, to_key):
    if to_key in context:
        return
    try:
        dep = context[from_key]
    except (KeyError, NoDataError):
        return
    if dep not in DEP_TO_REG:
        raise DataError(f'Valeur invalide: `{context[from_key]}`', from_key)
    context[to_key] = DEP_TO_REG[dep]


def insee_commune_to_departement(context, from_key, to_key):
    if to_key in context:
        return
    try:
        commune = context[from_key]
    except (KeyError, NoDataError):
        return
    chars = 2
    if commune.startswith('97'):  # DROM
        chars = 3
    try:
        context[to_key] = commune[:chars]
    except DataError:
        # Invalid departement number, but target the commune key actually given
        raise DataError(f'Valeur invalide: `{context[from_key]}`', from_key)


def revert_dict(d):
    return {v: k for k, v in d.items()}
