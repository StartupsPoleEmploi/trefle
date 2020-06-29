Fonctionnalité: Tests de l'éligibilité RFF

Scénario: la formation n'est pas RFF car mauvais code ROME à date de début de formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Île-de-France»
    Et la date de début de la formation vaut «01/05/2020»
    Et la liste des codes ROME de la formation vaut [«H2911»]
    Quand je demande un calcul de financement
    Alors ce n'est pas une formation éligible à la RFF

Scénario: la formation est éligible RFF car bon code ROME pour la date
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Île-de-France»
    Et la date de début de la formation vaut «01/10/2020»
    Et la liste des codes ROME de la formation vaut [«H2911»]
    Quand je demande un calcul de financement
    Alors c'est une formation éligible à la RFF

Scénario: la formation est RFF car code ROME ancien pour date début ancienne
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Île-de-France»
    Et la date de début de la formation vaut «01/05/2020»
    Et la liste des codes ROME de la formation vaut [«C1102»]
    Quand je demande un calcul de financement
    Alors c'est une formation éligible à la RFF

Scénario: la formation n'est pas éligible RFF car code ROME ancien pour date début récente
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Île-de-France»
    Et la date de début de la formation vaut «01/10/2020»
    Et la liste des codes ROME de la formation vaut [«C1102»]
    Quand je demande un calcul de financement
    Alors ce n'est pas une formation éligible à la RFF

