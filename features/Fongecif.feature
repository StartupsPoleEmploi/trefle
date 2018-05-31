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


Scénario: cas d'un CIF CDI avec 12 mois d'ancienneté dans l'entreprise (moins d'un an donc)
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
    Et la durée en heures de la formation vaut 120
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 3294
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif»
    Et le montant de prise en charge vaut 3294
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

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=SdCOL%3DbLGVeKYcg4TkJiTImSLjGssw3CQ4ssllQvsGsst_CCTPs4cEJc7g8Bj8Rv2PuY8I5H4eKRmi32vvviGsss3s33yeHSoOBsUsssMkaX3S69eKn4ObIEG%3DM27_895omh%3Dosrin9VkJCN1ERDpLrno4yuiprGmE%3DJy5HS7vvBdshgIVXxe%3DcB0pKkwivfQ0%3D2_uNGL2ekmG9CKsd2RkY3sR2KYe5hRGlJebF84mZhi2KFTh2vctKVT7yu7qXorGebvgmYTecf4SRVnvo3Gd9QBsPEa3SSWfQGtO6cbWfSLf0djEco7FoIm4ds95Bm15LC94OWY7aRiUButexJvlrxYMM9usFSUESmvsBjW52gMO9lgqHgXgRGGPVFeszz
Scénario: Formation de 12 mois
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1500
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 48
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 24
    Et le code NAF de l'établissement du bénéficiaire vaut «2825z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1412»
    Et la région de l'établissement du bénéficiaire vaut «Normandie»
    Et ce n'est pas une formation éligible COPANEF
    Et la régions éligibles COPAREF vaut [25]
    Et la liste des codes FORMACODE de la formation vaut [31715,31715,31795]
    Et le niveau de sortie de la formation vaut 1
    Et la durée en heures de la formation vaut 1000
    Et la liste des codes CERTIFINFO de la formation vaut [55824]
    Et la liste des domaines FORMACODE de la formation vaut [317]
    Et c'est une formation CACES
    Et les codes financeur de la formation vaut [0,16,10,5]
    Et c'est une formation qualifiante
    Et la durée en mois de la formation vaut 12
    Et la durée en semaines de la formation vaut 52
    Et la durée hebdomadaire de la formation vaut 0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif Normandie»
    Et le plafond de prise en charge vaut 18000
    Et la rémunération vaut 1500
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif Normandie»
    Et le plafond de prise en charge vaut 18000
    Et la rémunération vaut 0
