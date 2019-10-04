import os

from pydriller import RepositoryMining


async def last_modified(rulepath):
    repo = "https://framagit.org/ybon/trefle.git"
    commits = RepositoryMining(
        repo, filepath=rulepath, reversed_order=True
    ).traverse_commits()
    return next(commits).committer_date.date().isoformat()
