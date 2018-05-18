import base64
import bz2
import os
import sys
import time
from urllib.parse import urlparse, parse_qs

from minicli import cli, run
import phpserialize
from roll.extensions import simple_server


from .api import app
from .config import VARIABLES
from .core import simulate
from .routine import populate_formation
from .validators import validate


@cli(name='simulate')
async def cli_simulate(*args, url=None, trace=False, feature=False):
    """Simulate a call to the API.

    Pass data as args in the form key=value.
    """
    data = {}
    if url:
        data.update(await data_from_lbf_url(url))
    if args:
        data.update(a.split('=') for a in args)
    start = time.perf_counter()
    financements = await simulate(**data)
    duration = (time.perf_counter() - start)
    print('*' * 80)
    print('Éligible')
    eligibles = [f for f in financements if f['eligible']]
    for financement in eligibles:
        if financement.get('eligible'):
            print('- Nom:', financement['nom'])
            print('  Description:', financement['description'][:150], '…')
            print('  Démarches:', financement['demarches'][:150], '…')
            print('  Organisme:')
            print('      Nom:', financement['organisme']['nom'])
            print('  Financement:', financement['prise_en_charge'], '€')
            print('  Rémunération:', financement['remuneration'], '€')
            print('')
    if not financements:
        print('Aucun financement éligible')
    if feature:
        if url:
            print(f'# {url}')
        make_feature(data, eligibles)
    print(f'Duration: {round(duration, 4)} second')


@cli
def serve():
    """Run a web server (for development only)."""
    simple_server(app)


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
        # b'salarie': '?',
        # b'situation_salarie': '?',
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
    validate(data)
    await populate_formation(data)
    return data


def make_feature(data, financements):
    print(f"""Scénario: pouac pouac
    Soit un bénéficiaire et une formation""")

    for key, value in data.items():
        schema = VARIABLES[key]
        label = schema['label']
        if 'enum' in schema:
            value = schema['enum'][value]
        if isinstance(value, str):
            value = f'«{value}»'
        if value != 0 and not value:
            continue
        if isinstance(value, (list, tuple, set)):
            value = '[' + ','.join(str(v) for v in value) + ']'
        if key == 'beneficiaire.entreprise.region':
            print(f"    Et c'est une formation éligible région {value}")
        elif isinstance(value, bool):
            # Et c'est un bénéficiaire de droit privé
            article = 'un' if schema.get('gender') == 'masculine' else 'une'
            if value:
                print(f"    Et c'est {article} {label}")
            else:
                print(f"    Et ce n'est pas {article} {label}")
        else:
            article = 'le ' if schema.get('gender') == 'masculine' else 'la '
            if schema.get('number') == 'plural':
                article = 'les '
            elif label[0].lower() in 'aeiouy':
                article = "l'"
            # Et le code CPF de la formation vaut 200
            print(f"    Et {article}{label} vaut {value}")

    print("    Quand je demande un calcul de financement")
    for financement in financements:
        # Quand je sélectionne le financement «CPF hors temps de travail»
        print(f"    Quand je sélectionne le financement «{financement['nom']}»")
        # Alors l'organisme tutelle est «INTERGROS»
        print(f"    Alors l'organisme tutelle est «{financement['organisme']['nom']}»")
        # Et le montant de prise en charge vaut 2000
        print(f"    Et le montant de prise en charge vaut {financement['prise_en_charge']}")
        print(f"    Et la rémunération vaut {financement['remuneration']}")


def main():
    run()


if __name__ == '__main__':
    main()
