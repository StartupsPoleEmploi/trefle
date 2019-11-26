Fonctionnalité: Bretagne

Scénario: cas nominal Chèque formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 100
    Et la région du bénéficiaire vaut «Bretagne»
    Et la région de la formation vaut «Bretagne»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Chèque formation»
    Alors le plafond de prise en charge vaut 3050

Scénario: Chèque formation pour travailleur handicapé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 100
    Et la région du bénéficiaire vaut «Bretagne»
    Et la région de la formation vaut «Bretagne»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est un travailleur handicapé
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Chèque formation»
    Alors le plafond de prise en charge vaut 9150

Scénario: Chèque formation pour un bénéficiaire non qualifié
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 100
    Et la région du bénéficiaire vaut «Bretagne»
    Et la région de la formation vaut «Bretagne»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le niveau scolaire du bénéficiaire vaut «V»
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Chèque formation»
    Alors le plafond de prise en charge vaut 4500

Scénario: Chèque formation exclu pour formation FIMO
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 100
    Et la région du bénéficiaire vaut «Bretagne»
    Et la région de la formation vaut «Bretagne»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation FIMO
    Quand je demande un calcul de financement
    Alors le financement «Chèque formation» n'est pas proposé

Scénario: Chèque formation exclu pour formation hors Bretagne
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 100
    Et la région du bénéficiaire vaut «Bretagne»
    Et la région de la formation vaut «Normandie»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Chèque formation» n'est pas proposé

Scénario: Chèque formation exclu pour bénéficiaire hors Bretagne
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 100
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Bretagne»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Chèque formation» n'est pas proposé

Scénario: Cas nominal Formations du domaine sanitaire et social
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 100
    Et la région du bénéficiaire vaut «Bretagne»
    Et la région de la formation vaut «Bretagne»
    Et les codes financeur de la formation vaut [2]
    Et la liste des codes FORMACODE de la formation vaut [31815]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Formations du domaine sanitaire et social»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0

Scénario: Formations du domaine sanitaire et social exclu pour mauvais code financeur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 100
    Et la région du bénéficiaire vaut «Bretagne»
    Et la région de la formation vaut «Bretagne»
    Et les codes financeur de la formation vaut [4]
    Et la liste des codes FORMACODE de la formation vaut [31815]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Formations du domaine sanitaire et social» n'est pas proposé

Scénario: Cas nominal Programme Bretagne Formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la montant de l'allocation du bénéficiaire vaut 1200.0
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la région du bénéficiaire vaut «Bretagne»
    Et la durée en heures de la formation vaut 100
    Et la région de la formation vaut «Bretagne»
    Et les codes financeur de la formation vaut [2]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme Bretagne Formation»
    Alors la rémunération applicable vaut 1200.0
    Et la plafond de prise en charge vaut 0

Scénario: Programme Bretagne Formation avec code financeur non pris en charge
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la montant de l'allocation du bénéficiaire vaut 1200.0
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la région du bénéficiaire vaut «Bretagne»
    Et la durée en heures de la formation vaut 100
    Et la région de la formation vaut «Bretagne»
    Et les codes financeur de la formation vaut [4]
    Quand je demande un calcul de financement
    Alors le financement «Programme Bretagne Formation» n'est pas proposé
