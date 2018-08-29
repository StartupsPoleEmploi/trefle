Fonctionnalité: contrat de professionnalisation


Scénario: Contrat de professionnalisation pour un mineur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat de professionnalisation
    Et le âge du bénéficiaire vaut 17
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat de professionnalisation»
    Alors la rémunération applicable vaut 824.16


Scénario: jeune de moins de 21 ans ayant un niveau bac pro ou supérieur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat de professionnalisation
    Et le âge du bénéficiaire vaut 20
    Et la niveau scolaire du bénéficiaire vaut «IV»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat de professionnalisation»
    Alors la rémunération applicable vaut 974.01


Scénario: jeune de 22 ans sans niveau scolaire
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat de professionnalisation
    Et le âge du bénéficiaire vaut 22
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat de professionnalisation»
    Alors la rémunération applicable vaut 1048.93


Scénario: travailleur handicapé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat de professionnalisation
    Et le âge du bénéficiaire vaut 30
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est un travailleur handicapé
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat de professionnalisation»
    Alors la rémunération applicable vaut 1498.47


Scénario: trop âgé pour un contrat de professionnalisation
    Soit un bénéficiaire et une formation
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat de professionnalisation
    Et le âge du bénéficiaire vaut 30
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Formation en alternance : contrat de professionnalisation» n'est pas proposé


Scénario: jeune de moins de 26 ans non demandeur d'emploi
    Soit un bénéficiaire et une formation
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat de professionnalisation
    Et le âge du bénéficiaire vaut 22
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat de professionnalisation»
    Alors la rémunération applicable vaut 1048.93
