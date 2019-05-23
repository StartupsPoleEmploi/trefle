Fonctionnalité: Bourgogne-Franche-Comté


Scénario: Cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le âge du bénéficiaire vaut 30
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 401.09

Scénario: CERTIFINFO exclu pour AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le âge du bénéficiaire vaut 30
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et le code CERTIFINFO de la formation vaut 25467
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=3WCuqu32GVeKYcg4TkJiTk6ycMKssw6CQ4ssllQysssst5CC7Ps4RLkyfoOimygw6K4Kde6QYYYiGBwjsyGsskr2H6rJeYeyBNsavfoycTC3UV0vMYETMU1CS58tyv96osmWIkZNvUesLgfT35d3QeaIV6f5HsjBmh-KQIcylrjIdMUJ-v%3DJ5QG7DFPdoSUiN396g26HmoAU2BPR%3D1LA8ySVa3iAIoHi4o1u0NHt6ZMmd%3Dcns3ABd1OtQg9hO%3DUrbRPuO7r1BMfh%3Dw2fIABY-toGoSJ2kTe-wxlp9v7phEVf4E2H7tA5sdO5y4A97-0fkijm-hmTLGm5UtJKoGFrLsy6Kf-dbmHARjfrmM%3Dcmvdip4rZhy9pEdDbDMNIWIHsFfQq7szz
Scénario: AIF avec RFF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 45
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la département de la formation vaut «Côte-d'Or»
    Et la liste des codes ROME de la formation vaut [M1302,D1202]
    Et la liste des codes FORMACODE de la formation vaut [42050]
    Et la liste des domaines FORMACODE de la formation vaut [420]
    Et le code CERTIFINFO de la formation vaut 60617
    Et le code RNCP de la formation vaut 6253
    Et la durée en heures de la formation vaut 505
    Et le prix horaire de la formation vaut 0.0
    Et la liste des codes CPF de la formation vaut [17545,16162,151739,162844]
    Et la code AIS de la formation vaut «Certification»
    Et la date de début de la formation vaut «01/01/2016»
    Et la date de fin de la formation vaut «31/01/2019»
    Et c'est une formation certifiante
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Et ce n'est pas une préparation opérationnelle à l'emploi individuelle
    Et c'est une formation RNCP
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas un contrat de professionnalisation
    Et le niveau de sortie de la formation vaut «III»
    Et ce n'est pas une formation à entrées-sorties permanentes
    Et la durée en semaines de la formation vaut 161
    Et la durée en mois de la formation vaut 37
    Et la durée hebdomadaire de la formation vaut 3
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation de l'enseignement supérieur
    Et c'est une formation éligible à la RFF
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la montant de l'allocation du bénéficiaire vaut 4000.0
    Et la date de fin de l'allocation du bénéficiaire vaut «15/12/2018»
    Et la niveau scolaire du bénéficiaire vaut «V»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 4000.0
    Et la RFF applicable vaut 652.02
    Et la date de début de la RFF applicable vaut «16/12/2018»
    Et la date de fin de la RFF applicable vaut «31/01/2019»
    Et la date de fin de la rémunération applicable vaut «15/12/2018»


# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=2qndnO5MGVeKYcg4TkJiTkvsvW9sswbCQ4ssllQysssst5CC7Ps4RLkyK2iuweHW2NCjQ22wj2su8ik2i2N2ssssoKvfjH6iuyBNJscH-MWaytwZPLXd2itMvCfwxB_9V0JDs4a77B8JdHmY2UHvKo1DRdP96OXuRBiRyKB1qWXcw4ZH0pJaoaiLyHxTQAFV0JjFNkmE4k9NyN5F7vE5KTYYWqaeNr27Qf7KmvXVaBYtAPfcxvCpy2jEjCCW4dT3OfPo4p06X4uQMfid4i4-aUpfFQ1gj1FN9qsCEOQ1pHQ3FDyRItkAvP9sODppgT39cCUtN6raECRqT4yN293RmDBYGcJIGq8ImHXoudo48An0Ygxp402IiBaPqZlgqHgXgRG7pRLr-szz
Scénario: permis B exclu de l'AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 45
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la département de la formation vaut «Côte-d'Or»
    Et la durée en heures de la formation vaut 40
    Et la durée en semaines de la formation vaut 92
    Et la durée en mois de la formation vaut 21
    Et la durée hebdomadaire de la formation vaut 0
    Et c'est un permis B
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la niveau scolaire du bénéficiaire vaut «V»
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=n%3DqWWdLqGVeKYcg4TkJiTpuJ0WQsswbCQ4ssllQysssst5CC7Ps4RLkyr2iuaGpNCjQyf60jsu8mG7YjssssoKvrdNviuweyBNsavJoycTC3UeN6IanTBP-CS38t7vI6osmWLABc2t4crY2xRbsY2b4WN6dwOGeorA27BqyC7-Qy04AJXQGeD2ZFa9a5o9T1%3D1BIK8Bj9ga3FmanI1HhpbL5I1BYgGGVGoiwknoiLuY-fSx89cYAgnE5_sTVteFaDQAdteDEY11yhqHKgMjrrRbBsI0EXk5Xs_Dn4N-i4eMFaoFjNe6X-c3%3DfQALkpL_YJXKPRufLZsP%3DyPYsrgbiIs5AoYx3RRTG9jproXeNi8H9sUL2U5P4LxlrnNr0RfmBjx8Ussz
Scénario: FORMACODE exclu pour AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 45
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la département de la formation vaut «Saône-et-Loire»
    Et la liste des codes FORMACODE de la formation vaut [43436]
    Et la liste des domaines FORMACODE de la formation vaut [434]
    Et la durée en heures de la formation vaut 735
    Et le nombre d'heures en entreprise vaut 420
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la niveau scolaire du bénéficiaire vaut «V»
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=L%3DMbdWCCGVeKYcg4TkJiTLctpEbssw6CQ4ssllQysssst5CC7Ps4RLkyfoOimpvNCjQpf6vQYi1R0j0jYssss47HK2Q2BNJyGs1JoGpYJl2_v7kf7u0a%3Dw_J0ZPDEXesRYuIKSYyYw-yenuN-99wc8p9xdKiNmQIB4h74GEnu4%3D-Z9oENu4ZVmNI2JIIkJ%3DIW0YFfQBAnXpj%3DcK3qPBVa3iAIoHI4o1ueNHt6jMmd%3Dcns3AGOAbCsEpL1qgn-7tD3jEBg-o_o%3Dm7rjaqcrmQa6TDkTLQ80_UJaIU2DEP4EMoVAjns8dncsjuVGIWWk%3DByg-fDhsPLyOvQBR6H9sLjrgPqf4H-TermM%3DimvdiD4r30wkagWelgqHgXgRG9XOQt-zz
Scénario: Formation totalement financée par l'AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 45
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la département de la formation vaut «Côte-d'Or»
    Et ce n'est pas une formation éligible CPF
    Et la liste des codes FORMACODE de la formation vaut [43425]
    Et la liste des domaines FORMACODE de la formation vaut [434]
    Et la durée en heures de la formation vaut 100
    Et le prix horaire de la formation vaut 0.0
    Et la code AIS de la formation vaut «Certification»
    Et la date de début de la formation vaut «01/10/2018»
    Et la date de fin de la formation vaut «05/08/2019»
    Et ce n'est pas une formation ouverte à distance
    Et c'est une formation certifiante
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Et ce n'est pas une préparation opérationnelle à l'emploi individuelle
    Et ce n'est pas une formation RNCP
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas un contrat de professionnalisation
    Et le niveau de sortie de la formation vaut «inconnu»
    Et ce n'est pas une formation à entrées-sorties permanentes
    Et la durée en semaines de la formation vaut 45
    Et la durée en mois de la formation vaut 10
    Et la durée hebdomadaire de la formation vaut 2
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la montant de l'allocation du bénéficiaire vaut 4000
    Et la date de fin de l'allocation du bénéficiaire vaut «15/12/2018»
    Et la niveau scolaire du bénéficiaire vaut «V»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 4000
    Et le texte de la prise en charge vaut «Formation totalement prise en charge, sous réserve d'acceptation par Pôle emploi»


Scénario: Action collective région
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action collective financée par la Région»
    Alors la rémunération applicable vaut 652.18


Scénario: Mauvais CERTIFINFO pour Action collective région
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 24
    Et la durée en heures de la formation vaut 250
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le code CERTIFINFO de la formation vaut 54912
    Quand je demande un calcul de financement
    Alors le financement «Action collective financée par la Région» n'est pas proposé


Scénario: POEC Bourgogne
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une préparation opérationnelle à l'emploi collective
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 800.0
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et les codes financeur de la formation valent [«OPCO»]
    Et c'est une préparation opérationnelle à l'emploi
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Préparation opérationnelle à l'emploi collective»
    Alors la rémunération applicable vaut 800.0


