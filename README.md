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

  Swagger API DOC : https://app.swaggerhub.com/apis/labonneformation/moteur-financement-formation

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

    Exemple:
    trefle simulate --context='{"beneficiaire":{"inscrit_pe":true,"age":40},"formation":{ "codes_financeur":[2],"region":27,"heures":4000}}' --trace

## Run the backoffice in dev mode

    cd backoffice

    npm install
    npm run serve

    and go to url : http://127.0.0.1:8080/explorer

## Run unittests

    py.test

## Run integration tests

    behave

Get a detailed coverage report:

    behave -D coverage-format=short

Get a more detailed coverage report:

    behave -D coverage-format=long

## Build project in PROD mode

1. Go to docker folder

2. Add this env var:

    ```
    VERSION api-vX.X.X
    OLD_VERSION api-vX.X.X
    BACK_VERSION backoffice-vX.X.X
    LBF_CHARMAP "sA,4B,RC,cD,oE,gF,yG,wH,mI,HJ,7K,EL,aM,YN,XO,8P,GQ,BR,kS,iT,IU,AV,TW,DX,pY,JZ,2a,Lb,Mc, d,de,Cf,Qg,fh,ri,Pj,Nk,Vl,vm,0n,Ko,ep,jq,Zr,9s,ht,Fu,tv,-w,Ux,1y,xz,30,u1,52,q3,W4,S5,66,n7,b8,O9,_+,l/,z "
    CATALOG_USER {ASK-YOUR-LBF-CATALOG-API-USER}
    CATALOG_KEY {ASK-YOUR-LBF-CATALOG-API-KEY}
    CATALOG_URL https://labonneformation.pole-emploi.fr/api/v1/detail
    TREFLE_GIT https://git.beta.pole-emploi.fr/open-source/trefle.git
    ```


where X.X.X is a tag of the TREFLE_GIT
OLD_VERSION and BACK_VERSION must be compatible

3. Add email, password, and rule file authorized to be modified in docker/authorisations.csv
    i.e: `myname@email.com, mypassord, Occitanie.rules`

4. docker-compose up --build -d


## Update acces

1. Update file authorisations.csv in docker/authorisations.csv
2. in docker folder do `sh update_access`
logs are in docker/logs
