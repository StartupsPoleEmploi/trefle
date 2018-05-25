Fonctionnalité: Tests génériques
    Les scénarios de test génériques.

Scénario: le bénéficiaire n'a pas d'heures CPF sur son compte
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 0
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé

Scénario: le bénéficiaire n'est pas de droit privé
    Soit un bénéficiaire et une formation
    Et ce n'est pas un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 0
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé

Scénario: cas d'une formation CPF avec solde CPF null
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 0
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé

Scénario: cas d'une formation CPF sans solde CPF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé
