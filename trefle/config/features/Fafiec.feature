Fonctionnalité: Fafiec
    Les scénarios de test Fafiec.

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=3SCnbSnMGVeKYcg4TkJiTCwdeZossHPCQRssoscl_RMsssRlSOOjaso9rG3HeeKPmIdehoxkciu8uGysyiiGJc4cio2aco2QfRdKbK5KYssOBRKmFtV3yDi50uUfy0gVdJ4_mnZxJtkN6WwhLGso-gBaDDrqGK-h%3DTMs7BskBcAcYWeE4VsD5Qh-IQj2G3wD7cYFpF5X2Q7UJ%3DaIOjmJp5UvEsS87aKN9QZe-GEM1sH6QrsC8055q1SsCqjVlgrjoyO_O_S7ZmV5TfCC-mpwjo5NybwQcxMTSJ9-3xUXEHekGX7UvvdXEU9phkJDNAR1aqQh5sTbhiKvfvfxwErevhXos4AgaWp9gorqy_XsFN41XFy_naSVAvxu6fA2ATCccMNc_GmyT1U3ZHTkiM%3DLQsW2vfAds1sdiHR_w_EFk7M7ofWnuYpQ
Scénario: cas nominal Fafiec
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1600
    Et le solde CPF du bénéficiaire vaut 120
    Et le type de contrat du bénéficiaire vaut «CDD»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 48
    Et le nombre de mois travaillés par le bénéficiaire dans la dernière année vaut 12
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 12
    Et le code NAF de l'établissement du bénéficiaire vaut «6202A»
    Et l'IDCC de l'établissement du bénéficiaire vaut 1486
    Et c'est une formation éligible région «Île-de-France»
    Et c'est une formation éligible COPANEF
    Et la durée en heures de la formation vaut 1384
    Et la liste des codes FORMACODE de la formation vaut [31094,31067,31084]
    Et le niveau de sortie de la formation vaut «III»
    Et le code CERTIFINFO de la formation vaut 76575
    Et la liste des domaines FORMACODE de la formation vaut [310]
    Et ce n'est pas une formation ouverte à distance
    Et ce n'est pas une formation TOEIC
    Et ce n'est pas une formation BULATS
    Et ce n'est pas une formation CACES
    Et ce n'est pas une formation BEC
    Et ce n'est pas un bilan de compétences
    Et ce n'est pas un permis B
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Fafiec»
    Et le plafond de prise en charge vaut 9600
    Et la rémunération applicable vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Fafiec»
    Et le plafond de prise en charge vaut 9600
    Et la rémunération applicable vaut 0


Scénario: CPF sur CPNE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1600
    Et le solde CPF du bénéficiaire vaut 120
    Et le type de contrat du bénéficiaire vaut «CDD»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 48
    Et le nombre de mois travaillés par le bénéficiaire dans la dernière année vaut 12
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 12
    Et le code NAF de l'établissement du bénéficiaire vaut «6202A»
    Et l'IDCC de l'établissement du bénéficiaire vaut 1486
    Et ce n'est pas une formation éligible COPANEF
    Et les codes NAF CPNE éligibles valent [«6202A»]
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Fafiec»
    Et le plafond de prise en charge vaut 8000
    Et la rémunération applicable vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Fafiec»
    Et le plafond de prise en charge vaut 8000
    Et la rémunération applicable vaut 0


Scénario: Cas nominal d'une période de professionnalisation CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1486»
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Fafiec»
    Et le plafond de prise en charge vaut 15000
    Et la rémunération applicable vaut 1400


Scénario: Période de professionnalisation CDI sur formation en langues
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1486»
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Et la liste des domaines FORMACODE de la formation vaut [152]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Fafiec»
    Et le plafond de prise en charge vaut 10000
    Et la rémunération applicable vaut 1400