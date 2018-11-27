Fonctionnalité: POEI


Scénario: Cas nominal POEI
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Grand-Est»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations avant embauche (AFPR, POEI)»
    Alors la rémunération applicable vaut 401.09
    Et le plafond de prise en charge vaut 960


Scénario: Pas de POEI pour formation de l'ensignement supérieur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation de l'enseignement supérieur
    Et la région du bénéficiaire vaut «Grand-Est»
    Quand je demande un calcul de financement
    Alors le financement «Formations avant embauche (AFPR, POEI)» n'est pas proposé


Scénario: Pas de POEI pour contrat d'apprentissage
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est un contrat d'apprentissage
    Et la région du bénéficiaire vaut «Grand-Est»
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
    Et la région du bénéficiaire vaut «Grand-Est»
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
    Et la région du bénéficiaire vaut «Grand-Est»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations avant embauche (AFPR, POEI)»
    Alors la rémunération applicable vaut 401.09
    Et le plafond de prise en charge vaut 960


Scénario: POEI avec ARE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et c'est une préparation opérationnelle à l'emploi individuelle
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la montant de l'allocation du bénéficiaire vaut 800.0
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Grand-Est»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations avant embauche (AFPR, POEI)»
    Alors la rémunération applicable vaut 800
    Et le plafond de prise en charge vaut 960

Scénario: Financement exclu pour cause de FORMACODE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la montant de l'allocation du bénéficiaire vaut 800
    Et la liste des codes FORMACODE de la formation vaut [13030]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Grand-Est»
    Quand je demande un calcul de financement
    Alors le financement «Formations avant embauche (AFPR, POEI)» n'est pas proposé

Scénario: Financement OK avec FORMACODE exclu si bénficiaire en ARA
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la montant de l'allocation du bénéficiaire vaut 800.0
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la liste des codes FORMACODE de la formation vaut [13030]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Formations avant embauche (AFPR, POEI)»
    Alors la rémunération applicable vaut 800.0
    Et le plafond de prise en charge vaut 960
