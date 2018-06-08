Fonctionnalité: Uniformation
    Cas d'usage dédiés à Uniformation.

Scénario: cas nominal d'un CIF CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 15
    Et l'IDCC de l'établissement du bénéficiaire vaut 2941
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 7500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 7500
    Et la rémunération vaut 0

Scénario: CIF CDI avec plafond de prix horaire
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2941
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 9000
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 9000
    Et la rémunération vaut 0

Scénario: CIF CDI avec plafond de rémunération
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 8000
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 10
    Et l'IDCC de l'établissement du bénéficiaire vaut 2941
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 5000
    Et la rémunération vaut 7192
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 5000
    Et la rémunération vaut 0

Scénario: CIF CDI avec plafond de rémunération et formation qualifiante
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 8000
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 10
    Et l'IDCC de l'établissement du bénéficiaire vaut 2941
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Et c'est une formation qualifiante
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 5000
    Et la rémunération vaut 7519
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 5000
    Et la rémunération vaut 0

Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 1518
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 0


Scénario: formation COPANEF avec prix horaire supérieur au plafond
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 1518
    Et le prix horaire de la formation vaut 45
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 2000
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le montant de prise en charge vaut 2000
    Et la rémunération vaut 0


Scénario: bilan de compétences COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 1518
    Et la durée en heures de la formation vaut 100
    Et c'est un bilan de compétences
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le plafond de prise en charge vaut 2800
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le plafond de prise en charge vaut 2800
    Et la rémunération vaut 0


Scénario: Cas nominal d'une période de professionnalisation CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1518»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Uniformation»
    Et le plafond de prise en charge vaut 1200
    Et la rémunération vaut 1400
