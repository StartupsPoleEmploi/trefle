from pathlib import Path

from lxml import etree
import requests
import yaml

from .exceptions import NoDataError
from .rules import Rule, Financement, VARIABLES

with (Path(__file__).parent / 'config/idcc.yml').open() as f:
    IDCC = yaml.safe_load(f.read())

INTERCARIF_URL = 'https://labonneformation.pole-emploi.fr/ws_intercarif'


def validate_data(data):
    for key, value in data.items():
        if key not in VARIABLES:
            raise ValueError(f'Unknown key {key}')
        type_ = VARIABLES[key]['type']
        if type_ == 'boolean':
            data[key] = bool(value)
        elif type_ == 'integer':
            data[key] = int(value)
        elif type_ == 'number':
            data[key] = float(value)


def idcc_to_organismes(data):
    key = 'beneficiaire.entreprise.idcc'
    if key not in data:
        raise NoDataError('Missing idcc in data')
    try:
        idcc = int(data[key])
    except (ValueError, TypeError):
        raise ValueError(f'Invalid IDCC value {idcc}')
    if idcc not in IDCC:
        raise ValueError(f'Unknown IDCC {idcc}')
    data['beneficiaire.entreprise.opca'] = IDCC[idcc]['OPCA']
    data['beneficiaire.entreprise.opacif'] = IDCC[idcc]['OPACIF']


def check_eligibilite(data, rules):
    data['financements.non_eligibles'] = []
    data['financements.eligibles'] = []
    Rule.process(rules, data, data['financements.non_eligibles'])


def check_financements(data):
    for idx, name in enumerate(data['financements.eligibles']):
        financement = Financement(name)
        financement(**data)
        data['financements.eligibles'][idx] = financement


def populate_formation(data):
    if 'formation.numero' not in data:
        return

    formation_id = data['formation.numero']
    response = requests.get(f'{INTERCARIF_URL}?num={formation_id}')
    # TODO handle 400/500 responses
    populate_formation_from_bytes(data, response.content)


def populate_formation_from_bytes(data, content):
    content = content.replace(b' xmlns="http://www.lheo.org/2.2"', b'')
    tree = etree.fromstring(content)
    root = tree.find('offres/formation')

    data['formation.eligible_copanef'] = bool(root.xpath(
        '//extras[@info="eligibilite-cpf"]/extra[@info="france-entiere"][text()="1"]/../extra[@info="inter-branche"][text()="1"]'
    ))
    data['formation.codes_naf'] = set(root.xpath('//extras[@info="eligibilite-cpf"]/extra[@info="branche"]/child::text()'))
    data['formation.regions'] = set(root.xpath('//extras[@info="eligibilite-cpf"]/extra[@info="region"]/child::text()'))
