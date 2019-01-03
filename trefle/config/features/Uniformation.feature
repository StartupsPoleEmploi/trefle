Fonctionnalité: Uniformation
    Cas d'usage dédiés à Uniformation.

Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 1518
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 0


Scénario: formation COPANEF avec prix horaire supérieur au plafond
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 1518
    Et le prix horaire de la formation vaut 45
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 2000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 2000
    Et la rémunération applicable vaut 0


Scénario: bilan de compétences COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 1518
    Et la durée en heures de la formation vaut 100
    Et c'est un bilan de compétences
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le plafond de prise en charge vaut 2800
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le plafond de prise en charge vaut 2800
    Et la rémunération applicable vaut 0
