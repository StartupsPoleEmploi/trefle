# Trefle

## Install

- Create a venv
- Then: `python setup.py develop`

## Run a simulation

    trefle simulate var=value var2=value2…
    # Or from an LBF URL
    trefle simulate --url=https://xxx?a=yyy
    # Or from JSON (like a request body from the logs)
    trefle simulate --context='{"xxx": "yyyy"}'
    # You can output a Gherkin scenario from this simulation
    trefle simulate var=value var2=value2… --output-scenario
    # Get details about the data (including retrieved data from catalog)
    trefle simulate var=value var2=value2… --show-context
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
