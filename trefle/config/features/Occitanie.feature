Fonctionnalité: Occitanie

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Occitanie»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors le plafond de prise en charge vaut 1000


Scénario: Niveau scolaire trop élevé pour un AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Occitanie»
    Et la niveau scolaire du bénéficiaire vaut «IV»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: Domaine FORMACODE 150 exclu
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Occitanie»
    Et la liste des domaines FORMACODE de la formation vaut [150]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: Domaine FORMACODE 150 mais code CPF 201 OK pour AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Occitanie»
    Et la liste des domaines FORMACODE de la formation vaut [150]
    Et la liste des codes CPF de la formation vaut [201]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors le plafond de prise en charge vaut 1000


Scénario: Cas nominal «Parcours orientation insertion»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Lot»
    Et l'intitulé normé de la formation vaut «PARCOURSORIENTATIONINSERTION»
    Et la liste des codes FORMACODE de la formation vaut [15061]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Parcours Orientation Insertion»
    Alors la rémunération applicable vaut 401.09


Scénario: Mauvais département pour «Parcours orientation insertion»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Gard»
    Et l'intitulé normé de la formation vaut «PARCOURSORIENTATIONINSERTION»
    Et la liste des codes FORMACODE de la formation vaut [15061]
    Quand je demande un calcul de financement
    Alors le financement «Parcours Orientation Insertion» n'est pas proposé


Scénario: Mauvais formacode pour «Parcours orientation insertion»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Gard»
    Et l'intitulé normé de la formation vaut «PARCOURSORIENTATIONINSERTION»
    Quand je demande un calcul de financement
    Alors le financement «Parcours Orientation Insertion» n'est pas proposé


Scénario: Cas nominal «Parcours diplômants et actions préparatoires»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Lot»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Parcours diplômants et actions préparatoires»
    Alors la rémunération applicable vaut 401.09


Scénario: Mauvais département pour «Parcours diplômants et actions préparatoires»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Gard»
    Quand je demande un calcul de financement
    Alors le financement «Parcours diplômants et actions préparatoires» n'est pas proposé


Scénario: Formation trop courte pour «Parcours diplômants et actions préparatoires»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Lot»
    Quand je demande un calcul de financement
    Alors le financement «Parcours diplômants et actions préparatoires» n'est pas proposé


Scénario: Niveau de sortie trop faible pour «Parcours diplômants et actions préparatoires»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Lot»
    Et le niveau scolaire du bénéficiaire vaut «IV»
    Et le niveau de sortie de la formation vaut «V»
    Quand je demande un calcul de financement
    Alors le financement «Parcours diplômants et actions préparatoires» n'est pas proposé


Scénario: «Parcours diplômants et actions préparatoires» OK si niveau scolaire et niveau de sortie = V
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Lot»
    Et le niveau scolaire du bénéficiaire vaut «V»
    Et le niveau de sortie de la formation vaut «V»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Parcours diplômants et actions préparatoires»
    Alors la rémunération applicable vaut 401.09
