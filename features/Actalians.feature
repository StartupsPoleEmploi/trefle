Fonctionnalité: Actalians
    Les scénarios de test d'Actalians.

Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 0


Scénario: formation COPAREF IDF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible région «Île-de-France»
    Et ce n'est pas une formation éligible COPANEF
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et le prix horaire de la formation vaut 50
    Et la durée en heures de la formation vaut 910
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et la rémunération du bénéficiaire vaut 1600
    Et le type de contrat du bénéficiaire vaut CDI
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 2500
    Et la rémunération applicable vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 2500
    Et la rémunération applicable vaut 0


Scénario: formation COPAREF IDF sur code INSEE commune
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible région «Île-de-France»
    Et ce n'est pas une formation éligible COPANEF
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «93031»
    Et le prix horaire de la formation vaut 50
    Et la durée en heures de la formation vaut 910
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et la rémunération du bénéficiaire vaut 1600
    Et le type de contrat du bénéficiaire vaut CDI
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 2500
    Et la rémunération applicable vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 2500
    Et la rémunération applicable vaut 0


Scénario: formation VAE avec prix horaire supérieur au plafond
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 25
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et c'est une formation VAE
    Et la durée en heures de la formation vaut 50
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 600
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 600
    Et la rémunération applicable vaut 0


Scénario: formation CleA avec prix horaire supérieur au plafond
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 30
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et c'est une formation CléA
    Et la durée en heures de la formation vaut 50
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1350
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1350
    Et la rémunération applicable vaut 0


Scénario: cas nominal d'une formation CPNE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et le solde CPF du bénéficiaire vaut 50
    Et ce n'est pas une formation éligible COPANEF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Et le code NAF de l'établissement du bénéficiaire vaut 6910Z
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Et les codes NAF CPNE éligibles valent [6910Z]
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le montant de prise en charge vaut 1250
    Et la rémunération applicable vaut 0


Scénario: Cas nominal d'une période de professionnalisation CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2706»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Actalians»
    Et le plafond de prise en charge vaut 915
    Et la rémunération applicable vaut 1400
