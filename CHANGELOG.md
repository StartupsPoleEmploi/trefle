# Changelog

## dev

- there is only one CERTIFINFO per formation
- add a prototype of an explorer
- beneficiaire.remuneration is no more mandatory
- remove "CIF intermittents sur son temps de travail"
- add /naf endpoint for naf code autocompletion
- added a '--reload' option to the dev server
- fixed the CIF rules to match when there is no code financeur at all in the
  formation data


## 0.1.3

- logs: add version and dump message in json for easier postprocessing


## 0.1.2

- expose API version in headers
- be more liberal in what we accept for beneficiaire.entreprise.naf and beneficiaire.remuneration


## 0.1.1

- fix for missing formation.heures in formation data
- fix for missing formation.debut and formation.fin in formation data

## 0.1.0

- first released version
