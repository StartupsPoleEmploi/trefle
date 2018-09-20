Fonctionnalité: Cas d'usage de Nouvelle-Aquitaine

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors le plafond de prise en charge vaut 3000
    Et le texte de la prise en charge vaut «Formation partiellement ou totalement financée dans la limite de 3000 euros, et du montant correspondant à vos droits CPF si la formation est éligible.»


Scénario: Formation trop longue pour l'AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 401
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: Durée hebdo trop courte pour l'AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la durée hebdomadaire de la formation vaut 20
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: Pas d'AIF à cause du domaine FORMACODE 150
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la liste des domaines FORMACODE de la formation vaut [150]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: AIF possible malgré un domaine FORMACODE 150 parce que le code CPF vaut 201
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la liste des domaines FORMACODE de la formation vaut [150]
    Et la liste des codes CPF de la formation vaut [201]
    Et c'est une formation CléA
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 0



Scénario: AIF avec ARE finissant avant la fin de la formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 30
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un bénéficiaire de droit privé
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Et l'âge du bénéficiaire vaut 30
    Et c'est un travailleur handicapé
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 758
    Et la date de fin de la formation vaut «04/05/2018»
    Et la date de fin de l'allocation du bénéficiaire vaut «04/04/2018»
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la liste des codes ROME de la formation vaut [«A1101»]
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 758
    Et la RFF applicable vaut 652.02


Scénario: Cas nominal «Programme régional formation»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la département du bénéficiaire vaut «Landes»
    Et la département de la formation vaut «Landes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional de formation»
    Alors la rémunération applicable vaut 401.09

Scénario: Cas nominal «Formations sanitaires et sociales» ex-Aquitaine
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la département du bénéficiaire vaut «Landes»
    Et la département de la formation vaut «Landes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [43006]
    Quand je demande un calcul de financement
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations sanitaires et sociales»
    Alors la rémunération applicable vaut 401.09


Scénario: Pas de rémunération pour «Programme régional formation» si la durée est trop courte
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la département du bénéficiaire vaut «Landes»
    Et la département de la formation vaut «Landes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional de formation»
    Alors la rémunération applicable vaut 0


Scénario: Cas nominal «Programme régional formation sanitaire et social» en Charente
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la département du bénéficiaire vaut «Charente»
    Et la département de la formation vaut «Charente»
    Et la liste des codes FORMACODE de la formation vaut [44083]
    Et le SIRET de l'organisme de formation vaut 77571615200019
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional de formation sanitaire et social»
    Alors la rémunération applicable vaut 401.09


Scénario: Cas nominal «Programme régional formation sanitaire et social» dans la Creuse
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Nouvelle-Aquitaine»
    Et la département du bénéficiaire vaut «Creuse»
    Et la département de la formation vaut «Creuse»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [43441]
    Et le SIRET de l'organisme de formation vaut 77567227230717
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional de formation sanitaire et social»
    Alors la rémunération applicable vaut 401.09
