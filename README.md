# Trefle

## Présentation du projet

  Trèfle est un simulateur de dispositifs de financement qui, en fonction des données du demandeur et de la formation, va générer une liste de financements possibles.
  Cette liste de financements proposés est accompagnée, selon le dispositif, de la rémunération dont pourrait bénéficier le demandeur. Les résultats sont donnés à titre informatif et nécessitent l'accompagnement d'un conseiller pour la suite des démarches.

## Project overview

  Trèfle is a simulator tool aim to propose a list of financial plans depending on buyer situation employment data and training courses data itself. A renumeration can be proposed with the formation plan. Results are given as information only and must be accompanied by an adviser to engage the process of any plan.

## Dependencies

- LBF Url to simulation on the web interface explorer
- LBF Catalog API key to retrieve training courses data

## Install

- Create a venv : `python3 -m venv trefle`
- Then: `make develop`

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
    
    and go to url : http://127.0.0.1:3579/explorer/index.html

## Run unittests

    py.test

## Run integration tests

    behave

Get a detailed coverage report:

    behave -D coverage-format=short

Get a more detailed coverage report:

    behave -D coverage-format=long
