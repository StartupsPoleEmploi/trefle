Fonctionnalité: FAF.TT
    Cas d'usage de FAF.TT


Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2378
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 0


Scénario: cas nominal d'une formation CPNE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et ce n'est pas une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et le code NAF de l'établissement du bénéficiaire vaut 6910Z
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Et les codes NAF CPNE éligibles valent [6910Z]
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 0
