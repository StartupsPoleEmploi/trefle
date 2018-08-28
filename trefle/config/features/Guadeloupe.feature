Fonctionnalité: Guadeloupe

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et l'âge du bénéficiaire vaut 30
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Aide individuelle à la formation»
    Alors le plafond de prise en charge vaut 1500
    Et la rémunération applicable vaut 401.09


Scénario: cas nominal AIF artisan
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et le code CERTIFINFO de la formation vaut 84385
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et l'âge du bénéficiaire vaut 30
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Aide individuelle à la formation artisan»
    Alors la rémunération applicable vaut 401.09
    Et le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: Mauvais FORMACODE pour l'AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la liste des codes FORMACODE de la formation vaut [15081]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé
