Fonctionnalité: Afdas
    Cas d'usage dédiés à Afdas.

Scénario: cas nominal d'un intermittent
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et le type de contrat du bénéficiaire est «intermittent»
    Et le prix horaire de la formation vaut 15
    # TODO: should we always point to Afdas when contrat == intermittent?
    Et l'IDCC de l'établissement du bénéficiaire vaut 5567
    Et les codes financeur de la formation valent [0]
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CIF intermittents hors temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 7500
    Et la rémunération applicable vaut 1400

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
    Et le montant de prise en charge vaut 7000
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 7000
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
    Et le montant de prise en charge vaut 3500
    Et la rémunération applicable vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le montant de prise en charge vaut 3500
    Et la rémunération applicable vaut 0


Scénario: Cas nominal d'un plan de formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «5567»
    Et la durée en heures de la formation vaut 100
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Plan de formation sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 2500
    Et la rémunération applicable vaut 1400


Scénario: Cas d'un plan de formation avec niveau de sortie II
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «5567»
    Et la durée en heures de la formation vaut 100
    Et le niveau de sortie de la formation vaut «II»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Plan de formation sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 4000
    Et la rémunération applicable vaut 1400


Scénario: Cas d'un plan de formation avec niveau de sortie I
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «5567»
    Et la durée en heures de la formation vaut 100
    Et le niveau de sortie de la formation vaut «II»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Plan de formation sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 4000
    Et la rémunération applicable vaut 1400


Scénario: Pas de plan de formation avec le niveau de sortie III
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «5567»
    Et la durée en heures de la formation vaut 100
    Et le niveau de sortie de la formation vaut «III»
    Quand je demande un calcul de financement
    Alors le financement «Plan de formation sur son temps de travail» n'est pas proposé


Scénario: Cas d'une période de professionnalisation CDI VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «5567»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 2500
    Et la rémunération applicable vaut 1400


Scénario: Pas de période de professionnalisation pour un CDD
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDD»
    Et l'IDCC de l'établissement du bénéficiaire vaut «5567»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Alors le financement «Période de professionnalisation sur son temps de travail» n'est pas proposé

Scénario: Période de professionnalisation avec entrées-sorties permantentes
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1600
    Et le solde CPF du bénéficiaire vaut 150
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «716»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «75056»
    Et le âge du bénéficiaire vaut 40
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et la durée en heures de la formation vaut 241
    Et c'est une formation ouverte à distance
    Et c'est une formation certifiante
    Et c'est une formation à entrées-sorties permanentes
    Et la durée en semaines de la formation vaut 101
    Et la durée en mois de la formation vaut 23
    Et la durée hebdomadaire de la formation vaut 2
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 9640
    Et la rémunération applicable vaut 1600


Scénario: VAE-Plan de professionnalisation AFDAS
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1000
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2642»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «92064»
    Et le âge du bénéficiaire vaut 31
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et la liste des codes FORMACODE de la formation vaut [15064,44591]
    Et la liste des domaines FORMACODE de la formation vaut [445,150]
    Et le code CERTIFINFO de la formation vaut 83899
    Et la durée en heures de la formation vaut 24
    Et c'est une formation certifiante
    Et c'est une formation à entrées-sorties permanentes
    Et la durée en semaines de la formation vaut 105
    Et la durée en mois de la formation vaut 24
    Et la durée hebdomadaire de la formation vaut 0
    Et c'est une formation VAE
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 2500
    Et la rémunération applicable vaut 1000
