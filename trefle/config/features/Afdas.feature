Fonctionnalité: Afdas
    Cas d'usage dédiés à Afdas.

Scénario: plafond prix horaire d'une formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 125
    Et la durée en heures de la formation vaut 70
    Et le solde CPF du bénéficiaire vaut 100
    Et l'IDCC de l'établissement du bénéficiaire vaut 5567
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 100
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 100
    Et la rémunération applicable vaut 0

Scénario: plafond horaire d'une formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 50
    Et la durée en heures de la formation vaut 70
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 5567
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 50
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 50
    Et la rémunération applicable vaut 0


Scénario: Cas nominal d'un plan de développement des compétences VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «5567»
    Et la durée en heures de la formation vaut 100
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Plan de développement des compétences sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 2500
    Et la rémunération applicable vaut 1400


Scénario: Cas d'un plan de développement des compétences avec niveau de sortie II
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «5567»
    Et la durée en heures de la formation vaut 100
    Et le niveau de sortie de la formation vaut «II»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Plan de développement des compétences sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 4000
    Et la rémunération applicable vaut 1400


Scénario: Cas d'un plan de développement des compétences avec niveau de sortie I
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «5567»
    Et la durée en heures de la formation vaut 100
    Et le niveau de sortie de la formation vaut «II»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Plan de développement des compétences sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 4000
    Et la rémunération applicable vaut 1400


Scénario: Pas de plan de développement des compétences avec le niveau de sortie III
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «5567»
    Et la durée en heures de la formation vaut 100
    Et le niveau de sortie de la formation vaut «III»
    Quand je demande un calcul de financement
    Alors le financement «Plan de développement des compétences sur son temps de travail» n'est pas proposé


