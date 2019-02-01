Fonctionnalité: OPCABAIA
    Les cas d'usages d'OPCABAIA.

Scénario: CPF avec IDCC 1672
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 10000
    Et la rémunération du bénéficiaire vaut 1500
    Et le âge du bénéficiaire vaut 28
    Et l'expérience professionnelle du bénéficiaire vaut 28
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 6
    Et le code NAF de l'établissement du bénéficiaire vaut «6512Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1672»
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et ce n'est pas une formation éligible COPANEF
    Et c'est une formation éligible région «Île-de-France»
    Et le niveau de sortie de la formation vaut «III»
    Et la durée en heures de la formation vaut 1568.0
    Et c'est une formation certifiante
    Et la durée en mois de la formation vaut 10
    Et la durée en semaines de la formation vaut 43
    Et la durée hebdomadaire de la formation vaut 36
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «OPCABAIA»
    Et le plafond de prise en charge vaut 10000
    Et la rémunération applicable vaut 1500
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «OPCABAIA»
    Et le plafond de prise en charge vaut 10000
    Et la rémunération applicable vaut 0
