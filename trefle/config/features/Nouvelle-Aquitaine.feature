Fonctionnalité: Cas d'usage de Nouvelle-Aquitaine

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors le plafond de prise en charge vaut 3000
    Et le texte de la prise en charge vaut «Formation partiellement ou totalement financée dans la limite de 3000 euros.»


Scénario: Formation trop longue pour l'AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 401
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: Durée hebdo trop courte pour l'AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la durée hebdomadaire de la formation vaut 20
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: Pas d'AIF à cause du domaine FORMACODE 150
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la liste des domaines FORMACODE de la formation vaut [150]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: AIF possible malgré un domaine FORMACODE 150 parce que le code CPF vaut 201
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la liste des domaines FORMACODE de la formation vaut [150]
    Et la liste des codes CPF de la formation vaut [201]
    Et c'est une formation CléA
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 0
