Fonctionnalité: ACTALIANS
    Les scénarios de test d'ACTALIANS.

Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le compte CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et la rémunération du bénéficiaire vaut 1400
    Quand je demande un calcul de financement
    Et je sélectionne le financement "scenarios.cpf.pendant_temps_de_travail"
    Alors l'organisme tutelle est ACTALIANS
    Et le montant de prise en charge vaut 3000
    Et la rémunération vaut 1400
    Quand je sélectionne le financement "scenarios.cpf.hors_temps_de_travail"
    Alors l'organisme tutelle est ACTALIANS
    Et le montant de prise en charge vaut 3000
    Et la rémunération vaut 0
