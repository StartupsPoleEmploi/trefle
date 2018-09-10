Fonctionnalité: POEC


Scénario: Cas nominal POEC
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une préparation opérationnelle à l'emploi collective
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Préparation opérationnelle à l'emploi collective»
    Alors la rémunération applicable vaut 401.09


Scénario: POEC avec une VAE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une préparation opérationnelle à l'emploi collective
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la montant de l'allocation du bénéficiaire vaut 800
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Préparation opérationnelle à l'emploi collective»
    Alors la rémunération applicable vaut 800


Scénario: Pas de POEC pour une VAE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une préparation opérationnelle à l'emploi collective
    Et c'est une formation VAE
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Préparation opérationnelle à l'emploi collective» n'est pas proposé


Scénario: Formation trop longue pour POEC
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 500
    Et c'est une préparation opérationnelle à l'emploi collective
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Préparation opérationnelle à l'emploi collective» n'est pas proposé

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=6OqWO36nGVeKYcg4TkJiTT0eJiGssmoCQ4ssllQvsssst5CC7Ps4RLkyfoOIbI5vgwj2yQ3Oo4jdvfHVss3ssskr2H6GiuaBK22syiorwiabnW%3D0iUkEPt%3DvJ1LnrLS-1vGsU-VRe9gG6UF2xgbEAsJRZQaCieILT-ooX2kumjoW7U2idwrkA4mNFIB%3Dv1peT8sKS1-h4Bo9gQa1tTOeYj0PM1vGyrQf7QmvvTNMfYtISfcxvCpcFJQOg35stcTY4-24Bj6jr1BpcE%3DyBRKjrL4FbvDnnEeEIWcSC9TigaTV-tQVFRk0vns8B5y4AZHfFt-N6raEfRtT4y5Yy24oEKvjsL7mT8GRojEG-baXfNAvVLsT7Fi6tMF3tWFSme-Kkci39eKs
Scénario: Financement POEC
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 45
    Et la région du bénéficiaire vaut «Normandie»
    Et la département de la formation vaut «Manche»
    Et les codes financeur de la formation valent [16]
    Et c'est une formation éligible COPANEF
    Et la régions éligibles COPAREF vaut [25]
    Et la liste des codes ROME de la formation vaut [H3404]
    Et la liste des codes FORMACODE de la formation vaut [22472,23042,23053]
    Et la liste des domaines FORMACODE de la formation vaut [224,230]
    Et le code CERTIFINFO de la formation vaut 83253
    Et le code RNCP de la formation vaut 6036
    Et la durée en heures de la formation vaut 399
    Et le nombre d'heures en entreprise vaut 70
    Et le nombre d'heures en centre vaut 399
    Et la durée hebdomadaire de la formation vaut 35
    Et le prix horaire de la formation vaut 0.0
    Et la liste des codes CPF de la formation vaut [131136,1317,16973]
    Et la code AIS de la formation vaut «Professionnalisation»
    Et la date de début de la formation vaut «30/04/2018»
    Et la date de fin de la formation vaut «03/08/2018»
    Et ce n'est pas une formation ouverte à distance
    Et c'est une formation certifiante
    Et c'est une préparation opérationnelle à l'emploi collective
    Et ce n'est pas une préparation opérationnelle à l'emploi individuelle
    Et c'est une formation RNCP
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas un contrat de professionnalisation
    Et le niveau de sortie de la formation vaut «aucun»
    Et la modalités d'entrées-sorties vaut «entrées/sorties à dates fixes»
    Et ce n'est pas une formation à entrées-sorties permanentes
    Et la durée en semaines de la formation vaut 14
    Et la durée en mois de la formation vaut 3
    Et c'est une préparation opérationnelle à l'emploi
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et la niveau scolaire du bénéficiaire vaut «V»
    Et la montant de l'allocation du bénéficiaire vaut 4000.0
    Et la date de fin de l'allocation du bénéficiaire vaut «15/12/2018»
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Préparation opérationnelle à l'emploi collective»
    Alors la rémunération applicable vaut 4000.0
