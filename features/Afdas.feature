Fonctionnalité: Afdas
    Cas d'usage dédiés à Afdas.

Scénario: cas nominal d'un intermittent
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire est «intermittent»
    Et le prix horaire de la formation vaut 15
    # TODO: should we always point to Afdas when contrat == intermittent?
    Et l'IDCC de l'établissement du bénéficiaire vaut 5567
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF intermittents sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 7500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF intermittents hors temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 7500
    Et la rémunération vaut 0

Scénario: plafond prix horaire d'une formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 125
    Et la durée en heures de la formation vaut 70
    Et le solde CPF du bénéficiaire vaut 100
    Et l'IDCC de l'établissement du bénéficiaire vaut 5567
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le code CPF de la formation vaut 200
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 7000
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 7000
    Et la rémunération vaut 0

Scénario: plafond prix horaire d'une formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 50
    Et la durée en heures de la formation vaut 70
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 5567
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le code CPF de la formation vaut 200
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 3500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 3500
    Et la rémunération vaut 0
