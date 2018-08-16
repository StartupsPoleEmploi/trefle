Fonctionnalité: CPF demandeur d'emploi

Scénario: Cas nominal CPF COPANEF demandeur d'emploi
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et c'est une formation éligible COPANEF
    Et le solde CPF du bénéficiaire vaut 100
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF demandeur d'emploi»
    Alors le plafond de prise en charge vaut 900
    Et la rémunération applicable vaut 0

Scénario: Cas nominal CPF COPAREF demandeur d'emploi
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le solde CPF du bénéficiaire vaut 100
    Et la durée en heures de la formation vaut 120
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et la région du bénéficiaire est «Île-de-France»
    Et c'est une formation éligible région «Île-de-France»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF demandeur d'emploi»
    Alors le plafond de prise en charge vaut 900
    Et la rémunération applicable vaut 0
