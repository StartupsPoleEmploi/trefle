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


Scénario: Cas nominale Formations sanitaire et social d'aide-soignant ou d'auxiliaire de puériculture région Île-de-France
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Île-de-France»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région du bénéficiaire vaut «Île-de-France»
    Et la liste des codes FORMACODE de la formation vaut [43436]
    Et c'est une bénéficiaire ayant achevé un contrat aidé
    Et c'est une formation certifiante
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations sanitaire et social d'aide-soignant ou d'auxiliaire de puériculture région Île-de-France»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Formations sanitaire et social d'aide-soignant ou d'auxiliaire de puériculture région Île-de-France n'ayant pas de contrat aidé achevé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Île-de-France»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région du bénéficiaire vaut «Île-de-France»
    Et la liste des codes FORMACODE de la formation vaut [43436]
    Et c'est une formation certifiante
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Formations sanitaire et social d'aide-soignant ou d'auxiliaire de puériculture région Île-de-France» n'est pas proposé


Scénario: Cas nominal Formations sanitaire et social post-bac région Île-de-France
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Île-de-France»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région du bénéficiaire vaut «Île-de-France»
    Et la liste des codes FORMACODE de la formation vaut [44004]
    Et c'est une formation certifiante
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations sanitaire et social post-bac région Île-de-France»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Formations sanitaire et social post-bac région Île-de-France avec mauvais formacode
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Île-de-France»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région du bénéficiaire vaut «Île-de-France»
    Et c'est une formation certifiante
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Formations sanitaire et social post-bac région Île-de-France» n'est pas proposé


Scénario: Cas nominal Programme régional qualifiant compétences
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Île-de-France»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région du bénéficiaire vaut «Île-de-France»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional qualifiant compétences»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Programme régional qualifiant compétences avec mauvais formacode
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Île-de-France»
    Et la durée en heures de la formation vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région du bénéficiaire vaut «Île-de-France»
    Et le prix horaire de la formation vaut 0.0
    Et la liste des codes FORMACODE de la formation vaut [44004]
    Quand je demande un calcul de financement
    Alors le financement «Programme régional qualifiant compétences» n'est pas proposé


Scénario: Cas nominal Chéquier unique VAE Région Ile-de-France
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Île-de-France»
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Île-de-France»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la liste des codes FORMACODE de la formation vaut [15064]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Chéquier unique VAE Région Ile-de-France»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Chéquier unique VAE Région Ile-de-France avec mauvais formacode
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la région de la formation vaut «Île-de-France»
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Île-de-France»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Chéquier unique VAE Région Ile-de-France» n'est pas proposé


Scénario: Cas nominal Paris formation pour l'emploi
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la département de la formation vaut «Paris»
    Et la durée en heures de la formation vaut 500
    Et la département du bénéficiaire vaut «Paris»
    Et les codes financeur de la formation valent [«Conseil départemental»]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Paris formation pour l'emploi»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Paris formation pour l'emploi avec mauvaise localisation pour le demandeur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la département de la formation vaut «Paris»
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Île-de-France»
    Et les codes financeur de la formation valent [«Conseil départemental»]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Paris formation pour l'emploi» n'est pas proposé

Scénario: RFF
    Soit un bénéficiaire et une formation
    Et l'âge du bénéficiaire vaut 38
    Et c'est un demandeur d'emploi
    Et la date de fin de l'allocation du bénéficiaire vaut «12/12/2019»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes ROME de la formation vaut [J1506]
    Et la durée en heures de la formation vaut 4200
    Et la date de début de la formation vaut «02/09/2019»
    Et la date de fin de la formation vaut «08/07/2022»
    Et la région du bénéficiaire vaut «Île-de-France»
    Et la région de la formation vaut «Île-de-France»
    Et c'est une formation éligible à la RFF
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Programme régional qualifiant compétences»
    Alors la rémunération applicable vaut 1200.0
    Et la plafond de prise en charge vaut 0
    Et la RFF applicable vaut 652.02
    Et la date de début de la RFF applicable vaut «13/12/2019»
    Et la date de fin de la RFF applicable vaut «08/07/2022»
    Et la date de fin de la rémunération applicable vaut «12/12/2019»
