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


Scénario: Cas nominal AIF région
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 1800
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «AIF région»
    Alors la rémunération applicable vaut 0


Scénario: Mauvais formacode pour l'AIF région
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 1800
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et la liste des codes FORMACODE de la formation vaut [13250]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «AIF région» n'est pas proposé


Scénario: Cas nominal chèque qualification
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Le chèque qualification»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 4000


Scénario: Mauvais FORMACODE pour le chèque qualification
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la liste des codes FORMACODE de la formation vaut [15081]
    Quand je demande un calcul de financement
    Alors le financement «Le chèque qualification» n'est pas proposé


Scénario: Cas nominal chèque qualification jeune diplômé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la niveau scolaire du bénéficiaire vaut «I»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Le chèque qualification»
    Alors la rémunération applicable vaut 0


Scénario: Cas nominal chèque qualification créateur d'entreprise
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une bénéficiaire en situation de création d'entreprise nécessitant cette formation
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Le chèque qualification»
    Alors la rémunération applicable vaut 0


Scénario: Cas chèque qualification jeune diplômé et créateur d'entrprise : priorité au jeune diplomé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une bénéficiaire en situation de création d'entreprise nécessitant cette formation
    Et la niveau scolaire du bénéficiaire vaut «I»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Le chèque qualification»
    Alors la rémunération applicable vaut 0


Scénario: Cas nominal chèque qualification pour un ARE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Le chèque qualification»
    Alors la rémunération applicable vaut 1200.0
    Et la plafond de prise en charge vaut 4000


Scénario: Cas nominal chèque qualification pour un ARE createur d'entreprise
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et c'est une bénéficiaire en situation de création d'entreprise nécessitant cette formation
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Le chèque qualification»
    Alors la rémunération applicable vaut 1200.0
    Et la plafond de prise en charge vaut 0


Scénario: Cas nominal chèque qualification avec formation > 450h
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 450
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Le chèque qualification»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 4000


Scénario: Cas nominal programme régional de formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 450
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional de formation»
    Alors la rémunération applicable vaut 0


Scénario: Cas nominal AIF département
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 450
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et l'allocation du bénéficiaire vaut «revenu de solidarité active»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «AIF département»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Formation trop courte pour une  AIF département
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 80
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et l'allocation du bénéficiaire vaut «revenu de solidarité active»
    Quand je demande un calcul de financement
    Alors le financement «AIF département» n'est pas proposé


Scénario: Cas nominal actions de formation collectives département
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 450
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et les codes financeur de la formation valent [«Conseil départemental»]
    Et l'allocation du bénéficiaire vaut «revenu de solidarité active»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Actions de formation collectives département»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Pas de RSA pour le dispositif actions de formation collectives département
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 450
    Et la région du bénéficiaire vaut «Guadeloupe»
    Et la région de la formation vaut «Guadeloupe»
    Et les codes financeur de la formation valent [«Conseil départemental»]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Actions de formation collectives département» n'est pas proposé
