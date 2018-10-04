Fonctionnalité: Hauts-de-France

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation éligible COPAREF de la région du bénéficiaire
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors le plafond de prise en charge vaut 2500


Scénario: Mauvais code CERTIFINFO pour un financement AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et le code CERTIFINFO de la formation vaut 54913
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation éligible COPAREF de la région du bénéficiaire
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: Cas nominal chèque pass formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Le chèque pass formation»
    Alors le plafond de prise en charge vaut 2250


Scénario: Formation permis B non eligibel pour le chèque pass formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est un permis B
    Quand je demande un calcul de financement
    Alors le financement «Le chèque pass formation» n'est pas proposé


Scénario: Cas nominal formation sanitaire et social
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et la liste des codes FORMACODE de la formation vaut [43441]
    Et la région de la formation vaut «Hauts-de-France»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Sanitaire et social»
    Alors la rémunération applicable vaut 0


Scénario: Pas le bon formacode pour formation sanitaire et social
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et la région de la formation vaut «Hauts-de-France»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Alors le financement «Sanitaire et social» n'est pas proposé


Scénario: Cas nominal programme régional de formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et la région de la formation vaut «Hauts-de-France»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional de formation»
    Alors la rémunération applicable vaut 0


Scénario: la formation n'est pas en Hauts-de-France pour  programme régional de formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Alors le financement «Programme régional de formation» n'est pas proposé


Scénario: Cas nominal pass emploi
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et la région de la formation vaut «Hauts-de-France»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Pass emploi»
    Alors le plafond de prise en charge vaut 2250


Scénario: Durée de la formation trop grande pour un pass emploi
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 500
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et la région de la formation vaut «Hauts-de-France»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Pass emploi» n'est pas proposé
