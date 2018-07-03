Fonctionnalité: OPCA Transports et Services
    Cas d'usage pour OPCA Transports et Services.


Scénario: Cas nominal d'une période de professionnalisation CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2972»
    Et la durée en heures de la formation vaut 100
    Et la liste des domaines FORMACODE de la formation vaut [318]
    Et le niveau de sortie de la formation vaut «V»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «OPCA Transports et Services»
    Et le plafond de prise en charge vaut 1050
    Et la rémunération applicable vaut 1400



Scénario: Cas nominal d'une période de professionnalisation CDI avec FORMACODE 31816
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2972»
    Et la durée en heures de la formation vaut 100
    Et la liste des codes FORMACODE de la formation vaut [31816]
    Et la liste des domaines FORMACODE de la formation vaut [318]
    Et le niveau de sortie de la formation vaut «V»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «OPCA Transports et Services»
    Et le plafond de prise en charge vaut 1350
    Et la rémunération applicable vaut 1400

