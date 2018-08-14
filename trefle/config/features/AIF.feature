Fonctionnalité: Aide individuelle à la formation


Scénario: Cas nominal national d'un financement AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 30
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un bénéficiaire de droit privé
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Et l'âge du bénéficiaire vaut 30
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 401.09


Scénario: pas d'AIF parce qu'il y a trop d'heures en entreprise
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 31
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
    Et le code CERTIFINFO de la formation vaut 84385
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation artisan»
    Alors la rémunération applicable vaut 0


Scénario: AIF travailleur handicapé
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 30
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un bénéficiaire de droit privé
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Et l'âge du bénéficiaire vaut 30
    Et c'est un travailleur handicapé
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 652.02


Scénario: AIF travailleur handicapé ayant travaillé au moins six mois
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 30
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un bénéficiaire de droit privé
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Et l'âge du bénéficiaire vaut 30
    Et c'est un travailleur handicapé
    Et c'est un bénéficiaire qui a déjà travaillé six mois sur une période de douze mois
    Et le montant de l'allocation du bénéficiaire vaut 758
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 758


Scénario: AIF avec ARE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 30
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un bénéficiaire de droit privé
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Et l'âge du bénéficiaire vaut 30
    Et c'est un travailleur handicapé
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 758
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 758


Scénario: AIF moins de 18 ans
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 30
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un bénéficiaire de droit privé
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Et l'âge du bénéficiaire vaut 17
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 130.34


# Corse
Scénario: AIF Corse
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et le nombre d'heures en centre vaut 100
    Et le nombre d'heures en entreprise vaut 20
    Et la région du bénéficiaire vaut «Corse»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et ce n'est pas un contrat de professionnalisation
    Et ce n'est pas un contrat d'apprentissage
    Et ce n'est pas une préparation opérationnelle à l'emploi collective
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 0
