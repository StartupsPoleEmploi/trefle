Fonctionnalité: Constructys
    Les scénarios de test de Constructys.

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=bS3u%3DqLuGVeKYcg4TkJiTI8ZPj3ssmWCQ4ssllQysssGt_CC2Ps4c21cBcHavvvNpG33ciusBi31H6HKsssssNf70nBo1iH6vv0jJs28kk4gxeKg6L8K17n3pwyY%3DqYuSHu30VXk91wooGxx9g0cVrbk0AZvhs3Q%3DgvtR%3Do9KtgRrZygTKvPrkrMRypQst2LgZ4w9oPQX4kyGhBs2mF7yWVKse2JKBHY0loPK14I14416JJM-n_ZlXRFX2Ohdq9iVY82FQX5-L2d-Jr0QULdbiUjvcUk3u84-rZNQ1_I0DGp7BQi7t7Hia5YjKo2tgvX4YGjiF2uIarNrdE3HydRJtpVy23hhhBBtyZo33x7hSALCFt9QXnRcwv5wy9Eg5eB_gw4KyT6pa-0-JlqclgqHgXgRGG_FXZG
Scénario: Formation COPANEF
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1400
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 100
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 36
    Et le code NAF de l'établissement du bénéficiaire vaut «8130Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut 2409
    Et c'est une formation éligible COPANEF
    Et le niveau de sortie de la formation vaut «IV»
    Et la durée en heures de la formation vaut 2320
    Et la durée en mois de la formation vaut 22
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Constructys»
    Et le plafond de prise en charge vaut 3000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Constructys»
    Et le plafond de prise en charge vaut 3000
    Et la rémunération applicable vaut 0

Scénario: Période de professionnalisation CléA
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1500.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 24
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 2
    Et le code NAF de l'établissement du bénéficiaire vaut «4120B»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2420»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «13055»
    Et le âge du bénéficiaire vaut 28
    Et c'est une formation CléA
    Et la région de l'établissement du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et ce n'est pas une formation éligible COPANEF
    Et la liste des codes FORMACODE de la formation vaut [15030,15040,15041]
    Et la liste des domaines FORMACODE de la formation vaut [150]
    Et la durée en heures de la formation vaut 230
    Et le prix horaire de la formation vaut 0
    Et la code AIS de la formation vaut 5
    Et le niveau de sortie de la formation vaut «inconnu»
    Et la durée en semaines de la formation vaut 10
    Et la durée en mois de la formation vaut 2
    Et la durée hebdomadaire de la formation vaut 23
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Constructys»
    Et le plafond de prise en charge vaut 5060
    Et la rémunération applicable vaut 1500.0


Scénario: Période de professionnalisation réservée par une collectivité territoriale
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1500.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 24
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 2
    Et le code NAF de l'établissement du bénéficiaire vaut «4120B»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2420»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «13055»
    Et le âge du bénéficiaire vaut 28
    Et c'est une formation CléA
    Et la région de l'établissement du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et les codes financeur de la formation vaut [2]
    Et ce n'est pas une formation éligible COPANEF
    Et la liste des codes FORMACODE de la formation vaut [15030,15040,15041]
    Et la liste des domaines FORMACODE de la formation vaut [150]
    Et la durée en heures de la formation vaut 230
    Et le prix horaire de la formation vaut 0
    Et la code AIS de la formation vaut 5
    Et le niveau de sortie de la formation vaut «inconnu»
    Et la durée en semaines de la formation vaut 10
    Et la durée en mois de la formation vaut 2
    Et la durée hebdomadaire de la formation vaut 23
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé


Scénario: Période de professionnalisation FLE
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1500.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 24
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 2
    Et le code NAF de l'établissement du bénéficiaire vaut «4120B»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2420»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «13055»
    Et le âge du bénéficiaire vaut 28
    Et la région de l'établissement du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et la liste des codes FORMACODE de la formation vaut [15226]
    Et la liste des domaines FORMACODE de la formation vaut [152]
    Et la durée en heures de la formation vaut 100
    Et le prix horaire de la formation vaut 0
    Et la code AIS de la formation vaut 5
    Et le niveau de sortie de la formation vaut «inconnu»
    Et la durée en semaines de la formation vaut 10
    Et la durée en mois de la formation vaut 2
    Et la durée hebdomadaire de la formation vaut 23
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Constructys»
    Et le plafond de prise en charge vaut 2200
    Et la rémunération applicable vaut 1500.0


Scénario: Période de professionnalisation chantier
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1500.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 24
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 2
    Et le code NAF de l'établissement du bénéficiaire vaut «4120B»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2420»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «13055»
    Et le âge du bénéficiaire vaut 28
    Et la région de l'établissement du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et la liste des codes FORMACODE de la formation vaut [22286]
    Et la liste des domaines FORMACODE de la formation vaut [222]
    Et la durée en heures de la formation vaut 100
    Et le prix horaire de la formation vaut 0
    Et la code AIS de la formation vaut 5
    Et le niveau de sortie de la formation vaut «inconnu»
    Et la durée en semaines de la formation vaut 10
    Et la durée en mois de la formation vaut 2
    Et la durée hebdomadaire de la formation vaut 23
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Constructys»
    Et le plafond de prise en charge vaut 2200
    Et la rémunération applicable vaut 1500.0


Scénario: Période de professionnalisation lutte contre l'illétrisme
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1500.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 24
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 2
    Et le code NAF de l'établissement du bénéficiaire vaut «4120B»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2420»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «13055»
    Et le âge du bénéficiaire vaut 28
    Et la région de l'établissement du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et la liste des codes FORMACODE de la formation vaut [22286]
    Et la liste des domaines FORMACODE de la formation vaut [222]
    Et la durée en heures de la formation vaut 100
    Et le prix horaire de la formation vaut 0
    Et la code AIS de la formation vaut 5
    Et le niveau de sortie de la formation vaut «inconnu»
    Et la durée en semaines de la formation vaut 10
    Et la durée en mois de la formation vaut 2
    Et la durée hebdomadaire de la formation vaut 23
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Constructys»
    Et le plafond de prise en charge vaut 2200
    Et la rémunération applicable vaut 1500.0



Scénario: Période de professionnalisation conduit d'engins
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1500.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 24
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 2
    Et le code NAF de l'établissement du bénéficiaire vaut «4120B»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2420»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «13055»
    Et le âge du bénéficiaire vaut 28
    Et la région de l'établissement du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et la liste des codes FORMACODE de la formation vaut [31729]
    Et la liste des domaines FORMACODE de la formation vaut [317]
    Et la durée en heures de la formation vaut 100
    Et le prix horaire de la formation vaut 0
    Et la code AIS de la formation vaut 5
    Et le niveau de sortie de la formation vaut «inconnu»
    Et la durée en semaines de la formation vaut 10
    Et la durée en mois de la formation vaut 2
    Et la durée hebdomadaire de la formation vaut 23
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Constructys»
    Et le plafond de prise en charge vaut 2800
    Et la rémunération applicable vaut 1500.0
