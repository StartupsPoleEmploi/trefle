# Trefle

## Install

- Create a venv
- Then: `python setup.py develop`

## Run a simulation

    trefle simulate var=value var2=value2…

## Run the dev server

    trefle serve

## Run unittests

    py.test

## Run integration tests

    behave --lang fr

Get a detailed coverage report:

    behave --lang fr -D coverage-format=short

Get a more detailed coverage report:

    behave --lang fr -D coverage-format=long

Only check one rules step coverage:

    behave --lang fr -D coverage=eligibilite
    behave --lang fr -D coverage=remuneration
    behave --lang fr -D coverage=prise_en_charge
