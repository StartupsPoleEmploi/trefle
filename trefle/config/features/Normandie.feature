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

Scénario: La rémunération applicable pour un TH vaut 644,17
    Soit un bénéficiaire et une formation
    Et l'âge du bénéficiaire vaut 39
    Et c'est un demandeur d'emploi
    Et la date de fin de l'allocation du bénéficiaire vaut «15/05/2020»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la durée en heures de la formation vaut 735
    Et le nombre d'heures en entreprise vaut 140
    Et le nombre d'heures en centre vaut 595
    Et la code AIS de la formation vaut «Certification»
    Et la date de début de la formation vaut «30/09/2019»
    Et la date de fin de la formation vaut «06/03/2020»
    Et c'est une formation certifiante
    Et la région de la formation vaut «Normandie»
    Et la région du bénéficiaire vaut «Normandie»
    Et c'est une formation RNCP
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 600.0
    Et c'est un travailleur handicapé
    Et c'est un bénéficiaire qui a déjà travaillé six mois sur une période de douze mois
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Programme de formations collectives financées par le Conseil régional de Normandie»
    Alors la rémunération applicable vaut 644.17
    Et la plafond de prise en charge vaut 0
    Et la date de fin de la rémunération applicable vaut «15/05/2020»

Scénario: Variante pour le CPF
    Soit un bénéficiaire et une formation
    Et l'âge du bénéficiaire vaut 29
    Et c'est un demandeur d'emploi
    Et la date de fin de l'allocation du bénéficiaire vaut «14/08/2021»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la durée en heures de la formation vaut 735
    Et c'est une formation éligible CPF
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Normandie»
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 600.0
    Et c'est un travailleur handicapé
    Et c'est un bénéficiaire qui a déjà travaillé douze mois sur une période de vingt-quatre mois
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Compte Personnel de Formation (CPF)»
    Alors la rémunération applicable vaut 616.2
    Et la date de fin de la rémunération applicable vaut «14/08/2021»
    Quand je sélectionne le financement «Programme de formations collectives financées par le Conseil régional de Normandie»
    Alors la rémunération applicable vaut 644.17
    Et la date de fin de la rémunération applicable vaut «14/08/2021»
    Quand je sélectionne le financement «Aide individuelle à la Formation financée par Pôle emploi et l'Agefiph»
    Alors la rémunération applicable vaut 644.17
