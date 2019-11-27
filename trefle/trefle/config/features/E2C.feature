Fonctionnalité: Ecole de la deuxième chance

Scénario: cas nominal E2C
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 22
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Bretagne»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et c'est une formation E2C
    Et la liste des codes FORMACODE de la formation vaut [38808]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «École de la deuxième chance»
    Alors la rémunération applicable vaut 339.35

Scénario: pas de financement E2C pour un bénéficiaire de plus de 25 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 26
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Bretagne»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et c'est une formation E2C
    Et la liste des codes FORMACODE de la formation vaut [38808]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «École de la deuxième chance» n'est pas proposé

Scénario: Pas de financement E2C pour un bénéficiaire avec un niveau scolaire supérieur à V
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 22
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Bretagne»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et c'est une formation E2C
    Et la liste des codes FORMACODE de la formation vaut [38808]
    Et la niveau scolaire du bénéficiaire vaut «IV»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «École de la deuxième chance» n'est pas proposé

Scénario: Pas de financement E2C pour une formation avec un mauvais FORMACODE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 22
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Normandie»
    Et la région de la formation vaut «Bretagne»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et c'est une formation E2C
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «École de la deuxième chance» n'est pas proposé
