Fonctionnalité: POEC


Scénario: Cas nominal POEC
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une préparation opérationnelle à l'emploi collective
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Préparation opérationnelle à l'emploi collective»
    Alors la rémunération applicable vaut 401.09


Scénario: POEC avec une VAE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une préparation opérationnelle à l'emploi collective
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la montant de l'allocation du bénéficiaire vaut 800
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Préparation opérationnelle à l'emploi collective»
    Alors la rémunération applicable vaut 800


Scénario: Pas de POEC pour une VAE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une préparation opérationnelle à l'emploi collective
    Et c'est une formation VAE
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Préparation opérationnelle à l'emploi collective» n'est pas proposé


Scénario: Formation trop longue pour POEC
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 500
    Et c'est une préparation opérationnelle à l'emploi collective
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Préparation opérationnelle à l'emploi collective» n'est pas proposé
