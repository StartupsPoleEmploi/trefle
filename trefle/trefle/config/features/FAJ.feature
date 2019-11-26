Fonctionnalité: FAJ

Scénario: cas nominal FAJ
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 18
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Normandie»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Fonds d'aide aux jeunes»
    Alors la rémunération applicable vaut 310.39

Scénario: bénéficiaire trop âge pour le FAJ
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 26
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Normandie»
    Quand je demande un calcul de financement
    Alors le financement «Fonds d'aide aux jeunes» n'est pas proposé
