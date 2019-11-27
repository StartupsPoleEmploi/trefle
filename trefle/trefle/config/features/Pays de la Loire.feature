Fonctionnalité: Pays de la Loire

Scénario: Cas nominal Action collective financée par la région
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Et la région de la formation vaut «Pays de la Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action collective financée par la région»
    Alors le plafond de prise en charge vaut 0

Scénario: Action collective financée par la région avec ARE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la région de la formation vaut «Pays de la Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action collective financée par la région»
    Alors la rémunération applicable vaut 1200.0
    Et la plafond de prise en charge vaut 0

Scénario: Action collective financée par la région avec niveau de sortie > 3
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la région de la formation vaut «Pays de la Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le niveau de sortie de la formation vaut «V»
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action collective financée par la région»
    Alors la rémunération applicable vaut 1200.0
    Et la plafond de prise en charge vaut 0

Scénario: Action collective financée par la région avec mauvais code financeur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Et la région de la formation vaut «Pays de la Loire»
    Et les codes financeur de la formation valent [«Pôle emploi»]
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Alors le financement «Action collective financée par la région» n'est pas proposé

Scénario: Cas nominal Action collective sanitaire et social financée par la région et Pôle emploi
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Et la région de la formation vaut «Pays de la Loire»
    Et la liste des codes FORMACODE de la formation vaut [43436]
    Et les codes financeur de la formation valent [«Conseil régional»,«Pôle emploi»]
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action collective sanitaire et social financée par la région et Pôle Emploi»
    Alors le plafond de prise en charge vaut 0

Scénario: Cas Action collective sanitaire et social financée par la région et Pôle emploi sans code financeur Pôle emploi
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Et la région de la formation vaut «Pays de la Loire»
    Et la liste des codes FORMACODE de la formation vaut [43436]
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Alors le financement «Action collective sanitaire et social financée par la région et Pôle Emploi» n'est pas proposé

Scénario: Cas Action collective sanitaire et social financée par la région et Pôle emploi sans formacode
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Et la région de la formation vaut «Pays de la Loire»
    Et les codes financeur de la formation valent [«Conseil régional»,«Pôle emploi»]
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Alors le financement «Action collective sanitaire et social financée par la région et Pôle Emploi» n'est pas proposé

Scénario: Cas nominal Parcours TPME vers l'emploi
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1800.0
    Et la région de la formation vaut «Pays de la Loire»
    Et les codes financeur de la formation valent [«Conseil régional»]
    #Et les codes financeur de la formation valent [«Conseil régional»,«Pôle emploi»]
    Et la durée en heures de la formation vaut 500
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Parcours TPME vers l'emploi»
    Alors la rémunération applicable vaut 0

Scénario: Cas nominal Parcours TPME vers l'emploi avec ARE inférieur à 80% du SMIC
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 500
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Pays de la Loire»
    #Et les codes financeur de la formation valent [«Conseil régional»,«Pôle emploi»]
    Et la durée en heures de la formation vaut 500
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Parcours TPME vers l'emploi»
    Alors la rémunération applicable vaut 616.2

Scénario: Cas nominal Parcours TPME vers l'emploi avec ARE supérieur à 80% du SMIC
    Soit un bénéficiaire et une formation
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1600
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Pays de la Loire»
    #Et les codes financeur de la formation valent [«Conseil régional»,«Pôle emploi»]
    Et la durée en heures de la formation vaut 500
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Parcours TPME vers l'emploi»
    Alors la rémunération applicable vaut 1216.98

