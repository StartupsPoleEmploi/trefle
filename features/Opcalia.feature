Fonctionnalité: Opcalia
    Les scénarios de test d'Opcalia.

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=%3Duq5OO3nGVeKYcg4TkJiTTtWpaMssmbCQ4ssllQwsssGt_CC2Ps47LY9YocByPHcuyvG49K4K3IbNG33JyQss3RIoeWKOius46BNsckmmhHSfqtiFe_S%3D6LkIyyw61DvxeiyygSbunQBRNIIUMHUVYkaGmHRQMRVgo-AcA4Nc7jKyZKw4MgymE7DecmWt2%3DgmQJVmZGf660U%3DT739ZE-gV2ExIdB7LdNotAoGfIoRubOgEQUFLtBa-UxZeDIvXYhDGyqpHdCI7Kq1pNWp3hVY4XbqwN-EFBjWyjIpt%3DQp0%3DsZmAUpv2V0JKoEmmMwSoUUiU-ThyfIi8AAMDoVGk-vL7RIgjpI11%3DyFR-3tf2mT_g3-xSC1my7QgEEwJg32PZR94OdBQAUGZY1mm3uAFlrnNr0RfmYC--pWsz#
Scénario: CPF intermittent
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1400
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 150
    Et le type de contrat du bénéficiaire vaut «intermittent»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 24
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 12
    Et le code NAF de l'établissement du bénéficiaire vaut «1411Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut 247
    Et la région de l'établissement du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et c'est une formation éligible COPANEF
    Et le niveau de sortie de la formation vaut 5.0
    Et la durée en heures de la formation vaut 1100.0
    Et ce n'est pas une formation ouverte à distance
    Et ce n'est pas une formation TOEIC
    Et ce n'est pas une formation BULATS
    Et ce n'est pas une formation CACES
    Et ce n'est pas une formation BEC
    Et ce n'est pas un bilan de compétences
    Et ce n'est pas un permis B
    Et la durée en mois de la formation vaut 98
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Opcalia Auvergne Rhône Alpes»
    Et le plafond de prise en charge vaut 7500
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Opcalia Auvergne Rhône Alpes»
    Et le plafond de prise en charge vaut 7500
    Et la rémunération vaut 0


Scénario: Cas nominal d'une période de professionnalisation CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «247»
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Opcalia»
    Et le plafond de prise en charge vaut 6000
    Et la rémunération vaut 0
    Quand je sélectionne le financement «Période de professionnalisation hors temps de travail»
    Alors l'organisme à contacter est «Opcalia»
    Et le plafond de prise en charge vaut 6000
    Et la rémunération vaut 0


Scénario: période de professionnalisation CDI en CléA
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «247»
    Et la durée en heures de la formation vaut 500
    Et la durée en mois de la formation vaut 10
    Et le code CPF de la formation vaut 201
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Opcalia»
    Et le montant de prise en charge vaut 500
    Et la rémunération vaut 0
    Quand je sélectionne le financement «Période de professionnalisation hors temps de travail»
    Alors l'organisme à contacter est «Opcalia»
    Et le montant de prise en charge vaut 500
    Et la rémunération vaut 0


Scénario: période de professionnalisation CDI VAE
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «247»
    Et la durée en heures de la formation vaut 10
    Et la durée en mois de la formation vaut 1
    Et le code CPF de la formation vaut 200
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Opcalia»
    Et le plafond de prise en charge vaut 450
    Et la rémunération vaut 0
    Quand je sélectionne le financement «Période de professionnalisation hors temps de travail»
    Alors l'organisme à contacter est «Opcalia»
    Et le plafond de prise en charge vaut 450
    Et la rémunération vaut 0


Scénario: Formation trop longue (en mois) pour une période de professionalisation
    Soit un bénéficiaire et une formation
    Et le bénéficiaire de droit privé vaut «True»
    Et la rémunération du bénéficiaire vaut «1400»
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «247»
    Et la durée en heures de la formation vaut «500»
    Et la durée en mois de la formation vaut «13»
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé

Scénario: Formation trop courte (en heures) pour une période de professionnalisation
    Soit un bénéficiaire et une formation
    Et le bénéficiaire de droit privé vaut «True»
    Et la rémunération du bénéficiaire vaut «1400»
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «247»
    Et la durée en heures de la formation vaut «60»
    Et la durée en mois de la formation vaut «12»
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé
