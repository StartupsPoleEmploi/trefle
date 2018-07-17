Fonctionnalité: UNAGECIF
    Cas d'usage de UNAGECIF


Scénario: cas nominal d'un CIF CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 5001
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «UNAGECIF»
    Et le montant de prise en charge vaut 12000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «UNAGECIF»
    Et le montant de prise en charge vaut 12000
    Et la rémunération applicable vaut 0
