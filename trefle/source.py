import datetime
import re

import gitlab

from .config import COMMIT_AUTHORIZED, GITLAB_PROJECT, GITLAB_TOKEN, GITLAB_URL
from .exceptions import NotModifiedError, UnauthorizedAccess
from .helpers import fold_name


async def load_project():
    gl = gitlab.Gitlab(GITLAB_URL, private_token=GITLAB_TOKEN)
    project = gl.projects.get(GITLAB_PROJECT, lazy=True)
    return project


async def source_modified(project, data):
    filename = data['actions'][0]['file_path']
    content = data['actions'][0]['content']
    original_fingerprint = hash(project.files.get(filename,
                                                  ref='master').decode().decode())
    modified_fingerprint = hash(content)
    return original_fingerprint != modified_fingerprint


async def submit_modification(data):
    project = await load_project()
    mr_title = data.get('title')
    data = modification_data(data)

    if not await source_modified(project, data):
        raise NotModifiedError(f"Content not modified in rule {data.get('branch')}")
    elif data.get("author_email") not in COMMIT_AUTHORIZED:
        raise UnauthorizedAccess(
            f"Your emai is not authorized to modify the rule {data.get('branch')}"
        )
    else:
        commit = await create_commit(project, data)
        mr = await create_mr(project, data.get("branch"), mr_title)
        commit["merge_request"] = mr
        return commit


async def create_commit(project, data):
    try:
        commit = project.commits.create(data)
        return commit.attributes
    except Exception as err:
        print(f"Source code commit failed on rule {data.get('branch')}: {err!r}")


async def create_mr(project, source_branch, title):
    try:
        mr = project.mergerequests.create({'source_branch': source_branch,
           'target_branch': 'master',
           'title': title,
           'labels': ['RULE']})
        return mr.attributes
    except Exception as err:
        print(f"Merge request creation failed on rule {source_branch}: {err!r}")


def validate(func):
    def wrapper(data):
        required_keys = [
            "title",
            "content",
            "comment",
            "filename",
            "author_email",
            "author_name",
        ]
        for d in data.items():
            if not d[1]:
                raise ValueError(f"`{d[0]}` est vide")
        for r in required_keys:
            if r not in data.keys():
                raise ValueError(f"`{r}` doit être renseigné")
        if not re.match(
            r"^[A-Za-z0-9\.\+_-]+@[A-Za-z0-9\._-]+\.[a-zA-Z]*$",
            data.get("author_email"),
        ):
            raise ValueError(f"`{data.get('author_email')}` n'est pas un mail valide")
        elif not re.match(r"^.*\.rules$", data.get("filename")):
            raise ValueError(
                f"`{data.get('filename')}` n'est pas un fichier de règle valide"
            )
        return func(data)

    return wrapper


@validate
def modification_data(data):
    now = datetime.datetime.today().strftime("%y%m%d%H%M")
    branch = f"modification-{fold_name(data.get('title')).lower()}"
    return {
        "branch": f"RULE-{branch}-{now}",
        "start_branch": "master",
        "commit_message": data.get("comment"),
        "author_email": data.get("author_email"),
        "author_name": data.get("author_name"),
        "actions": [
            {
                "action": "update",
                "file_path": data.get("filename"),
                "content": data.get("content"),
            }
        ],
    }
