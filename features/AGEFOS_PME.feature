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
    Et le type de contrat du bénéficiaire vaut cdi
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
    Et le type de contrat du bénéficiaire vaut cdi
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
