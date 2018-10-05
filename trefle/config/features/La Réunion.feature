Fonctionnalité: La Réunion

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le âge du bénéficiaire vaut 30
    Et la région du bénéficiaire vaut «La Réunion»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors le plafond de prise en charge vaut 2600
    Et la rémunération applicable vaut 401.09


Scénario: Permis CE exclu de l'AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «La Réunion»
    Et le code CERTIFINFO de la formation vaut 81306
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: cas nominal chèque formation réussite
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «La Réunion»
    Et la région de la formation vaut «La Réunion»
    Et l'allocation du bénéficiaire vaut «revenu de solidarité active»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Chèque formation réussite»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 3000


Scénario:  pas de rsa pour une formation chèque formation réussite
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «La Réunion»
    Et la région de la formation vaut «La Réunion»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Chèque formation réussite» n'est pas proposé


Scénario: cas nominal chèque formation réussite VAE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «La Réunion»
    Et la région de la formation vaut «La Réunion»
    Et l'allocation du bénéficiaire vaut «revenu de solidarité active»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Chèque formation réussite VAE»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 3000


Scénario: ce n'est pas une VAE pour un chèque formation réussite VAE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «La Réunion»
    Et la région de la formation vaut «La Réunion»
    Et l'allocation du bénéficiaire vaut «revenu de solidarité active»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Chèque formation réussite VAE» n'est pas proposé


Scénario:  pas de rsa pour une formation chèque formation réussite VAE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «La Réunion»
    Et la région de la formation vaut «La Réunion»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Alors le financement «Chèque formation réussite VAE» n'est pas proposé


Scénario: cas nominal chèque formation réussite - langue étrangère
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «La Réunion»
    Et la région de la formation vaut «La Réunion»
    Et la liste des codes FORMACODE de la formation vaut [15254]
    Et l'allocation du bénéficiaire vaut «revenu de solidarité active»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Chèque formation réussite - langue étrangère»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 3000


Scénario: c'est un contrat d'apprentissage donc pas de chèque formation réussite - langue étrangère
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «La Réunion»
    Et la région de la formation vaut «La Réunion»
    Et la liste des codes FORMACODE de la formation vaut [15254]
    Et l'allocation du bénéficiaire vaut «revenu de solidarité active»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est un contrat d'apprentissage
    Quand je demande un calcul de financement
    Alors le financement «Chèque formation réussite - langue étrangère» n'est pas proposé


