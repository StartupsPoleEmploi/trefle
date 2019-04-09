Fonctionnalité: Projet de transistion professionnelle

Scénario: Cas nominal demandeur d'emploi - CDD
    Soit un bénéficiaire et une formation
    Et l'âge du bénéficiaire est 42
    Et c'est un demandeur d'emploi
    Et le département du bénéficiaire vaut «Cantal»
    Et le type de contrat du bénéficiaire est «CDD»
    Et le nombre de mois travaillés par le bénéficiaire dans la dernière année est 8
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années est 36
    Et la durée en heures de la formation est 50
    Et la date de début de la formation vaut «01/03/2019»
    Et la rémunération du bénéficiaire est 3100
    Et c'est une formation éligible CPF
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Projet de transition professionnelle»
    Alors le plafond de prise en charge vaut 0
    Et la rémunération applicable vaut 2790

Scénario: Cas nominal salarié - CDD
    Soit un bénéficiaire et une formation
    Et l'âge du bénéficiaire est 42
    Et c'est un bénéficiaire de droit privé
    Et le département du bénéficiaire vaut «Cantal»
    Et le type de contrat du bénéficiaire est «CDD»
    Et l'IDCC de l'établissement du bénéficiaire vaut 1979
    Et le nombre de mois travaillés par le bénéficiaire dans la dernière année est 8
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années est 36
    Et la durée en heures de la formation est 50
    Et la date de début de la formation vaut «01/03/2019»
    Et c'est une formation éligible CPF
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Projet de transition professionnelle CDD sur son temps de travail»
    Alors le plafond de prise en charge vaut 0

Scénario: Cas nominal salarié - CDI hors temps de travail
    Soit un bénéficiaire et une formation
    Et l'âge du bénéficiaire est 42
    Et c'est un bénéficiaire de droit privé
    Et le département du bénéficiaire vaut «Cantal»
    Et le type de contrat du bénéficiaire est «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut 1979
    Et l'ancienneté en mois du bénéficiaire dans son entreprise est 36
    Et l'expérience professionnelle du bénéficiaire est 48
    Et la durée en heures de la formation est 50
    Et c'est une formation éligible CPF
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Projet de transition professionnelle CDI hors temps de travail»
    Alors le plafond de prise en charge vaut 0

Scénario: Cas nominal salarié - CDI sur temps de travail
    Soit un bénéficiaire et une formation
    Et l'âge du bénéficiaire est 42
    Et c'est un bénéficiaire de droit privé
    Et le département du bénéficiaire vaut «Cantal»
    Et le type de contrat du bénéficiaire est «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut 1979
    Et l'ancienneté en mois du bénéficiaire dans son entreprise est 36
    Et l'expérience professionnelle du bénéficiaire est 48
    Et la durée en heures de la formation est 50
    Et la rémunération du bénéficiaire est 3100
    Et c'est une formation éligible CPF
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Projet de transition professionnelle CDI sur son temps de travail»
    Alors le plafond de prise en charge vaut 0
    Et la rémunération applicable vaut 2790
