import pytest

from trefle.source import modification_data

DATA = {
        'title': 'test',
        'content': 'test',
        'comment': 'test',
        'filename': 'test.rules',
        'author_email': 'test@test.com',
        'author_name': 'test',
    }


def test_modification_data_mail_error():
    data = DATA.copy()
    data["author_email"] = 'test'
    with pytest.raises(ValueError) as err:
        modification_data(data)
    assert "pas un mail valide" in str(err.value)


# TODO: mok gitlab api
# def test_modification_with_last_commit_id():
#     data = DATA.copy()
#     data["last_commit_id"] = 'test'
#     with pytest.raises(ValueError) as err:
#         modification_data(data)
#     assert "pas un identifiant de commit valide" in str(err.value)


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


def test_modification_data_with_new_branch_is_valid():
    assert modification_data(DATA) == {
        "branch": f"RULE-modification-test",
        "start_branch": "master",
        "commit_message": 'test',
        "author_email": 'test@test.com',
        "author_name": 'test',
        "file_path": "test.rules",
        "content": "test",
    }


def test_modification_data_with_existing_branch_is_valid():
    data = DATA.copy()
    data["last_commit_id"] = "7cfa6c27"
    assert modification_data(data) == {
        "branch": f"RULE-modification-test",
        "commit_message": 'test',
        "author_email": 'test@test.com',
        "author_name": 'test',
        "file_path": "test.rules",
        "content": "test",
        "last_commit_id": "7cfa6c27"
    }
