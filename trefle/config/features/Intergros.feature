Fonctionnalité: Intergros
    Les scénarios de test d'Intergros.

Scénario: plafond financier Intergros sur formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le solde CPF du bénéficiaire vaut 100
    Et l'IDCC de l'établissement du bénéficiaire vaut 2075
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 200
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Intergros»
    Et le montant de prise en charge vaut 2000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Intergros»
    Et le montant de prise en charge vaut 2000
    Et la rémunération applicable vaut 0

Scénario: plafond horaire Intergros sur formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le solde CPF du bénéficiaire vaut 100
    Et l'IDCC de l'établissement du bénéficiaire vaut 2075
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 50
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Intergros»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Intergros»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 0


Scénario: Cas nominal d'une période de professionnalisation CDI CléA
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2075»
    Et la durée en heures de la formation vaut 100
    Et c'est une formation CléA
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Intergros»
    Et le plafond de prise en charge vaut 1800
    Et la rémunération applicable vaut 1400


Scénario: Cas nominal d'une période de professionnalisation CDI CléA FOAD
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2075»
    Et la durée en heures de la formation vaut 100
    Et c'est une formation CléA
    Et c'est une formation ouverte à distance
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Intergros»
    Et le plafond de prise en charge vaut 1000
    Et la rémunération applicable vaut 1400
