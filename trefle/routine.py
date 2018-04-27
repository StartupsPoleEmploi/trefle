from pathlib import Path

from lxml import etree
import requests
import yaml

from .config import (CONSTANTS, ELIGIBILITE, FINANCEMENTS, PRISE_EN_CHARGE,
                     REMUNERATION)
from .exceptions import NoDataError
from .rules import Rule

with (Path(__file__).parent / 'config/idcc.yml').open() as f:
    IDCC = yaml.safe_load(f.read())

INTERCARIF_URL = 'https://labonneformation.pole-emploi.fr/ws_intercarif'


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


def add_constants(data):
    data.update(CONSTANTS)


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


def check_eligibilite(data):
    data['financements.non_eligibles'] = []
    data['financements.eligibles'] = []
    failed = []
    Rule.process(ELIGIBILITE, data, failed)
    for rule in failed:
        for action in rule.actions:
            data['financements.non_eligibles'].append(
                Financement(action.value.get()))


def compute_prise_en_charge(data):
    Rule.process(PRISE_EN_CHARGE, data)
    heures = data['beneficiaire.solde_cpf']
    if ('financement.plafond_horaire' in data
       and int(data['financement.plafond_horaire']) < heures):
        heures = int(data['financement.plafond_horaire'])
    prise_en_charge = int(data['financement.taux_horaire']) * heures
    if ('financement.plafond_financier' in data
       and int(data['financement.plafond_financier']) < prise_en_charge):
        prise_en_charge = int(data['financement.plafond_financier'])
    data['financement.prise_en_charge'] = prise_en_charge


def compute_remuneration(data):
    Rule.process(REMUNERATION, data)


def check_financements(data):
    for idx, name in enumerate(data['financements.eligibles']):
        financement = Financement(name)
        financement(**data)
        data['financements.eligibles'][idx] = financement


def populate_formation(data):
    if not data.get('formation.numero'):
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


def financement_to_organisme(data):
    type_ = data['financement.genre']
    if type_ == 'CPF':
        data['financement.organisme.nom'] = data['beneficiaire.entreprise.opca']  # noqa
    elif type_ == 'CIF':
        data['financement.organisme.nom'] = data['beneficiaire.entreprise.opacif']  # noqa
    else:
        raise NotImplementedError(f'Unknown financement type {type_}')


class Financement:

    def __init__(self, nom):
        self.nom = nom
        self.organisme = None
        self.prise_en_charge = None
        self.remuneration = None
        self.description = None
        self.demarches = None

    def __repr__(self):
        return f'<Financement: {self.nom}'

    def __call__(self, **data):
        # TODO only use financement.genre/type in rules.
        properties = FINANCEMENTS[self.nom]
        for key, value in properties.items():
            setattr(self, key, value)
            data[f'financement.{key}'] = value
        financement_to_organisme(data)
        self.organisme = data['financement.organisme.nom']
        compute_prise_en_charge(data)
        self.prise_en_charge = data['financement.prise_en_charge']
        compute_remuneration(data)
        self.remuneration = int(data.get('financement.remuneration', 0))
