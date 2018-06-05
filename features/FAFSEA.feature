Fonctionnalité: FAFSEA
    Cas d'usage dédiés à FAFSEA.

Scénario: cas nominal d'un CIF CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 15
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 7500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 7500
    Et la rémunération vaut 0

Scénario: CIF CDI avec plafond de prix horaire
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 30
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 120
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 3294
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 3294
    Et la rémunération vaut 0

Scénario: CIF CDI avec plafond financier
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 30
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 1000
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 18000
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 18000
    Et la rémunération vaut 0

Scénario: CIF CDI avec plafond de rémunération
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 10000
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 10
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 5000
    Et la rémunération vaut 8000
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 5000
    Et la rémunération vaut 0


Scénario: CIF CDI avec plafond de rémunération et plancher à deux SMIC
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 3500
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 10
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 5000
    Et la rémunération vaut 2997
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 5000
    Et la rémunération vaut 0

Scénario: CIF CDI avec moins de 120 heures
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le prix horaire de la formation vaut 15
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Alors le financement «CIF CDI hors temps de travail» n'est pas proposé
    Quand je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 1500
    Et la rémunération vaut 1400


Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «FAFSEA»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 0
