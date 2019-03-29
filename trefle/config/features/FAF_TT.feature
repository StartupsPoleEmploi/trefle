Fonctionnalité: FAF.TT
    Cas d'usage de FAF.TT


Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «intérimaire»
    Et le solde CPF du bénéficiaire vaut 1000
    Et c'est une formation éligible CPF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2378
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 0


Scénario: cas d'une formation TOEIC
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «intérimaire»
    Et le solde CPF du bénéficiaire vaut 1000
    Et c'est une formation éligible CPF
    Et c'est une formation TOEIC
    Et l'IDCC de l'établissement du bénéficiaire vaut 2378
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 0


Scénario: cas d'une formation BULATS
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «intérimaire»
    Et le solde CPF du bénéficiaire vaut 1000
    Et c'est une formation éligible CPF
    Et c'est une formation BULATS
    Et l'IDCC de l'établissement du bénéficiaire vaut 2378
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 0


Scénario: cas d'une formation CACES
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «intérimaire»
    Et le solde CPF du bénéficiaire vaut 1000
    Et c'est une formation éligible CPF
    Et c'est une formation CACES
    Et l'IDCC de l'établissement du bénéficiaire vaut 2378
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 0


Scénario: cas nominal d'une formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «intérimaire»
    Et le solde CPF du bénéficiaire vaut 1000
    Et c'est une formation éligible CPF
    Et c'est une formation VAE
    Et l'IDCC de l'établissement du bénéficiaire vaut 2378
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 250
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 250
    Et la rémunération applicable vaut 0


Scénario: plafond de prix horaire sur une formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «intérimaire»
    Et le solde CPF du bénéficiaire vaut 600
    Et c'est une formation éligible CPF
    Et c'est une formation VAE
    Et l'IDCC de l'établissement du bénéficiaire vaut 2378
    Et le prix horaire de la formation vaut 80
    Et la durée en heures de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 600
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 600
    Et la rémunération applicable vaut 0


Scénario: plafond horaire sur une formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «intérimaire»
    Et le solde CPF du bénéficiaire vaut 1000
    Et c'est une formation éligible CPF
    Et c'est une formation VAE
    Et l'IDCC de l'établissement du bénéficiaire vaut 2378
    Et le prix horaire de la formation vaut 20
    Et la durée en heures de la formation vaut 50
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 0


Scénario: cas nominal d'un CPF CPNE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «intérimaire»
    Et le solde CPF du bénéficiaire vaut 1000
    Et ce n'est pas une formation éligible CPF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2378
    Et le code NAF de l'établissement du bénéficiaire vaut «6910Z»
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Et les codes NAF CPNE éligibles valent [«6910Z»]
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «FAF.TT»
    Et le montant de prise en charge vaut 1000
    Et la rémunération applicable vaut 0