Scénario: Action collective PE Bourgogne
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 800.0
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et les codes financeur de la formation valent [«Pôle emploi»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action de formation collective financée par Pôle emploi»
    Alors la rémunération applicable vaut 800.0


Scénario: Manque code financeur pour Action collective PE Bourgogne
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 800.0
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Quand je demande un calcul de financement
    Alors le financement «Action de formation collective financée par Pôle emploi» n'est pas proposé


Scénario: Mauvais CERTIFINFO pour Action collective PE Bourgogne
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 800.0
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et les codes financeur de la formation valent [«Pôle emploi»]
    Et le code CERTIFINFO de la formation vaut 87187
    Quand je demande un calcul de financement
    Alors le financement «Action de formation collective financée par Pôle emploi» n'est pas proposé


Scénario: Formation sanitaire et social
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 800.0
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et le code CERTIFINFO de la formation vaut 54913
    Et le SIRET de l'organisme de formation vaut 26890005700061
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Formation sanitaire et social»
    Alors la rémunération applicable vaut 800.0


Scénario: Mauvais SIRET pour formation sanitaire et social
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 800.0
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et le code CERTIFINFO de la formation vaut 54913
    Et le SIRET de l'organisme de formation vaut 26890005700063
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Formation sanitaire et social» n'est pas proposé

Scénario: Cas nominal DAQ
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 800.0
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'intitulé de la formation vaut «Dispositif accès à la qualification»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Dispositif accès à la qualification»
    Alors la rémunération applicable vaut 800.0

Scénario: Cas parent isolé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la durée en heures de la formation vaut 420
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et c'est un parent isolé
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action collective financée par la Région»
    Alors la rémunération applicable vaut 863.0

Scénario: Cas non salarié ayant travaillé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la durée en heures de la formation vaut 420
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et c'est une bénéficiaire non salarié qui a travaillé pendant douze mois dont au moins six mois consécutifs dans les trois ans qui précèdent l'entrée en formation
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action collective financée par la Région»
    Alors la rémunération applicable vaut 708.59

Scénario: Cas bénéficiaire ayant travaillé six mois sur 12 mois
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la durée en heures de la formation vaut 420
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et c'est une bénéficiaire qui a déjà travaillé six mois sur une période de douze mois
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action collective financée par la Région»
    Alors la rémunération applicable vaut 863

Scénario: Cas travailleur handicapé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et l'âge du bénéficiaire vaut 38
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la durée en heures de la formation vaut 420
    Et la région du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la région de la formation vaut «Bourgogne-Franche-Comté»
    Et c'est un travailleur handicapé
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action collective financée par la Région»
    Alors la rémunération applicable vaut 910.02

Scénario: Cas EFFISMO
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 2300
    Et la rémunération du bénéficiaire vaut 4000.0
    Et l'âge du bénéficiaire vaut 39
    Et l'expérience professionnelle du bénéficiaire vaut 48
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et le code NAF de l'établissement du bénéficiaire vaut «2550A»
    Et l'IDCC de l'établissement du bénéficiaire vaut «3043»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «75056»
    Et l'intitulé de la formation vaut «CAP ébéniste»
    Et la commune de la formation vaut «75111»
    Et le SIRET de l'organisme de formation vaut 78449047600032
    Et c'est une formation éligible CPF
    Et c'est une formation éligible COPANEF
    Et la liste des codes ROME de la formation vaut [H2208,H2207]
    Et la liste des codes FORMACODE de la formation vaut [45582]
    Et la liste des domaines FORMACODE de la formation vaut [455]
    Et le code CERTIFINFO de la formation vaut 94681
    Et le code RNCP de la formation vaut 28297
    Et la durée en heures de la formation vaut 1498
    Et le nombre d'heures en entreprise vaut 1036
    Et le nombre d'heures en centre vaut 462
    Et la liste des codes CPF de la formation vaut [243417]
    Et la liste des codes CPF de la formation pour un demandeur d'emploi vaut [243417]
    Et la code AIS de la formation vaut «Certification»
    Et c'est une formation certifiante
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation RNCP
    Et l'OPCO de l'établissement du bénéficiaire vaut «ESSFIMO»
    Et l'OPACIF de l'établissement du bénéficiaire vaut «Fongecif»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors la rémunération applicable vaut 4000
    Et le plafond de prise en charge vaut 2300
    Et l'organisme à contacter est «ESSFIMO»
