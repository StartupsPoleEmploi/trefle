Fonctionnalité: Provence-Alpes-Côte d'Azur


Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et l'âge du bénéficiaire vaut 30
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 401.09
    Et le plafond de prise en charge vaut 3000


Scénario: AIF avec ARE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la montant de l'allocation du bénéficiaire vaut 600
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la région du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 616.2
    Et le plafond de prise en charge vaut 3000


Scénario: formation trop longue pour l'AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la durée en mois de la formation vaut 14
    Et la région du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé
