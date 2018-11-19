Fonctionnalité: Grand-Est

Scénario: Cas nominal aide individuelle régionale à la formation (formation certifiante)
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Grand-Est»
    Et le niveau de sortie de la formation vaut «III»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation certifiante
    Et c'est une formation éligible COPAREF de la région du bénéficiaire
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle régionale à la formation»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 6000


Scénario: Aide individuelle régionale à la formation exclue, non éligible COPAREF/COPANEF (formation certifiante)
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Grand-Est»
    Et le niveau de sortie de la formation vaut «III»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation certifiante
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle régionale à la formation» n'est pas proposé


Scénario: Cas nominal aide individuelle régionale à la formation (formation professionnalisante)
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la durée hebdomadaire de la formation vaut 30
    Et la région du bénéficiaire vaut «Grand-Est»
    Et le niveau de sortie de la formation vaut «III»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est un formation professionnalisante
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle régionale à la formation»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 6000


Scénario: Formation trop longue pour ide individuelle régionale à la formation (formation professionnalisante)
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 650
    Et la durée hebdomadaire de la formation vaut 30
    Et la région du bénéficiaire vaut «Grand-Est»
    Et le niveau de sortie de la formation vaut «III»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est un formation professionnalisante
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle régionale à la formation» n'est pas proposé


Scénario: Aide individuelle régionale à la formation avec mauvais niveau de sortie
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Grand-Est»
    Et le niveau de sortie de la formation vaut «I»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation certifiante
    Et c'est une formation éligible COPAREF de la région du bénéficiaire
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle régionale à la formation» n'est pas proposé


Scénario: Cas nominal formation sanitaire et social
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région de la formation vaut «Grand-Est»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le code CERTIFINFO de la formation vaut 48735
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation sanitaire et social»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Formation sanitaire et social sans certifinfo pour la formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région de la formation vaut «Grand-Est»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Alors le financement «Formation sanitaire et social» n'est pas proposé


Scénario: Formation sanitaire et social en dehors de Grand-Est
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région de la formation vaut «Bretagne»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Alors le financement «Formation sanitaire et social» n'est pas proposé


Scénario: Cas nominal programme régional de formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région de la formation vaut «Grand-Est»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le niveau de sortie de la formation vaut «IV»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional de formation»
    Alors la rémunération applicable vaut 0
    Et la plafond de prise en charge vaut 0


Scénario: Programme régional de formation avec mauvais niveau de sortie pour la formation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le montant de l'allocation du bénéficiaire vaut 1200
    Et la durée en heures de la formation vaut 150
    Et la région de la formation vaut «Grand-Est»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le niveau de sortie de la formation vaut «I»
    Quand je demande un calcul de financement
    Alors le financement «Programme régional de formation» n'est pas proposé
