Fonctionnalité: Tests génériques
    Les scénarios de test génériques.

Scénario: le bénéficiaire n'a pas d'heures CPF sur son compte
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le solde CPF du bénéficiaire vaut 0
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et la rémunération du bénéficiaire vaut 1400
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé

Scénario: le bénéficiaire n'est pas de droit privé
    Soit un bénéficiaire et une formation
    Et ce n'est pas un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le solde CPF du bénéficiaire vaut 0
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et la rémunération du bénéficiaire vaut 1400
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé
