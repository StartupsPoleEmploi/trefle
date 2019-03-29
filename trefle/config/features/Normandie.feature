Fonctionnalité: Normandie

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Normandie»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation éligible CPF
    Et l'âge du bénéficiaire vaut 30
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 401.09


Scénario: Cas nominal VAE Normandie
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et le code CERTIFINFO de la formation vaut 83899
    Et la région du bénéficiaire vaut «Normandie»
    Et la durée en heures de la formation vaut 100
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «VAE Normandie»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 1400


Scénario: Cas nominal Qualif individuel
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Normandie»
    Et la durée en heures de la formation vaut 500
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Qualif individuel»
    Alors la rémunération applicable vaut 0


Scénario: Cas avec mauvaise région pour le beneficiaire
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région du bénéficiaire vaut «Bretagne»
    Et la région de la formation vaut «Normandie»
    Et la durée en heures de la formation vaut 500
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Qualif individuel» n'est pas proposé


Scénario: Cas nominal Une formation, un emploi - individuel
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Normandie»
    Et la durée en heures de la formation vaut 500
    Et la liste des codes FORMACODE de la formation vaut [44067]
    Et la liste des codes ROME de la formation vaut [«G1204»]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation éligible à la RFF
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Une formation, un emploi - individuel»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Une formation, un emploi - individuel sans au moins un bon code ROME
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Normandie»
    Et la durée en heures de la formation vaut 500
    Et la liste des codes FORMACODE de la formation vaut [44067]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation éligible à la RFF
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Une formation, un emploi - individuel» n'est pas proposé


Scénario: Une formation, un emploi - individuel avec un racine formacode
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Normandie»
    Et la durée en heures de la formation vaut 500
    Et la liste des domaines FORMACODE de la formation vaut [440]
    Et la liste des codes ROME de la formation vaut [«G1204»]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation éligible à la RFF
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Une formation, un emploi - individuel» n'est pas proposé


Scénario: Cas nominal Une formation, un emploi - collectif
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Normandie»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'intitulé de la formation vaut «CQPM tuyauteur(euse) industriel(le) (Une formation - Un emploi)»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Une formation, un emploi - collectif»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0

Scénario: Une formation, un emploi - collectif avec mauvais code financeur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Normandie»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Pôle emploi»]
    Et l'intitulé de la formation vaut «CQPM tuyauteur(euse) industriel(le) (Une formation - Un emploi)»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Une formation, un emploi - collectif» n'est pas proposé
