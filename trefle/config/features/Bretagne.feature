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
