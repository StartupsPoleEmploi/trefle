Fonctionnalité: Rémunérations et aides en Bourgogne-Franche-Comté

Scénario: Rému et aides moins de 18 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 16
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 5»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 455.01
    Et une aide complémentaire est éligible
    Et le montant de l'aide complémentaire vaut 200
    Et une aide à l'hébergement est éligible
    Et le montant de l'aide à l'hébergement vaut «37,20€ par mois (sous condition)»
    Et une aide au transport est éligible
    Et le montant de l'aide au transport vaut «98,79€ par mois (sous condition)»


Scénario: Rému et aides plus de 18 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 36
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 5»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 652.18
    Et une aide complémentaire est éligible
    Et le montant de l'aide complémentaire vaut 200
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible
    Et le montant de l'aide au transport vaut «98,79€ par mois (sous condition)»


Scénario: Rému et aides parent isolée
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 36
    Et c'est un parent isolé
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 5»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 863.0
    Et une aide complémentaire est éligible
    Et le montant de l'aide complémentaire vaut 200
    Et une aide à l'hébergement est éligible
    Et le montant de l'aide à l'hébergement vaut «101,84€ par mois (sous condition)»
    Et une aide au transport est éligible
    Et le montant de l'aide au transport vaut «98,79€ par mois (sous condition)»


Scénario: Rému et aides moins de 18 ans DE et non salarié ayant travaillé 12 mois dont au moins 6 consécutifs dans les 3 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 17
    Et c'est un bénéficiaire non salarié qui a travaillé pendant douze mois dont au moins six mois consécutifs dans les trois ans qui précèdent l'entrée en formation
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 5»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 708.59
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible
    Et le texte de l'aide au transport vaut «L'indemnité de transport est limitée à un aller/retour sur la durée de la formation.»
    Et le montant de l'aide au transport vaut «Montant à calculer»


Scénario: Rému et aides moins de 18 ans DE, salarié pdt 6 mois sur 12  et non salarié ayant travaillé 12 mois dont au moins 6 consécutifs dans les 3 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 17
    Et c'est un bénéficiaire non salarié qui a travaillé pendant douze mois dont au moins six mois consécutifs dans les trois ans qui précèdent l'entrée en formation
    Et c'est un bénéficiaire qui a déjà travaillé six mois sur une période de douze mois
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 5»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 863
    Et une aide complémentaire est éligible
    Et une aide à l'hébergement est éligible
    Et le montant de l'aide à l'hébergement vaut «101,84€ par mois (sous condition)»
    Et une aide au transport est éligible
    Et le montant de l'aide au transport vaut «98,79€ par mois (sous condition)»
    Et le texte de l'aide au transport vaut «Si la distance vers le lieu de votre formation est supérieure ou égale à 16km. Alors vous pouvez bénéficier d'une aide au transport.»


Scénario: Rému pour une pesonnes handicapée ayant déjà travaillé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et c'est un travailleur handicapé
    Et c'est un bénéficiaire qui a déjà travaillé six mois sur une période de douze mois
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 5»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 910.02
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible
    Et le texte de l'aide au transport vaut «L'indemnité de transport est limitée à un aller/retour sur la durée de la formation.»


Scénario: Rému pour une pesonnes handicapée n'ayant pas travaillée
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et c'est un travailleur handicapé
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'identifiant du financement vaut «dispositif 5»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 1001.02
    Et aucune aide à l'hébergement n'est éligible
    Et une aide au transport est éligible
    Et le texte de l'aide au transport vaut «L'indemnité de transport est limitée à un aller/retour sur la durée de la formation.»


Scénario: Pas de rému région pour formation sanitaire et social niveau Bac et plus
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 30
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et l'intitulé du financement vaut «Formation sanitaire et social niveau Bac et plus»
    Quand je demande un calcul de rémunération
    Alors la rémunération applicable vaut 401.09
    Et l'intitulé de la règle de rémunération vaut «Aides et rémunération mobilisable par les règles nationales»
    Et aucune aide à l'hébergement n'est éligible
    Et aucune aide au transport n'est éligible
