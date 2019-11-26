Fonctionnalité: ADEMA


Scénario: Cas nominal ADEMA
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Normandie»
    Et l'intitulé de la formation vaut «Accès des Demandeurs d'Emploi aux Métiers Agricoles - ADEMA»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Accès des demandeurs d’emploi aux métiers agricoles»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: ADEMA non trouvé dans l'intitulé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Normandie»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Et l'intitulé de la formation vaut «Accès des Demandeurs d'Emploi aux Métiers de l'Industrie»
    Quand je demande un calcul de financement
    Alors le financement «Accès des demandeurs d’emploi aux métiers agricoles» n'est pas proposé
