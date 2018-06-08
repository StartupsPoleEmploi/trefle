Fonctionnalité: AGEFOS PME
    Les scénarios de test d'AGEFOS PME.

Scénario: cas nominal d'une formation COPANEF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 70
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 1412
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 0

Scénario: plafond horaire d'une formation VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 70
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 1412
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et c'est une formation VAE
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME»
    Et le montant de prise en charge vaut 1250
    Et la rémunération vaut 0

Scénario: cas nominal d'une formation Région (Conseil régional)
    # https://labonneformation.pole-emploi.fr/annonce-formation/titre-professionnel-gestionnaire-de-paie-68434
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible région «Provence-Alpes-Côte d'Azur»
    Et la région de l'établissement du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et le prix horaire de la formation vaut 50
    Et la durée en heures de la formation vaut 910
    Et le solde CPF du bénéficiaire vaut 150
    Et l'IDCC de l'établissement du bénéficiaire vaut 567
    Et le code NAF de l'établissement du bénéficiaire vaut 3213Z
    Et la rémunération du bénéficiaire vaut 2000
    Et le type de contrat du bénéficiaire vaut CDI
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Provence Alpes Côte d'Azur»
    Et le montant de prise en charge vaut 7500
    Et la rémunération vaut 2000
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Provence Alpes Côte d'Azur»
    Et le montant de prise en charge vaut 7500
    Et la rémunération vaut 0

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=nbC2MndnGVeKYcg4TkJiTJJ3YdossmWCQ4ssllQvsssst_CC2Ps4cmG3HeNBKg83KUfBKbI3yavvGavfNyBeQBQ33Rm3Qs2ss4GoDPE9y3qd2wwfNRvYdgfZ5PhAj3hJ7A14oHAvfDLh%3D2mGE05XVk6wQG7ypQaQKI%3DZT%3DaJAyVe4MFAHsEtoBsvNkx-NmhV%3D25Fy4Ynxr3A4ZHqIGM8HXRmLyG4EMsGg8P2nF4ldob5gamYX%3DX%3DkAPP11xwxFmT0FoxPSaTWXE6OB1Mp5vUS7EyTa3-eBLeKaLHN0iVpASvNXvs96Mkx17okUtFf4KvBIPwggcQ3QwdMQSRb9SdtkVcsy3wDXba%3DT8RNlBscbGQg9iCeVN9e%3Du3XK4pga7aaKgm7_nlWFSme-Kko96ytRsz
Scénario: plafond horaire sur une formation simple
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1400
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 150
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 50
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 50
    Et le code NAF de l'établissement du bénéficiaire vaut «8891A»
    Et l'IDCC de l'établissement du bénéficiaire vaut 2395
    Et la région de l'établissement du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et ce n'est pas une formation éligible COPANEF
    Et c'est une formation éligible région «Provence-Alpes-Côte d'Azur»
    Et le niveau de sortie de la formation vaut 4.0
    Et la durée en heures de la formation vaut 805.0
    Et ce n'est pas une formation ouverte à distance
    Et ce n'est pas une formation TOEIC
    Et ce n'est pas une formation BULATS
    Et ce n'est pas une formation CACES
    Et ce n'est pas une formation BEC
    Et ce n'est pas un bilan de compétences
    Et ce n'est pas un permis B
    Et la durée en mois de la formation vaut 6
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Provence Alpes Côte d'Azur»
    Et le plafond de prise en charge vaut 7500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Provence Alpes Côte d'Azur»
    Et le plafond de prise en charge vaut 7500
    Et la rémunération vaut 0

Scénario: Agence Agefomat sur IDCC
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 70
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut 1404
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME établissement Agefomat»
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME établissement Agefomat»

Scénario: Agence Agefomat sur NAF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et c'est une formation éligible COPANEF
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 70
    Et le solde CPF du bénéficiaire vaut 50
    Et l'IDCC de l'établissement du bénéficiaire vaut «1404»
    Et le code NAF de l'établissement du bénéficiaire vaut «0162Z»
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut CDI
    Et l'OPCA de l'établissement du bénéficiaire vaut «AGEFOS PME»
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME établissement Agefomat»
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME établissement Agefomat»

# https://labonneformation.beta.pole-emploi.fr/engager-les-demarches?a=SW2dO3MqGVeKYcg4TkJiTImFcDassmdCQ4ssllQysssst_CCkPs4cLack2aK10K1vucc74N4g8HeNfKsyQssaGvV8ByIOi2Ras3oGBk3nEZJSd3qrpBVIMqLA73rHbNYFDasQhwwve00VIm46LKYDcmlnsAGvKKwmJ4qF1Q6NTeH%3DfomQsQNca5jj7UjBYsQIRYWXVdNfe4fFsDXADYFguSnQcHQmodsms%3D2Ux7DnBtvsddtyqgkAoBhWhpYQ1-aIiF-GUFg8PeZP4r9NW8A1iXIpF-dp04SLkeFyRDWb2AY_vK5OCedQ1U-vrmutXiGH7JUYj14rM6_qEp4Idpxu1h9fLEnd-s8rmstg9BB1ZNKf9ppe-Pd-5siROT_rnNr0RfmmBMyFpsz
Scénario: période de professionnalisation + CPF
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1500
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 150
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 12
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 12
    Et le code NAF de l'établissement du bénéficiaire vaut «8891A»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2395»
    Et la région de l'établissement du bénéficiaire vaut «Provence-Alpes-Côte d'Azur»
    Et les codes financeur de la formation vaut [4]
    Et ce n'est pas une formation éligible COPANEF
    Et c'est une formation éligible région «Provence-Alpes-Côte d'Azur»
    Et la régions éligibles COPAREF vaut [93]
    Et la liste des codes FORMACODE de la formation vaut [44028]
    Et la liste des domaines FORMACODE de la formation vaut [440]
    Et la liste des codes CERTIFINFO de la formation vaut [30958]
    Et la durée en heures de la formation vaut 805
    Et la liste des codes CPF de la formation vaut [18082,161236,157711]
    Et les codes NAF CPNE éligibles vaut [8810A,8559B,8891A,8810B,9609Z,8622A,8622C,8899A,8621Z,7830Z,8899B]
    Et le niveau de sortie de la formation vaut 4
    Et c'est une formation qualifiante
    Et la durée en mois de la formation vaut 6
    Et la durée en semaines de la formation vaut 28
    Et la durée hebdomadaire de la formation vaut 29
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Provence Alpes Côte d'Azur»
    Et le plafond de prise en charge vaut 7500
    Et la rémunération vaut 1500
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Provence Alpes Côte d'Azur»
    Et le plafond de prise en charge vaut 7500
    Et la rémunération vaut 0
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «AGEFOS PME Provence Alpes Côte d'Azur»
    Et le plafond de prise en charge vaut 7365.75
    Et la rémunération vaut 1500
