Fonctionnalité: ACTALIANS
    Les scénarios de test d'ACTALIANS.

Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et le taux horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme tutelle est «ACTALIANS»
    Et le montant de prise en charge vaut 3000
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme tutelle est «ACTALIANS»
    Et le montant de prise en charge vaut 3000
    Et la rémunération vaut 0


Scénario: formation COPAREF IDF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible région «Île-de-France»
    Et ce n'est pas une formation éligible COPANEF
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et le taux horaire de la formation vaut 50
    Et la durée en heures de la formation vaut 910
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et la rémunération du bénéficiaire vaut 1600
    Et le type de contrat du bénéficiaire vaut CDI
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme tutelle est «ACTALIANS»
    Et le montant de prise en charge vaut 2500
    Et la rémunération vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme tutelle est «ACTALIANS»
    Et le montant de prise en charge vaut 2500
    Et la rémunération vaut 0



Scénario: formation COPAREF IDF sur code INSEE commune
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible région «Île-de-France»
    Et ce n'est pas une formation éligible COPANEF
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «93031»
    Et le taux horaire de la formation vaut 50
    Et la durée en heures de la formation vaut 910
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et la rémunération du bénéficiaire vaut 1600
    Et le type de contrat du bénéficiaire vaut CDI
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme tutelle est «ACTALIANS»
    Et le montant de prise en charge vaut 2500
    Et la rémunération vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme tutelle est «ACTALIANS»
    Et le montant de prise en charge vaut 2500
    Et la rémunération vaut 0

