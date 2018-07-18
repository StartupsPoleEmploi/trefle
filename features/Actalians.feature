Fonctionnalité: Actalians
    Les scénarios de test d'Actalians.

Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 0


Scénario: formation COPAREF IDF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible région «Île-de-France»
    Et ce n'est pas une formation éligible COPANEF
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et le prix horaire de la formation vaut 50
    Et la durée en heures de la formation vaut 910
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et la rémunération du bénéficiaire vaut 1600
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 2500
    Et la rémunération applicable vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 2500
    Et la rémunération applicable vaut 0


Scénario: formation COPAREF IDF sur code INSEE commune
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible région «Île-de-France»
    Et ce n'est pas une formation éligible COPANEF
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «93031»
    Et le prix horaire de la formation vaut 50
    Et la durée en heures de la formation vaut 910
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et la rémunération du bénéficiaire vaut 1600
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 2500
    Et la rémunération applicable vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 2500
    Et la rémunération applicable vaut 0


Scénario: formation VAE avec prix horaire supérieur au plafond
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et c'est une formation VAE
    Et la durée en heures de la formation vaut 50
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 600
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 600
    Et la rémunération applicable vaut 0


Scénario: formation CleA avec prix horaire supérieur au plafond
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 30
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et c'est une formation CléA
    Et la durée en heures de la formation vaut 50
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1350
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1350
    Et la rémunération applicable vaut 0


Scénario: cas nominal d'une formation CPNE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le solde CPF du bénéficiaire vaut 50
    Et ce n'est pas une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et le code NAF de l'établissement du bénéficiaire vaut «6910Z»
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Et les codes NAF CPNE éligibles valent [«6910Z»]
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 0


Scénario: Cas nominal d'une période de professionnalisation CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2706»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le plafond de prise en charge vaut 915
    Et la rémunération applicable vaut 1400

# https://labonneformation.beta.pole-emploi.fr/engager-les-demarches?a=W6LdO5LLGVeKYcg4TkJiTd1Gt7NssmCCQRssIycl_RMsGsRlJOS2asoY9pYRykoOcIv2GlIYi1yf6KcA8BNPBYeasffYasiRI3fi33m2s4KssRnisEP0uwZitZV1FOik-0mvhpFnbeY-43qQoXY78Q7R_joV30CTL-G2DdeeXUHBZVsmmMfrdcjmvI-PLiGYaVZmaQFHoskXgkQiPcG90yisebwJ4wWc5MrBr9wjy8KGwp1mQ3Qs48633CZCuwOBYh-JalgM6lQQU-jZnBWi9SX41yknyEKJB%3DPRInG5RGcnypYPL4hxUQKXjVokabMDqEoZ25oasWDqWcde5yAx5T%3DFRkmQ0mgEZjiJ5F0OQXD7iV9oJkBLQ8K4_iaufrmeX7e7ND1H02HB1U9N_qdx_EFk7M7of5kgSIQz
Scénario: Montant période de profesionnalisation
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1400.0
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 30
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 30
    Et le code NAF de l'établissement du bénéficiaire vaut «7111Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2332»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «75056»
    Et le âge du bénéficiaire vaut 28
    Et c'est un bénéficiaire de droit privé
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et c'est une formation éligible COPANEF
    Et la liste des codes FORMACODE de la formation vaut [31684,22223,71110]
    Et la liste des domaines FORMACODE de la formation vaut [316,222,711]
    Et le code CERTIFINFO de la formation vaut 86414
    Et la durée en heures de la formation vaut 70
    Et le prix horaire de la formation vaut 0
    Et la code AIS de la formation vaut 2
    Et l'OPCA de l'établissement du bénéficiaire vaut «Actalians»
    Et l'OPACIF de l'établissement du bénéficiaire vaut «Fongecif»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le plafond de prise en charge vaut 640.5
    Et la rémunération applicable vaut 1400.0
