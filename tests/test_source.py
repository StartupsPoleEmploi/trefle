import pytest

import datetime

from trefle.source import modification_data

DATA = {
        'title': 'test',
        'content': 'test',
        'comment': 'test',
        'filename': 'test.rules',
        'author_email': 'test@test.com',
        'author_name': 'test',
    }
# TODO: minutes can be different so fix minute to 00 (mock)
NOW = datetime.datetime.today().strftime("%y%m%d%H%M")


def test_modification_data_mail_error():
    data = DATA.copy()
    data["author_email"] = 'test'
    with pytest.raises(ValueError) as err:
        modification_data(data)
    assert "pas un mail valide" in str(err.value)


def test_modification_data_filename_error():
    data = DATA.copy()
    data["filename"] = 'test'
    with pytest.raises(ValueError) as err:
        modification_data(data)
    assert "pas un fichier de règle valide" in str(err.value)


def test_modification_data_title_empty():
    data = DATA.copy()
    data["title"] = ''
    with pytest.raises(ValueError) as err:
        modification_data(data)
    assert "est vide" in str(err.value)


def test_modification_data_title_not_provided():
    data = DATA.copy()
    del(data["title"])
    with pytest.raises(ValueError) as err:
        modification_data(data)
    assert "doit être renseigné" in str(err.value)


def test_modification_data():
    assert modification_data(DATA) == {
        "branch": f"RULE-modification-test-{NOW}",
        "start_branch": "master",
        "commit_message": 'test',
        "author_email": 'test@test.com',
        "author_name": 'test',
        "actions": [
            {
                "action": "update",
                "file_path": 'test.rules',
                "content": 'test',
            }
        ],
    }
