Fonctionnalité: Guyane

Scénario: AIF exclu pour cause d'un mauvais code RNCP
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 100
    Et la région du bénéficiaire vaut «Guyane»
    Et le code RNCP de la formation vaut 28414
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé

Scénario: cas nominal AIF Guyane
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 100
    Et la région du bénéficiaire vaut «Guyane»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 0
    Et le plafond de prise en charge vaut 2800
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
