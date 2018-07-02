import asyncio
from math import ceil

import requests

from .exceptions import UpstreamError


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
