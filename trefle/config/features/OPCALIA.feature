Fonctionnalité: OPCALIA

Scénario: Cas nominal CPF et projet de transisition professionnel
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 1500
    Et la rémunération du bénéficiaire vaut 1500.0
    Et l'âge du bénéficiaire vaut 38
    Et l'expérience professionnelle du bénéficiaire vaut 144
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le code NAF de l'établissement du bénéficiaire vaut «5110Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2002»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «75056»
    Et l'intitulé de la formation vaut «Titre professionnel peintre décorateur»
    Et la commune de la formation vaut «94028»
    Et le SIRET de l'organisme de formation vaut 41124054200026
    Et c'est une formation éligible CPF
    Et c'est une formation éligible COPANEF
    Et la liste des codes ROME de la formation vaut [F1606,L1503]
    Et la liste des codes FORMACODE de la formation vaut [22480,45040,45501]
    Et la liste des domaines FORMACODE de la formation vaut [224,450,455]
    Et le code CERTIFINFO de la formation vaut 101949
    Et le code RNCP de la formation vaut 31078
    Et la durée en heures de la formation vaut 973
    Et le nombre d'heures en entreprise vaut 105
    Et le nombre d'heures en centre vaut 868
    Et la liste des codes CPF de la formation vaut [243118]
    Et la liste des codes CPF de la formation pour un demandeur d'emploi vaut [243118]
    Et la code AIS de la formation vaut «Certification»
    Et la date de début de la formation vaut «02/09/2019»
    Et la date de fin de la formation vaut «26/03/2020»
    Et ce n'est pas une formation ouverte à distance
    Et la liste des codes des modalités pédagogiques vaut [96312,96142]
    Et c'est une formation certifiante
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Et ce n'est pas une préparation opérationnelle à l'emploi individuelle
    Et la département de l'établissement du bénéficiaire vaut «Paris»
    Et ce n'est pas une formation à entrées-sorties permanentes
    Et la durée en semaines de la formation vaut 30
    Et la durée en mois de la formation vaut 7
    Et la durée hebdomadaire de la formation vaut 32
    Et le département de la formation vaut «Val-de-Marne»
    Et la région de la formation vaut «Île-de-France»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation RNCP
    Et l'OPCA de l'établissement du bénéficiaire vaut «Opcalia»
    Et l'OPACIF de l'établissement du bénéficiaire vaut «Fongecif»
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et le montant de l'allocation du bénéficiaire vaut 0.0
    Et ce n'est pas une formation professionnalisante
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 60
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Projet de transition professionnelle CDI sur son temps de travail»
    Alors la rémunération applicable vaut 1500.0
    Et la plafond de prise en charge vaut 0
    Quand je sélectionne le financement «Projet de transition professionnelle CDI hors temps de travail»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors la rémunération applicable vaut 1500.0
    Et la plafond de prise en charge vaut 1500.0
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 1500
