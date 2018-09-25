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
    Et l'âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le département de la formation vaut «Lot»
    Et l'intitulé de la formation vaut «Parcours orientation insertion lot»
    Et la liste des codes FORMACODE de la formation vaut [15061]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Parcours Orientation Insertion»
    Alors la rémunération applicable vaut 401.09


Scénario: Mauvais département pour «Parcours orientation insertion»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le département de la formation vaut «Gard»
    Et l'intitulé de la formation vaut «Parcours orientation insertion lot»
    Et la liste des codes FORMACODE de la formation vaut [15061]
    Quand je demande un calcul de financement
    Alors le financement «Parcours Orientation Insertion» n'est pas proposé


Scénario: Mauvais formacode pour «Parcours orientation insertion»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le département de la formation vaut «Gard»
    Et l'intitulé de la formation vaut «Parcours orientation insertion lot»
    Quand je demande un calcul de financement
    Alors le financement «Parcours Orientation Insertion» n'est pas proposé


Scénario: Cas nominal «Parcours diplômants et actions préparatoires»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le département de la formation vaut «Lot»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Parcours diplômants et actions préparatoires»
    Alors la rémunération applicable vaut 401.09


Scénario: Mauvais département pour «Parcours diplômants et actions préparatoires»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le département de la formation vaut «Gard»
    Quand je demande un calcul de financement
    Alors le financement «Parcours diplômants et actions préparatoires» n'est pas proposé


Scénario: Formation trop courte pour «Parcours diplômants et actions préparatoires»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 150
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le département de la formation vaut «Lot»
    Quand je demande un calcul de financement
    Alors le financement «Parcours diplômants et actions préparatoires» n'est pas proposé


Scénario: Niveau de sortie trop faible pour «Parcours diplômants et actions préparatoires»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le département de la formation vaut «Lot»
    Et le niveau scolaire du bénéficiaire vaut «IV»
    Et le niveau de sortie de la formation vaut «V»
    Quand je demande un calcul de financement
    Alors le financement «Parcours diplômants et actions préparatoires» n'est pas proposé


Scénario: «Parcours diplômants et actions préparatoires» OK si niveau scolaire et niveau de sortie = V
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le département de la formation vaut «Lot»
    Et le niveau scolaire du bénéficiaire vaut «V»
    Et le niveau de sortie de la formation vaut «V»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Parcours diplômants et actions préparatoires»
    Alors la rémunération applicable vaut 401.09


Scénario: cas nominal dispositif chèque
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [70332]
    Et l'intitulé de la formation vaut «CHEQUES»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Dispositif « chèque »»
    Alors le texte de la rémunération vaut «Pas de rémunération spécifique.»


Scénario: manque formacode pour dispositif chèque
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'intitulé de la formation vaut «CHEQUES»
    Quand je demande un calcul de financement
    Alors le financement «Dispositif « chèque »» n'est pas proposé


Scénario: «Cap métiers» pour jeune de moins de 26 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Aude»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [70332]
    Et l'intitulé de la formation vaut «ACTION CAP METIERS PREPARATION METIERS DES INDUSTRIES NAUTIQUES»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Cap métiers»
    Alors la rémunération applicable vaut 339.35


Scénario: «Cap métiers» pour DE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et le niveau scolaire du bénéficiaire vaut «V»
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Aude»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [70332]
    Et l'intitulé de la formation vaut «ACTION CAP METIERS PREPARATION METIERS DES INDUSTRIES NAUTIQUES»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Cap métiers»
    Alors la rémunération applicable vaut 401.09


Scénario: «Cap métiers» non éligible: bénéficiaire trop âgé et niveau scolaire trop élevé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et le niveau scolaire du bénéficiaire vaut «II»
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Aude»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [70332]
    Et l'intitulé de la formation vaut «ACTION CAP METIERS PREPARATION METIERS DES INDUSTRIES NAUTIQUES»
    Quand je demande un calcul de financement
    Alors le financement «Cap métiers» n'est pas proposé


Scénario: «Cap métiers» non éligible: mauvais département
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et le niveau scolaire du bénéficiaire vaut «V»
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Lot»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [70332]
    Et l'intitulé de la formation vaut «ACTION CAP METIERS PREPARATION METIERS DES INDUSTRIES NAUTIQUES»
    Quand je demande un calcul de financement
    Alors le financement «Cap métiers» n'est pas proposé



Scénario: «Cap avenir» pour jeune de moins de 26 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Aude»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [70332]
    Et l'intitulé de la formation vaut «ACTION CAP AVENIR»
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Cap avenir»
    Alors la rémunération applicable vaut 339.35


Scénario: «Cap avenir» pour DE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et le niveau scolaire du bénéficiaire vaut «V»
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Aude»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [70332]
    Et l'intitulé de la formation vaut «ACTION CAP AVENIR»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Cap avenir»
    Alors la rémunération applicable vaut 401.09


Scénario: «Cap avenir» non éligible: bénéficiaire trop âgé et niveau scolaire trop élevé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et le niveau scolaire du bénéficiaire vaut «II»
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Aude»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [70332]
    Et l'intitulé de la formation vaut «ACTION CAP AVENIR»
    Quand je demande un calcul de financement
    Alors le financement «Cap avenir» n'est pas proposé


