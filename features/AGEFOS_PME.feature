Fonctionnalité: AGEFOS PME
    Les scénarios de test d'AGEFOS PME.

Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le taux horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 70
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 1412
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme tutelle est «AGEFOS PME»
    Et le montant de prise en charge vaut 2500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme tutelle est «AGEFOS PME»
    Et le montant de prise en charge vaut 2500
    Et la rémunération vaut 0

Scénario: plafond horaire d'une formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le taux horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 70
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 1412
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le code CPF de la formation vaut 200
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme tutelle est «AGEFOS PME»
    Et le montant de prise en charge vaut 2500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme tutelle est «AGEFOS PME»
    Et le montant de prise en charge vaut 2500
    Et la rémunération vaut 0

Scénario: cas nominal d'une formation Région (Conseil régional)
    # https://labonneformation.pole-emploi.fr/annonce-formation/titre-professionnel-gestionnaire-de-paie-68434
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible région «Provence-Alpes-Côte d'Azur»
    Et la région de l'établissement du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et le taux horaire de la formation vaut 50
    Et la durée en heures de la formation vaut 910
    Et le solde CPF du bénéficiaire vaut 150
    Et l'IDCC de l'établissement du bénéficiaire vaut 567
    Et le code NAF de l'établissement du bénéficiaire vaut 3213Z
    Et la rémunération du bénéficiaire vaut 2000
    Et le type de contrat du bénéficiaire vaut CDI
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme tutelle est «AGEFOS PME»
    Et le montant de prise en charge vaut 7500
    Et la rémunération vaut 2000
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme tutelle est «AGEFOS PME»
    Et le montant de prise en charge vaut 7500
    Et la rémunération vaut 0

