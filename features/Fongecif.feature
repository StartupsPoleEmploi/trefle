Fonctionnalité: Fongecif
    Cas d'usage de Fongecif


Scénario: cas nominal d'un CIF CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 12500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 12500
    Et la rémunération vaut 0


Scénario: cas d'un CIF CDI avec moins de 24 mois d'expérience professionnelle
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 20
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 20
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé


Scénario: cas d'un CIF CDI avec moins de 12 mois d'ancienneté dans l'entreprise
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 11
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé


Scénario: CIF CDI avec plafond financier
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 1000
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 18000
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 18000
    Et la rémunération vaut 0


Scénario: CIF CDI avec plafond prix horaire
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 30
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 2745
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 2745
    Et la rémunération vaut 0


Scénario: CIF CDI avec un salaire > 2 SMIC
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 3000
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 1000
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 18000
    # Et le reste à charge vaut 900
    Et la rémunération vaut 2850
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 18000
    # Et le reste à charge vaut 900
    Et la rémunération vaut 0


Scénario: CIF CDI avec un salaire > 3 SMIC
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 6000
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 1000
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 18000
    Et la rémunération vaut 5400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 18000
    Et la rémunération vaut 0


Scénario: cas nominal d'un CIF CDD pour un bénéficiaire âgé de plus de 26 ans
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 25
    Et le type de contrat du bénéficiaire vaut CDD
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Et l'âge du bénéficiaire vaut 30
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDD sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 12500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDD hors temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 12500
    Et la rémunération vaut 0


Scénario: cas nominal d'un CIF CDD pour un bénéficiaire âgé de plus de 26 ans manquant d'expérience professionnelle
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 11
    Et le type de contrat du bénéficiaire vaut CDD
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Et l'âge du bénéficiaire vaut 30
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé


Scénario: cas nominal d'un CIF CDD pour un bénéficiaire âgé de moins de 26 ans
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 14
    Et le nombre de mois travaillés par le bénéficiaire dans la dernière année vaut 8
    Et le type de contrat du bénéficiaire vaut CDD
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Et l'âge du bénéficiaire vaut 24
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDD sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 12500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDD hors temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 12500
    Et la rémunération vaut 0


Scénario: cas d'un CIF CDI d'un jeune de moins de 26 ans dans l'artisanat
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 40
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 1596
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 12500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 12500
    Et la rémunération vaut 0


Scénario: cas d'un CIF CDI dans l'artisanat d'un jeune manquant d'ancienneté professionnelle
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 30
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 1596
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé


Scénario: CIF CDI en Corse
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire vaut CDI
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Et la région de l'établissement du bénéficiaire est «Corse»
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif Corsica»
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif Corsica»
