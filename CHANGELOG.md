# Changelog

## 0.8.0

- new explorer in VueJS with iso fonctionalty with old one
- new explorer: possibility to modifiy rules
- api: new authentification endpoint, be authentify to process rules modification
- api: new remuneration endpoint /remuneration
- api: new source code endpoint, possibility to interact with gitlab to modifiy rules
- api: new certifinfo endpoint, to get label of one or more certifinfo
- api: new healthcheck endpoint
- change repo from framagit to gitlab PE


## 0.7.0

- switch to LBF json catalog instead of Intercarif XML
- rules: remove CIF and contrat de professionnalisation
- rules: add legacy LBF API mode
- rules: add DE rules
- refactor financements populate
- simulate: allow to filter financements by tags
- explorer: add progressiv bar, cache scenarios, and display simulation request errors
- explorer: change API path to relative
- explorer: only display bénéficiaire and formation context in simulate
- explorer: add Features tab

## 0.6.0

- refactor rule loading and processing to allow rule inheritance
- more rules for "période de professionnalisation"
- first rules for "plan de formation"
- explorer: display full text "codes financeur"
- changed qualifiant in certifiant and changed formation.certifiante computing
- explorer: add financements page with financements metadatas
- explorer: autoselect scenario on focus
- deal with entrées-sorties permanentes in période de professionnalisation

## 0.5.0

- explorer: display label from enum if any
- add 'UNAGECIF' organisme details and rules
- display line number in case of parsing error
- add 'Fafih' rules for «période de professionnalisation»
- remove code financeur 16 when one of {0, 5, 10} is also present
- add experimental eligibilite rules in API output
- add 'ANFA' basic rules for «période de professionnalisation»
- add 'Forco' basic rules for «période de professionnalisation»

## 0.4.0

- fixed Actalians CPF rules which were also targetting «période de
  professionnalisation»
- added Constructys rules for «période de professionnalisation»
- now also expose `financement.heures` so we know how many hours are financed
  according to the context and rules
- consider None values as missing keys also for non required fields
- explorer: group schema entries by category
- added Unifaf rules for "période de professionnalisation"
- added basic rules for "période de professionnalisation" for
  "OPCA Transports et Services"
- explorer: display enum in schema
- explorer: direct link to schema property
- add OPCALIM période de professionnalisation rules

## 0.3.1

- catch Intercarif returning a non XML response content

## 0.3.0

- now keep tree structure when loading rules
- fixed crash when beneficiaire.remuneration was an empty string
- added check "nombre de mois travaillés dans la dernière année" also for people
  older than 26 years old
- added simulate logs
- added basic CIF rules for intérimaires
- moved postprocess logic from code to rules
- split eligibilité rules
- added field `indemnite_conges_payes`
- Explorer: added a menu and anchors to the rules lines


## 0.2.0

- there is only one CERTIFINFO per formation
- add a prototype of an explorer
- beneficiaire.remuneration is no more mandatory
- remove "CIF intermittents sur son temps de travail"
- add /naf endpoint for naf code autocompletion
- added a '--reload' option to the dev server
- fixed the CIF rules to match when there is no code financeur at all in the
  formation data
- add Fafiec rules for "période de professionnalisation"
- add FAFSEA rules for "période de professionnalisation"
- add a default "prix horaire plafond" for "période de professionnalisation"


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
