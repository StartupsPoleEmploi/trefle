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



Scénario: AIF avec ARE finissant avant la fin de la formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 30
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un bénéficiaire de droit privé
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Et l'âge du bénéficiaire vaut 30
    Et c'est un travailleur handicapé
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 758
    Et la date de fin de la formation vaut «2018-05-04»
    Et la date de fin de l'allocation du bénéficiaire vaut «2018-04-04»
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la liste des codes ROME de la formation vaut [«A1101»]
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 758
    Et la RFF applicable vaut 652.02
