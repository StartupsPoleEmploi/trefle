Fonctionnalité: INTERGROS
    Les scénarios de test d'INTERGROS.

Scénario: plafond financier INTERGROS sur formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le compte CPF du bénéficiaire vaut 100
    Et l'IDCC de l'établissement du bénéficiaire vaut 2075
    Et la rémunération du bénéficiaire vaut 1400
    Et le taux horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 200
    Et le code CPF de la formation vaut 200
    Quand je demande un calcul de financement
    Et je sélectionne le financement "scenarios.cpf.pendant_temps_de_travail"
    Alors l'organisme tutelle est INTERGROS
    Et le montant de prise en charge vaut 2000
    Et la rémunération vaut 1400
    Quand je sélectionne le financement "scenarios.cpf.hors_temps_de_travail"
    Alors l'organisme tutelle est INTERGROS
    Et le montant de prise en charge vaut 2000
    Et la rémunération vaut 0

Scénario: plafond horaire INTERGROS sur formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le compte CPF du bénéficiaire vaut 100
    Et l'IDCC de l'établissement du bénéficiaire vaut 2075
    Et la rémunération du bénéficiaire vaut 1400
    Et le taux horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 50
    Et le code CPF de la formation vaut 200
    Quand je demande un calcul de financement
    Et je sélectionne le financement "scenarios.cpf.pendant_temps_de_travail"
    Alors l'organisme tutelle est INTERGROS
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 1400
    Quand je sélectionne le financement "scenarios.cpf.hors_temps_de_travail"
    Alors l'organisme tutelle est INTERGROS
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 0
