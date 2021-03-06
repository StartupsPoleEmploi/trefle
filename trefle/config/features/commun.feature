Fonctionnalité: Tests génériques
    Les scénarios de test génériques.

Scénario: le bénéficiaire n'a pas d'heures CPF sur son compte
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 0
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et c'est une formation éligible CPF
    Et la durée en heures de la formation vaut 100
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Quand je demande un calcul de financement
    Alors le financement «CPF sur son temps de travail» n'est pas proposé
    Et le financement «CPF hors temps de travail» n'est pas proposé

Scénario: le bénéficiaire n'est pas de droit privé
    Soit un bénéficiaire et une formation
    Et ce n'est pas un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 0
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et c'est une formation éligible CPF
    Et l'IDCC de l'établissement du bénéficiaire vaut 2706
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé

Scénario: cas d'une formation CPF avec solde CPF null
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le solde CPF du bénéficiaire vaut 0
    Et c'est une formation éligible CPF
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Alors le financement «CPF sur son temps de travail» n'est pas proposé
    Et le financement «CPF hors temps de travail» n'est pas proposé

Scénario: cas d'une formation CPF sans solde CPF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et c'est une formation éligible CPF
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et le prix horaire de la formation vaut 25
    Et la durée en heures de la formation vaut 100
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors le plafond de prise en charge vaut 0
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors le plafond de prise en charge vaut 0


Scénario: le solde CPF n'est pas plafonné
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et c'est une formation éligible CPF
    Et l'IDCC de l'établissement du bénéficiaire vaut 7010
    Et le prix horaire de la formation vaut 10
    Et la durée en heures de la formation vaut 300
    Et le solde CPF du bénéficiaire vaut 1920
    Quand je demande un calcul de financement
    Et je sélectionne le financement «CPF sur son temps de travail»
    Alors le plafond de prise en charge vaut 1920
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors le plafond de prise en charge vaut 1920


Scénario: le bénéficiaire n'a pas défini de rémunération
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 1500
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire vaut 24
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 24
    Et le code NAF de l'établissement du bénéficiaire vaut «7830Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2397»
    Et la région de l'établissement du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et ce n'est pas une formation éligible CPF
    Et les codes NAF CPNE éligibles vaut [«7830Z»,«8299Z»,«4633Z»,«1089Z»]
    Et la liste des codes FORMACODE de la formation vaut [44028,42866,42056]
    Et le niveau de sortie de la formation vaut «aucun»
    Et la durée en heures de la formation vaut 210
    Et le code CERTIFINFO de la formation vaut 87647
    Et la liste des domaines FORMACODE de la formation vaut [420,440,428]
    Et les codes financeur de la formation valent [5]
    Et la durée en mois de la formation vaut 12
    Et la durée en semaines de la formation vaut 52
    Et la durée hebdomadaire de la formation vaut 35
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 1500
    Et la rémunération applicable vaut 0
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Afdas»
    Et le plafond de prise en charge vaut 1500
    Et la rémunération applicable vaut 0
