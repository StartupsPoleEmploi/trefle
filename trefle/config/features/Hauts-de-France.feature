Fonctionnalité: Hauts-de-France

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation éligible COPAREF de la région du bénéficiaire
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors le plafond de prise en charge vaut 2500


Scénario: Mauvais code CERTIFINFO pour un financement AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Hauts-de-France»
    Et le code CERTIFINFO de la formation vaut 54913
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation éligible COPAREF de la région du bénéficiaire
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé
