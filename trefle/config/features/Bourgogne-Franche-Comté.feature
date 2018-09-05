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
    Et la région du bénéficiaire vaut «Grand-Est»
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
    Et la modalités d'entrées-sorties vaut «entrées/sorties à dates fixes»
    Et ce n'est pas une formation à entrées-sorties permanentes
    Et la durée en semaines de la formation vaut 161
    Et la durée en mois de la formation vaut 37
    Et la durée hebdomadaire de la formation vaut 3
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation diplômante
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
