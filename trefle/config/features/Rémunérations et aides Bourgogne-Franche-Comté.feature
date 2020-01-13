Fonctionnalité: Rémunérations et aides en Bourgogne-Franche-Comté

Scénario: Rému et aides moins de 18 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 16
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 455.01
    Et une aide à l'hébergement est éligible
    Et une aide au transport est éligible


Scénario: Rému et aides plus de 18 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 36
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 652.18
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible


Scénario: Rému et aides parent isolée
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 36
    Et c'est un parent isolé
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 863.0
    Et une aide à l'hébergement est éligible
    Et une aide au transport est éligible


Scénario: Rému et aides moins de 18 ans ayant travaillé 12 mois dont au moins 6 consécutifs
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 17
    Et c'est un bénéficiaire non salarié qui a travaillé pendant douze mois dont au moins six mois consécutifs dans les trois ans qui précèdent l'entrée en formation
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 708.59
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible


Scénario: Rému pour une pesonnes handicapée ayant déjà travaillé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et c'est un travailleur handicapé
    Et c'est un bénéficiaire non salarié qui a travaillé pendant douze mois dont au moins six mois consécutifs dans les trois ans qui précèdent l'entrée en formation
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 910.02
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible


Scénario: Rému pour une pesonnes handicapée n'ayant pas travaillée
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et c'est un travailleur handicapé
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 1001.02
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible
