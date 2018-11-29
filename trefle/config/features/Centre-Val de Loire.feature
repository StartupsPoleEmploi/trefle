Fonctionnalité: Centre-Val de Loire

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le âge du bénéficiaire vaut 30
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 401.09


Scénario: AIF exclu pour les créations d'entreprise
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le âge du bénéficiaire vaut 30
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et la code AIS de la formation vaut «Création d'entreprise»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: AIF sur FOAD avec durée suffisante
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le âge du bénéficiaire vaut 30
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et c'est une formation ouverte à distance
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 401.09


Scénario: durée trop courte pour une AIF sur FOAD
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 12
    Et le âge du bénéficiaire vaut 30
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et c'est une formation ouverte à distance
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: Cas nominal AIF avec promesse d'embauche
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et la région de la formation vaut «Centre-Val de Loire»
    Et la liste des codes FORMACODE de la formation vaut [14406]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation avec promesse d'embauche»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Cas nominal AIF avec promesse d'embauche avec certinfo invalide
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation avec promesse d'embauche» n'est pas proposé


Scénario: Cas nominal chèque formation Conseil régional Centre-Val de Loire
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et c'est une formation RNCP
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Chèque formation Conseil régional Centre-Val de Loire»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Chèque formation Conseil régional Centre-Val de Loire avec formation non RNCP
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Chèque formation Conseil régional Centre-Val de Loire» n'est pas proposé


Scénario: Cas nominal programme Régional de Formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Centre-Val de Loire»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme Régional de Formation»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Programme Régional de Formation avec formation hors région
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bretagne»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Programme Régional de Formation» n'est pas proposé


Scénario: Cas nominal programme régional de formation Visa
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Centre-Val de Loire»
    Et l'intitulé de la formation vaut «Formation VISA»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme Régional de Formation Visa»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Programme régional de formation Visa dans Visa dans le titre
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Centre-Val de Loire»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Programme Régional de Formation Visa» n'est pas proposé


Scénario: Cas nominal formations sanitaire et sociale subventionnées par le Conseil régional Centre-Val de Loire
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Centre-Val de Loire»
    Et la liste des codes FORMACODE de la formation vaut [44083]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations sanitaire et sociale subventionnées par le Conseil régional Centre-Val de Loire»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Formations sanitaire et sociale subventionnées par le Conseil régional Centre-Val de Loire sans formacode élligible
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Centre-Val de Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Centre-Val de Loire»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Formations sanitaire et sociale subventionnées par le Conseil régional Centre-Val de Loire» n'est pas proposé
