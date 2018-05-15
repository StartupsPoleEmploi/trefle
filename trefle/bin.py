import base64
import bz2
import time
from urllib.parse import urlparse, parse_qs

from minicli import cli, run
import phpserialize
from roll.extensions import simple_server

from .core import simulate
from .api import app
from .validators import validate


@cli(name='simulate')
async def cli_simulate(*args):
    data = dict(a.split('=') for a in args)
    start = time.perf_counter()
    financements = await simulate(**data)
    duration = (time.perf_counter() - start)
    print('*' * 80)
    print('Éligible')
    for financement in financements:
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
    print(f'Duration: {round(duration, 4)} second')


@cli
def serve():
    simple_server(app)


@cli
async def decrypt_lbf_url(url):
    charmap = {
        # TODO fill me up with private charmap encryption values
    }

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
    }

    print(args)
    data = {keymap[key]: value.decode() for key, value in args.items() if key in keymap}
    # print(args)
    validate(data)

    financements = [f for f in await simulate(**data) if f['eligible']]

    print(f"""# {url}
Scénario: pouac pouac
    Soit un bénéficiaire et une formation""")

    from .config import VARIABLES

    for key, value in data.items():
        label = VARIABLES[key]['label']
        if isinstance(value, bool):
            # Et c'est un bénéficiaire de droit privé
            if value:
                print(f"    Et c'est un {label}")
            else:
                print(f"    Et ce n'est pas un {label}")
        else:
            # Et c'est une formation éligible COPANEF
            # Et le solde CPF du bénéficiaire vaut 100
            # Et l'IDCC de l'établissement du bénéficiaire vaut 2075
            # Et la rémunération du bénéficiaire vaut 1400
            # Et le type de contrat du bénéficiaire vaut CDI
            # Et le taux horaire de la formation vaut 25
            # Et la durée en heures de la formation vaut 200
            # Et le code CPF de la formation vaut 200
            print(f"    Et le {label} vaut {value}")

    print("    Quand je demande un calcul de financement")
    # Et je sélectionne le financement «CPF sur son temps de travail»
    # Alors l'organisme tutelle est «INTERGROS»
    # Et le montant de prise en charge vaut 2000
    # Et la rémunération vaut 1400
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
