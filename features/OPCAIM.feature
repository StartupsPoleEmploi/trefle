Fonctionnalité: OPCAIM
    Tests de couverture des règles pour OPCAIM.


Scénario: période de professionnalisation CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «914»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 1
    Et la liste des domaines FORMACODE de la formation vaut [316]
    Et c'est une formation qualifiante
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «OPCAIM»
    Et le plafond de prise en charge vaut 3200
    Et la rémunération applicable vaut 1400


Scénario: formation non qualifiante
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «914»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 1
    Et la liste des domaines FORMACODE de la formation vaut [316]
    Quand je demande un calcul de financement
    Alors le financement «Période de professionnalisation sur son temps de travail» n'est pas proposé
