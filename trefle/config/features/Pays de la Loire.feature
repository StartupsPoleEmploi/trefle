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

Scénario: Action collective financée par la région avec mauvaus code financeur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200.0
    Et la région de la formation vaut «Pays de la Loire»
    Et les codes financeur de la formation valent [«Pôle emploi»]
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Alors le financement «Action collective financée par la région» n'est pas proposé

