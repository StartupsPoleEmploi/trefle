Fonctionnalité: scénarios de tests pour la Corse

Scénario: AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la région du bénéficiaire vaut «Corse»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 0


Scénario: Cas nominal Action collective financée par la Collectivité territoriale de Corse
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Corse»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action collective financée par la Collectivité territoriale de Corse»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0

Scénario: Collective financée par la Collectivité territoriale de Corse avec mauvais code financeur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Corse»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«OPCO»]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Action collective financée par la Collectivité territoriale de Corse» n'est pas proposé


Scénario: Cas nominal Programme sanitaire et social
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Corse»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le code CERTIFINFO de la formation vaut 87185
    Et la région du bénéficiaire vaut «Corse»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme sanitaire et social»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Programme sanitaire et social sans code certifinfo
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Corse»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région du bénéficiaire vaut «Corse»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Programme sanitaire et social» n'est pas proposé

