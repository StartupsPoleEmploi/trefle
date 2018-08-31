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
