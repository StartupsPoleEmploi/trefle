Fonctionnalité: Île-de-France

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le âge du bénéficiaire vaut 30
    Et la région du bénéficiaire vaut «Île-de-France»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 401.09


Scénario: Mauvais CERTIFINFO pour AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le âge du bénéficiaire vaut 30
    Et la région du bénéficiaire vaut «Île-de-France»
    Et le code CERTIFINFO de la formation vaut 54913
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé
