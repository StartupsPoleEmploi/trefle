Fonctionnalité: Tests génériques
    Les scénarios de test génériques.

Scénario: le bénéficiaire n'a pas d'heures CPF sur son compte
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 0
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Quand je demande un calcul de financement
    Alors le financement «CPF sur son temps de travail» n'est pas proposé
    Et le financement «CPF hors temps de travail» n'est pas proposé

Scénario: le bénéficiaire n'est pas de droit privé
    Soit un bénéficiaire et une formation
    Et ce n'est pas un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 0
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé

Scénario: cas d'une formation CPF avec solde CPF null
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le solde CPF du bénéficiaire vaut 0
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Alors le financement «CPF sur son temps de travail» n'est pas proposé
    Et le financement «CPF hors temps de travail» n'est pas proposé

Scénario: cas d'une formation CPF sans solde CPF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Alors le financement «CPF sur son temps de travail» n'est pas proposé
    Et le financement «CPF hors temps de travail» n'est pas proposé


Scénario: le solde CPF n'est pas plafonné
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et le prix horaire de la formation vaut 10
    Et la durée en heures de la formation vaut 300
    Et le solde CPF du bénéficiaire vaut 192
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors le plafond de prise en charge vaut 1920
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors le plafond de prise en charge vaut 1920


# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=M5M3uqubGVeKYcg4TkJiTDe4PsIssmpCQ4ssllQwsGsGt_CCkPs4cgsuafeH_jdeWeK5rYYjs3s-3avGaPoyHN3YacmHKo3vK2Y8Ide6QYjYmQa001ie0u0fyyhcRom2FLex9VJ4LOjq9c4I38mveWUKdP9BhAr-oGZgRgGUZiAxBG6-87BIKHB1%3DbYpaDcYct7197jo2QQpRDe7x8aHXbSFyvH3DjsY3m4D44X6sddOh_TXJndjlTc%3DBhUhU9pV7iLf59yjAQ%3DDO1R1Qa8PjmH7kgY-5mSOc0yYxOURVjVdHvUxBgLrcDrpe_OU2B3xUoN412YgMGoAfgJ-rwabSlxgM-NvflcmG0CRptDINONmsFXVhmMqAw%3D%3DwIK-GS7a-m%3DXhtbDMNIWIH46Gp-g
Scénario: CIF et CPF
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1500
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 150
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 24
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 24
    Et le code NAF de l'établissement du bénéficiaire vaut «7830Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2397»
    Et la région de l'établissement du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et ce n'est pas une formation éligible COPANEF
    Et les codes NAF CPNE éligibles vaut [«7830Z»,«8299Z»,«4633Z»,«1089Z»]
    Et la liste des codes FORMACODE de la formation vaut [44028,42866,42056]
    Et le niveau de sortie de la formation vaut «aucun»
    Et la durée en heures de la formation vaut 210
    Et le code CERTIFINFO de la formation vaut 87647
    Et la liste des domaines FORMACODE de la formation vaut [420,440,428]
    Et les codes financeur de la formation valent [5]
    Et la durée en mois de la formation vaut 12
    Et la durée en semaines de la formation vaut 52
    Et la durée hebdomadaire de la formation vaut 35
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Auvergne Rhône Alpes»
    Et le plafond de prise en charge vaut 7500
    Et la rémunération applicable vaut 1500
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Auvergne Rhône Alpes»
    Et le plafond de prise en charge vaut 7500
    Et la rémunération applicable vaut 0
    Quand je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif Auvergne Rhône Alpes»
    Et le plafond de prise en charge vaut 5764.5
    Et la rémunération applicable vaut 1500
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif Auvergne Rhône Alpes»
    Et le plafond de prise en charge vaut 5764.5
    Et la rémunération applicable vaut 0


Scénario: le bénéficiaire n'a pas défini de rémunération
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 150
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 24
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 24
    Et le code NAF de l'établissement du bénéficiaire vaut «7830Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2397»
    Et la région de l'établissement du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et ce n'est pas une formation éligible COPANEF
    Et les codes NAF CPNE éligibles vaut [«7830Z»,«8299Z»,«4633Z»,«1089Z»]
    Et la liste des codes FORMACODE de la formation vaut [44028,42866,42056]
    Et le niveau de sortie de la formation vaut «aucun»
    Et la durée en heures de la formation vaut 210
    Et le code CERTIFINFO de la formation vaut 87647
    Et la liste des domaines FORMACODE de la formation vaut [420,440,428]
    Et les codes financeur de la formation valent [5]
    Et la durée en mois de la formation vaut 12
    Et la durée en semaines de la formation vaut 52
    Et la durée hebdomadaire de la formation vaut 35
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Auvergne Rhône Alpes»
    Et le plafond de prise en charge vaut 7500
    Et la rémunération applicable vaut 0
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Auvergne Rhône Alpes»
    Et le plafond de prise en charge vaut 7500
    Et la rémunération applicable vaut 0
    Quand je sélectionne le financement «CIF CDI sur son temps de travail»
    Alors l'organisme à contacter est «Fongecif Auvergne Rhône Alpes»
    Et le plafond de prise en charge vaut 5764.5
    Et la rémunération applicable vaut 0
    Quand je sélectionne le financement «CIF CDI hors temps de travail»
    Alors l'organisme à contacter est «Fongecif Auvergne Rhône Alpes»
    Et le plafond de prise en charge vaut 5764.5
    Et la rémunération applicable vaut 0
