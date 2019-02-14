Fonctionnalité: contrat d'apprentissage


Scénario: contrat d'apprentissage pour mineur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat d'apprentissage
    Et le âge du bénéficiaire vaut 17
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat d'apprentissage»
    Alors la rémunération applicable vaut 380.31
    Et la rémunération applicable la deuxième année vaut 562.85
    Et la rémunération applicable la troisième année vaut 806.25


Scénario: contrat d'apprentissage pour jeune de moins de 21 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat d'apprentissage
    Et le âge du bénéficiaire vaut 20
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat d'apprentissage»
    Alors la rémunération applicable vaut 623.7
    Et la rémunération applicable la deuxième année vaut 745.4
    Et la rémunération applicable la troisième année vaut 988.79


Scénario: contrat d'apprentissage pour un bénéficiaire de 21 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat d'apprentissage
    Et le âge du bénéficiaire vaut 21
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat d'apprentissage»
    Alors la rémunération applicable vaut 806.25
    Et la rémunération applicable la deuxième année vaut 927.94
    Et la rémunération applicable la troisième année vaut 1186.55


Scénario: pas de contrat d'apprentissage pour un jeune de plus de 25 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat d'apprentissage
    Et le âge du bénéficiaire vaut 30
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Normandie»
    Quand je demande un calcul de financement
    Alors le financement «Formation en alternance : contrat d'apprentissage» n'est pas proposé


Scénario: contrat d'apprentissage pour un jeune de plus de 25 ans possible en région Bretagne
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat d'apprentissage
    Et le âge du bénéficiaire vaut 30
    Et la région du bénéficiaire est «Bretagne»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat d'apprentissage»
    Alors la rémunération applicable vaut 806.25


Scénario: pas de contrat d'apprentissage pour un bénéficiaire de plus de 30 ans en région Bretagne
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat d'apprentissage
    Et le âge du bénéficiaire vaut 31
    Et la région du bénéficiaire est «Bretagne»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Alors le financement «Formation en alternance : contrat d'apprentissage» n'est pas proposé


Scénario: contrat d'apprentissage possible pour un bénéficiaire de plus de 30 ans travailleur handicapé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat d'apprentissage
    Et le âge du bénéficiaire vaut 31
    Et la région du bénéficiaire est «Bretagne»
    Et c'est un travailleur handicapé
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat d'apprentissage»
    Alors la rémunération applicable vaut 806.25


Scénario: contrat d'apprentissage possible pour un bénéficiaire de plus de 30 ans en situation de création d'entreprise
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est un contrat d'apprentissage
    Et le âge du bénéficiaire vaut 31
    Et la région du bénéficiaire est «Bretagne»
    Et c'est un bénéficiaire en situation de création d'entreprise nécessitant cette formation
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation en alternance : contrat d'apprentissage»
    Alors la rémunération applicable vaut 806.25
