from setuptools import setup, find_packages
from pathlib import Path


def is_pkg(line):
    return line and not line.startswith(("--", "git", "#"))


with Path("requirements.txt").open() as reqs:
    install_requires = [l for l in reqs.read().split("\n") if is_pkg(l)]

VERSION = (0, 7, 13)

__author__ = "Yohan Boniface"
__contact__ = "yohan.boniface@data.gouv.fr"
__homepage__ = "https://framagit.org/ybon/trefle"
__version__ = ".".join(map(str, VERSION))

setup(
    name="trefle",
    version=__version__,
    description=__doc__,
    long_description=Path("README.md").read_text(),
    url=__homepage__,
    author=__author__,
    author_email=__contact__,
    license="MIT",
    # See https://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.6",
    ],
    packages=find_packages(exclude=["tests"]),
    install_requires=install_requires,
    extras_require={"test": ["pytest"], "docs": "mkdocs"},
    include_package_data=True,
    entry_points={"console_scripts": ["trefle=trefle.bin:main"]},
)
