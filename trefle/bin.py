import time
import sys
from copy import deepcopy
from pathlib import Path

import hupper
import requests
import ujson as json
from minicli import cli, run
from roll.extensions import simple_server, static, traceback

from trefle import simulate, simulate_remuneration, get_financements, get_remunerations
from trefle.api import app
from trefle.debugging import data_from_lbf_url, green, make_scenario, red
from trefle.exceptions import DataError
from trefle.helpers import flatten
from trefle.rules import SCHEMA, Pointer


def parse_args(args):
    data = {}
    for arg in args:
        key, value = arg.split("=")
        pointer = Pointer(value)
        pointer.resolve_labels(key)
        data[key] = pointer.get({})
    return data


def colorize(s, status, prefix="✓✗"):
    func = red
    char = f"{prefix[1]} " if prefix else ""
    if status is True:
        func = green
        char = f"{prefix[0]} " if prefix else ""
    return func(f"{char}{s}")


def render_status(status):
    if status.terms:
        return (
            "["
            + f" {status.condition.connective} ".join(
                render_status(t) for t in status.terms
            )
            + "]"
        )
    return colorize(status.condition, status.status, prefix=None)


def render_statuses(status, level=0):
    line = render_status(status)
    prefix = colorize("  " * level, status.status)
    print(f"    {prefix} {line}")
    for child in status.children:
        render_statuses(child, level=level + 1)


@cli(name="simulate")
async def cli_simulate(
    *args,
    context: json.loads = {},
    url=None,
    trace=False,
    output_scenario=False,
    show_context=False,
    type=None,
    tags=[],
    show_non_eligible=False,
):
    """Simulate a call to the API.

    Pass context as args in the form key=value.
    :context: context in json form (for example from a request body).
    :url: Optionnal LBF URL to retrieve context from.
    :trace: Display a trace of all checked conditions.
    :output_scenario: Render a Gherkin scenario with given context.
    :show_context: Render a table with used context.
    :type: Choose simulatio type, 'financement' (default) or 'remuneration'
    :tags: Only return financements matching tags.
    """
    if "context" in context:
        context = context["context"]  # Copy-paste from our logs.
    flatten(context)
    if url:
        context = data_from_lbf_url(url)
    if args:
        context.update(parse_args(args))
    try:
        start = time.perf_counter()
        if type == 'financement':
            facilities = get_financements(tags=tags)
            await simulate(context, facilities)
        elif type == 'remuneration':
            facilities = get_remunerations(tags=tags)
            await simulate_remuneration(context, facilities)
        duration = time.perf_counter() - start
    except DataError as err:
        sys.exit(f"Error in data: {err}")
    except Exception:
        raise
    finally:
        if show_context:
            print("-" * 105)
            tpl = "| {:<50}| {:<50}|"
            print(tpl.format("key", "value"))
            print("| {0}| {0}|".format("-" * 50))
            for key, value in context.items():
                if key.startswith(("constante", type + "s")):
                    continue
                print(tpl.format(key, str(value)))
            print("-" * 105)
    print("*" * 105)
    eligibles = [f for f in facilities if f.eligible]
    if eligibles:
        print(type + "s éligibles\n")
    else:
        print(f"Aucun {type} éligible")

    for facility in eligibles:
        print(facility.intitule)
        for key, value in facility.items():
            if not value or key in (
                "intitule",
                "organisme",
                "explain",
                "tags",
                "eligible",
                "ressources",
                "racine",
            ):
                continue
            schema = SCHEMA[f"{type}." + key]
            if isinstance(value, str) and len(value) > 100:
                value = f"{value[:100]}…"
            print(f'  {schema["label"]}: {value}')
        if facility.organisme:
            print("  organisme:", facility.organisme.nom)
        if trace:
            for status in facility.explain:
                render_statuses(status)
        print("-" * 80)
    non_eligibles = [f for f in facilities if not f.eligible]
    if non_eligibles and (show_non_eligible or trace):
        print(f"\n{type}s non éligibles\n")
        for facility in non_eligibles:
            print("-", facility.intitule)
            if trace:
                for status in facility.explain:
                    render_statuses(status)
    if output_scenario:
        if url:
            print(f"# {url}")
        print(make_scenario(context, eligibles + non_eligibles))
    print(f"Duration: {round(duration, 4)} second")


def render_trace_condition(condition):
    if condition.terms:
        for term in condition.terms:
            render_trace_condition(term)
    else:
        calls = []
        indent = condition.level * 4
        for call in zip(condition._return_values, condition._called_with):
            if call not in calls:
                calls.append(call)
        print(" " * indent, condition)
        for return_value, params in calls:
            func = red
            char = "✗"
            if return_value is True:
                func = green
                char = "✓"
            print(" " * indent, func(f"  {char} {params}"))
    for child in condition.children:
        render_trace_condition(child)


@cli
def serve(reload=False):
    """Run a web server (for development only)."""
    # Debug only.
    static(app, "/explorer/", Path(__file__).parent / "explorer")
    if reload:
        hupper.start_reloader("trefle.bin.serve")
    traceback(app)
    simple_server(app)


@cli
def test_config():
    """Just load the config."""
    print("Project loaded successfully!")


@cli
async def populate_legacy(path: Path):
    data = json.loads(path.read_text())
    dest = path.parent / "legacy"
    for idx, body in enumerate(data):
        time.sleep(0.5)
        resp = requests.post(
            "http://labonneformation.pole-emploi.local/api/v1/financement?user=NOCONTROL",
            json=body,
            verify=False,
        )
        if not resp.ok:
            print(resp.status_code, resp.text)
            if resp.status_code != 404:
                break
            continue
        output = resp.json()
        output["financements"] = sorted(
            output["financements"],
            key=lambda f: float(f["donneeStructurees"]["priorite"]),
        )
        context = deepcopy(body)
        context["individu"]["departementHabitation"] = context["individu"][
            "departementHabitation"
        ].upper()
        try:
            await simulate(context, get_financements())
        except DataError as err:
            print(f"{err}")
            continue
        for key, value in context.items():
            if key.startswith("formation."):
                body[key] = value
        id = body["formationVisee"]["codeFormation"]
        del body["formationVisee"]
        del body["formation.numero"]
        with dest.joinpath(f"case_{idx+1}.json").open("w") as f:
            f.write(json.dumps({"_id": id, "in": body, "out": output}))


def main():
    run()


if __name__ == "__main__":
    main()
