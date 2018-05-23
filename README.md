# Trefle

## Install

- Create a venv
- Then: `python setup.py develop`

## Run a simulation

    trefle simulate var=value var2=value2…
    # Or from an LBF URL
    trefle simulate --url=https://xxx?a=yyy
    # You can output a Gherkin test case from this simulation
    trefle simulate var=value var2=value2… --feature
    # Get details about the data (including retrieved data from catalog)
    trefle simulate var=value var2=value2… --show-data
    # Trace the rules to see which condition passed or failed
    trefle simulate var=value var2=value2… --trace

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
    behave --lang fr -D coverage=modalites