Scénario: «Cap avenir» non éligible: mauvais département
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 28
    Et le niveau scolaire du bénéficiaire vaut «V»
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Lot»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [70332]
    Et l'intitulé de la formation vaut «ACTION CAP AVENIR»
    Quand je demande un calcul de financement
    Alors le financement «Cap avenir» n'est pas proposé


Scénario: Cas nominal «Cap compétences clés»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'intitulé de la formation vaut «CAP COMPETENCE CLE NIMES VAUVERT BEAUCAIRE SOMMIERES UZES»
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Cap compétences clés»
    Alors la texte de la rémunération vaut «Pas de rémunération spécifique.»


Scénario: «Cap compétences clés» avec ARE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'intitulé de la formation vaut «CAP COMPETENCE CLE NIMES VAUVERT BEAUCAIRE SOMMIERES UZES»
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 600
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Cap compétences clés»
    Alors la rémunération applicable vaut 616.2


Scénario: Cas nominal «Programme régional qualifiant»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional qualifiant»
    Alors la rémunération applicable vaut 339.35


Scénario: Pas de «Programme régional qualifiant» pour un «Cap compétences clés»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'intitulé de la formation vaut «CAP COMPETENCE CLE NIMES VAUVERT BEAUCAIRE SOMMIERES UZES»
    Quand je demande un calcul de financement
    Alors le financement «Programme régional qualifiant» n'est pas proposé


Scénario: Cas nominal «ER2C»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'intitulé de la formation vaut «Action de formation ER2C»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Écoles régionales de la deuxième chance»
    Alors la rémunération applicable vaut 339.35


Scénario: Mauvais département pour «ER2C»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Haute-Garonne»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'intitulé de la formation vaut «Action de formation ER2C»
    Quand je demande un calcul de financement
    Alors le financement «Écoles régionales de la deuxième chance» n'est pas proposé


Scénario: Bénéficiaire trop âgé pour «ER2C»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 26
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Aude»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'intitulé de la formation vaut «Action de formation ER2C»
    Quand je demande un calcul de financement
    Alors le financement «Écoles régionales de la deuxième chance» n'est pas proposé


Scénario: Niveau d'étude trop élevé pour «ER2C»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 25
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Aude»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'intitulé de la formation vaut «Action de formation ER2C»
    Et le niveau scolaire du bénéficiaire vaut «II»
    Quand je demande un calcul de financement
    Alors le financement «Écoles régionales de la deuxième chance» n'est pas proposé


Scénario: Cas nominal «Formations des établissements d'enseignement supérieur»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le SIRET de l'organisme de formation vaut 19341089100280
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formations des établissements d'enseignement supérieur»
    Alors le texte de la rémunération vaut «Pas de rémunération spécifique.»


Scénario: Mauvais SIRET pour «Formations des établissements d'enseignement supérieur»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le SIRET de l'organisme de formation vaut 19341089100281
    Quand je demande un calcul de financement
    Alors le financement «Formations des établissements d'enseignement supérieur» n'est pas proposé


Scénario: Cas nominal «École de l'apprentissage» jeune
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le SIRET de l'organisme de formation vaut 31009419800028
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «École de l'apprentissage»
    Alors la rémunération applicable vaut 339.35


Scénario: «École de l'apprentissage» pour travailleur handicapé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 29
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le SIRET de l'organisme de formation vaut 31009419800028
    Et c'est un travailleur handicapé
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «École de l'apprentissage»
    Alors la rémunération applicable vaut 652.02


Scénario: Trop âgé pour «École de l'apprentissage»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 29
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le SIRET de l'organisme de formation vaut 31009419800028
    Quand je demande un calcul de financement
    Alors le financement «École de l'apprentissage» n'est pas proposé


Scénario: Travailleur handicapé trop âgé pour «École de l'apprentissage»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 30
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le SIRET de l'organisme de formation vaut 31009419800028
    Et c'est un travailleur handicapé
    Quand je demande un calcul de financement
    Alors le financement «École de l'apprentissage» n'est pas proposé


Scénario: Manque code financeur pour «École de l'apprentissage»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 20
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et la région de la formation vaut «Occitanie»
    Et le département de la formation vaut «Gard»
    Et le SIRET de l'organisme de formation vaut 31009419800028
    Quand je demande un calcul de financement
    Alors le financement «École de l'apprentissage» n'est pas proposé


Scénario: Financement permis B
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et c'est un permis B
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Prise en charge permis de conduire B»
    Alors le texte de la rémunération vaut «Pas de rémunération spécifique.»


Scénario: Pas un permis B
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Prise en charge permis de conduire B» n'est pas proposé


Scénario: Formation sanitaire et social ex-Midi-Pyrénées
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le département de la formation vaut «Lot»
    Et la liste des codes FORMACODE de la formation vaut [43436]
    Et le code CERTIFINFO de la formation vaut 88309
    Et le niveau de sortie de la formation vaut «V»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation sanitaire et social»
    Alors la rémunération applicable vaut 339.35


Scénario: Formation sanitaire et social ex-Languedoc-Roussillon
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Occitanie»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le département de la formation vaut «Gard»
    Et la liste des codes FORMACODE de la formation vaut [43436]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation sanitaire et social»
    Alors le texte de la rémunération vaut «Possibilité de demande de bourse régionale.»
