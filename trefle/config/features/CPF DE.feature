Fonctionnalité: CPF demandeur d'emploi

Scénario: Cas nominal CPF COPANEF demandeur d'emploi
    Soit un bénéficiaire et une formation
    Et l'âge du bénéficiaire est 42
    Et c'est un demandeur d'emploi
    Et c'est une formation éligible CPF
    Et le solde CPF du bénéficiaire vaut 100
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Compte Personnel de Formation (CPF)»
    Alors le plafond de prise en charge vaut 100
    Et la rémunération applicable vaut 0

Scénario: Cas nominal CPF COPANEF demandeur d'emploi avec plafond
    Soit un bénéficiaire et une formation
    Et l'âge du bénéficiaire est 42
    Et c'est un demandeur d'emploi
    Et c'est une formation éligible CPF
    Et le solde CPF du bénéficiaire vaut 2000
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Compte Personnel de Formation (CPF)»
    Alors le plafond de prise en charge vaut 1800
    Et la rémunération applicable vaut 0

Scénario: Cas nominal CPF COPAREF demandeur d'emploi
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le solde CPF du bénéficiaire vaut 100
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire est «Île-de-France»
    Et c'est une formation éligible région «Île-de-France»
    Et c'est une formation éligible CPF
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Compte Personnel de Formation (CPF)»
    Alors le plafond de prise en charge vaut 100
    Et la rémunération applicable vaut 0

Scénario: Cas nominal CPF si le solde n'est pas connu
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire est «Île-de-France»
    Et c'est une formation éligible région «Île-de-France»
    Et c'est une formation éligible CPF
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Compte Personnel de Formation (CPF)»
    Alors la rémunération applicable vaut 0
