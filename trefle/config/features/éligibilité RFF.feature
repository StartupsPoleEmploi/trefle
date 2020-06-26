Fonctionnalité: Tests de l'éligibilité RFF

Scénario: la formation n'est pas RFF car mauvais code ROME à date de début de formation
    Soit un bénéficiaire et une formation
    Et la date de début de la formation vaut «01/10/2020»
    Et la liste des codes ROME de la formation valent [«C1102»]
    Quand je demande un calcul de financement
    Alors ce n'est pas une formation éligible à la RFF

Scénario: la formation éligible RFF
    Soit un bénéficiaire et une formation
    Et la date de début de la formation vaut «01/10/2020»
    Et la liste des codes ROME de la formation valent [«H2911»]
    Quand je demande un calcul de financement
    Alors ce n'est pas une formation éligible à la RFF

Scénario: la formation éligible RFF
    Soit un bénéficiaire et une formation
    Et la date de début de la formation vaut «01/05/2020»
    Et la liste des codes ROME de la formation valent [«C1102»]
    Quand je demande un calcul de financement
    Alors ce n'est pas une formation éligible à la RFF
