from trefle.config import Financement, Organisme, load_naf, load_schema


def test_load_schema():
    data = {
        "beneficiaire": {
            "cpf": {"type": "bool", "description": "blah"},
            "age": {"type": "int", "description": "bleh"},
            "entreprise": {"ace": {"type": "str", "description": "booh"}},
        }
    }
    assert load_schema(data) == {
        "beneficiaire.cpf": {"type": "bool", "description": "blah"},
        "beneficiaire.age": {"type": "int", "description": "bleh"},
        "beneficiaire.entreprise.ace": {"type": "str", "description": "booh"},
    }


def test_load_naf():
    data = """code;name
SECTION A;AGRICULTURE, SYLVICULTURE ET PÊCHE
1;Culture et production animale, chasse et services annexes
1.1;Cultures non permanentes
1.11;Culture de céréales (à l'exception du riz), de légumineuses et de graines oléagineuses
01.11Z;Culture de céréales (à l'exception du riz), de légumineuses et de graines oléagineuses
1.12;Culture du riz
01.12Z;Culture du riz
1.13;Culture de légumes, de melons, de racines et de tubercules
01.13Z;Culture de légumes, de melons, de racines et de tubercules
1.14;Culture de la canne à sucre
01.14Z;Culture de la canne à sucre"""
    assert load_naf(data) == {
        "0111Z": {"code":"0111Z", "name": "Culture de céréales (à l'exception du riz), de légumineuses et de graines oléagineuses"},
        "0112Z": {"code":"0112Z", "name": "Culture du riz"},
        "0113Z": {"code":"0113Z", "name": "Culture de légumes, de melons, de racines et de tubercules"},
        "0114Z": {"code":"0114Z", "name": "Culture de la canne à sucre"},
    }


def test_financement_format():

    financement = Financement(
        remuneration=2000, remuneration_texte="Rémunération de {remuneration} euros"
    )
    financement.format()
    assert financement.remuneration_texte == "Rémunération de 2000 euros"


def test_financement_format_nested():

    financement = Financement(
        organisme=Organisme(nom="Foo"),
        remuneration_texte="Renseignez-vous auprès de {organisme.nom}",
    )
    financement.format()
    assert financement.remuneration_texte == "Renseignez-vous auprès de Foo"
