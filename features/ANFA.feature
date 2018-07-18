Fonctionnalité: ANFA
    Tests relatifs à l'ANFA

Scénario: période de professionnalisation CDI CléA
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1090»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Et c'est une formation CléA
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «ANFA»
    Et le plafond de prise en charge vaut 1500
    Et la rémunération applicable vaut 1400

Scénario: période de professionnalisation CDI BEPECASER OK
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1090»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Et le code RNCP de la formation vaut 6103
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «ANFA»
    Et le plafond de prise en charge vaut 1500
    Et la rémunération applicable vaut 1400
