Fonctionnalité: POEI


Scénario: Cas nominal POEI
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations avant embauche (AFPR, POEI)»
    Alors la rémunération applicable vaut 401.09


Scénario: Pas de POEI pour formation diplômante
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation diplômante
    Quand je demande un calcul de financement
    Alors le financement «Formations avant embauche (AFPR, POEI)» n'est pas proposé


Scénario: Pas de POEI pour contrat d'apprentissage
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est un contrat d'apprentissage
    Quand je demande un calcul de financement
    Alors le financement «Formations avant embauche (AFPR, POEI)» n'est pas proposé


Scénario: Pas de POEI pour domaine FORMACODE 440
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la liste des codes FORMACODE de la formation vaut [44068]
    Et la liste des domaines FORMACODE de la formation vaut [440]
    Quand je demande un calcul de financement
    Alors le financement «Formations avant embauche (AFPR, POEI)» n'est pas proposé


Scénario: POEI possible pour FORMACODE 44067
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la liste des domaines FORMACODE de la formation vaut [440]
    Et la liste des codes FORMACODE de la formation vaut [44067]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations avant embauche (AFPR, POEI)»
    Alors la rémunération applicable vaut 401.09


Scénario: POEI avec ARE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et c'est une préparation opérationnelle à l'emploi individuelle
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la montant de l'allocation du bénéficiaire vaut 800.0
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations avant embauche (AFPR, POEI)»
    Alors la rémunération applicable vaut 800