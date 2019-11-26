Fonctionnalité: action collective


Scénario: financement région pour un bénéficiaire sans allocation ayant plus de 26 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 30
    Et la durée en heures de la formation vaut 120
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Guyane»
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action de formation collective financée par la région»
    # FIXME: d'après Armelle, 652.02
    Alors la rémunération applicable vaut 401.09


Scénario: financement région pour bénéficiaire avec ARE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 30
    Et la durée en heures de la formation vaut 120
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le montant de l'allocation du bénéficiaire vaut 800
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la région de la formation vaut «Guyane»
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Action de formation collective financée par la région»
    Alors la rémunération applicable vaut 800


Scénario: financement région pour un bénéficiaire exclu pour mauvaise région
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 30
    Et la durée en heures de la formation vaut 120
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la région de la formation vaut «Normandie»
    Et la région du bénéficiaire vaut «Normandie»
    Quand je demande un calcul de financement
    Alors le financement «Action de formation collective financée par la région» n'est pas proposé


Scénario: financement PE pour un bénéficiaire de 18 ans sans allocation
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 18
    Et la durée en heures de la formation vaut 120
    Et les codes financeur de la formation valent [«Pôle emploi»]
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action de formation collective financée par Pôle emploi»
    Alors la rémunération applicable vaut 310.39


Scénario: pas de financement PE si le code financeur entreprise est présent
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 18
    Et la durée en heures de la formation vaut 120
    Et les codes financeur de la formation valent [4,5]
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Alors le financement «Action de formation collective financée par Pôle emploi» n'est pas proposé


Scénario: financement Agefiph pour un travailleur handicapé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 120
    Et les codes financeur de la formation valent [7]
    Et c'est une travailleur handicapé
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action de formation collective financée par l'Agefiph»
    Alors la rémunération applicable vaut 652.02


Scénario: financement département
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 120
    Et les codes financeur de la formation valent [8]
    Et la département de la formation vaut «Ariège»
    Et la département du bénéficiaire vaut «Ariège»
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action de formation collective financée par le conseil départemental»
    Alors la rémunération applicable vaut 401.09


Scénario: pas de financement département si les départements ne sont pas les mêmes
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 120
    Et les codes financeur de la formation valent [8]
    Et la département de la formation vaut «Ariège»
    Et la département du bénéficiaire vaut «Aude»
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Alors le financement «Action de formation collective financée par le conseil départemental» n'est pas proposé


Scénario: financement par l'État
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 120
    Et les codes financeur de la formation valent [11]
    Et la région du bénéficiaire vaut «Bretagne»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action de formation collective financée par l'État»
    Alors la rémunération applicable vaut 401.09
