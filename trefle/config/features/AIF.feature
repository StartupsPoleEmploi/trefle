Fonctionnalité: Aide individuelle à la formation


Scénario: Cas nominal national d'un financement AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 30
    Et la rémunération du bénéficiaire vaut 1000
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un bénéficiaire de droit privé
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 0


Scénario: pas d'AIF parce qu'il y a trop d'heures en entreprise
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 31
    Et la rémunération du bénéficiaire vaut 1000
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un bénéficiaire de droit privé
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: AIF doit remonter s'il manque les infos d'heures en centre ou entreprise
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et la rémunération du bénéficiaire vaut 1000
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un bénéficiaire de droit privé
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 0


Scénario: AIF bilan de compétences
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et c'est un bilan de compétences
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 0

Scénario: AIF artisan
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et le code CERTIFINFO de la formation vaut 84385
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation artisan»
    Alors la rémunération applicable vaut 0

# Corse
Scénario: AIF Corse
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la rémunération du bénéficiaire vaut 1000
    Et la région du bénéficiaire vaut «Corse»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 0
