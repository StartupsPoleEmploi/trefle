Fonctionnalité: Rémunérations et aides en Bourgogne-Franche-Comté

Scénario: Aide complémentaire éligibles pour un DE de 16 ans
    Soit un bénéficiaire, une formation et un financement
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 16
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 3»
    Quand je demande un calcul de rémunération
    Quand je sélectionne la rémunération «Rémunération Bourgogne-Franche-Comté»
    Alors une aide complémentaire est éligible


Scénario: Aide complémentaire non éligible (dispositif 7)
    Soit un bénéficiaire, une formation et un financement
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 30
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 7»
    Quand je demande un calcul de rémunération
    Alors la rémunération «Rémunération Bourgogne-Franche-Comté» n'est pas proposée


Scénario: Aide complémentaire éligible pour un salarié temps plein (dispositif 1)
    Soit un bénéficiaire, une formation et un financement
    Et c'est un bénéficiaire de droit privé
    Et l'âge du bénéficiaire vaut 30
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 1»
    Quand je demande un calcul de rémunération
    Quand je sélectionne la rémunération «Rémunération Bourgogne-Franche-Comté»
    Alors une aide complémentaire est éligible


Scénario: Rému et aides moins de 18 ans
    Soit un bénéficiaire, une formation et un financement
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 16
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 3»
    Quand je demande un calcul de rémunération
    Quand je sélectionne la rémunération «Rémunération Bourgogne-Franche-Comté»
    Alors la rémunération applicable vaut 455.01
    Et une aide à l'hébergement est éligible
    Et une aide au transport est éligible


Scénario: Rému et aides moins de 18 ans pour un dispositif 12
    Soit un bénéficiaire, une formation et un financement
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 16
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 12»
    Quand je demande un calcul de rémunération
    Quand je sélectionne la rémunération «Rémunération Bourgogne-Franche-Comté»
    Alors une aide complémentaire est éligible


Scénario: Rému et aides plus de 18 ans
    Soit un bénéficiaire, une formation et un financement
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 36
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 4»
    Quand je demande un calcul de rémunération
    Quand je sélectionne la rémunération «Rémunération Bourgogne-Franche-Comté»
    Alors la rémunération applicable vaut 652.18
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible


Scénario: Rému et aides parent isolée
    Soit un bénéficiaire, une formation et un financement
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 36
    Et c'est un parent isolé
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 3»
    Quand je demande un calcul de rémunération
    Quand je sélectionne la rémunération «Rémunération Bourgogne-Franche-Comté»
    Alors la rémunération applicable vaut 863.0
    Et une aide à l'hébergement est éligible
    Et une aide au transport est éligible


Scénario: Rému et aides moins de 18 ans ayant travaillé 12 mois dont au moins 6 consécutifs
    Soit un bénéficiaire, une formation et un financement
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 17
    Et c'est un bénéficiaire non salarié qui a travaillé pendant douze mois dont au moins six mois consécutifs dans les trois ans qui précèdent l'entrée en formation
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 4»
    Quand je demande un calcul de rémunération
    Quand je sélectionne la rémunération «Rémunération Bourgogne-Franche-Comté»
    Alors la rémunération applicable vaut 708.59
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible


Scénario: Rému pour une pesonnes handicapée ayant déjà travaillé
    Soit un bénéficiaire, une formation et un financement
    Et c'est un demandeur d'emploi
    Et c'est un travailleur handicapé
    Et c'est un bénéficiaire non salarié qui a travaillé pendant douze mois dont au moins six mois consécutifs dans les trois ans qui précèdent l'entrée en formation
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 4»
    Quand je demande un calcul de rémunération
    Quand je sélectionne la rémunération «Rémunération Bourgogne-Franche-Comté»
    Alors la rémunération applicable vaut 910.02
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible


Scénario: Rému pour une pesonnes handicapée n'ayant pas travaillée
    Soit un bénéficiaire, une formation et un financement
    Et c'est un demandeur d'emploi
    Et c'est un travailleur handicapé
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 4»
    Quand je demande un calcul de rémunération
    Quand je sélectionne la rémunération «Rémunération Bourgogne-Franche-Comté»
    Alors la rémunération applicable vaut 1001.02
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible


Scénario: Pas de rému pour un salarié
    Soit un bénéficiaire, une formation et un financement
    Et c'est un bénéficiaire de droit privé
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 8»
    Quand je demande un calcul de rémunération
    Quand je sélectionne la rémunération «Rémunération Bourgogne-Franche-Comté»
    Alors la rémunération applicable vaut 0


Scénario: Pas de rému région pour formation sanitaire et social niveau Bac et plus
    Soit un bénéficiaire, une formation et un financement
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 30
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'intitulé du financement vaut «Formation sanitaire et social niveau Bac et plus»
    Et l'identifiant du financement vaut «dispositif 7»
    Quand je demande un calcul de rémunération
    Alors la rémunération «Rémunération Bourgogne-Franche-Comté» n'est pas proposée
