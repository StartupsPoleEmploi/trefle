Fonctionnalité: Aide individuelle à la formation


Scénario: Cas nominal national d'un financement AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 130
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
    Et la durée en heures de la formation vaut 101
    Et le nombre d'heures en centre vaut 70
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


Scénario: AIF avec ARE finissant avant la fin de la formation
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
    Et la date de fin de la formation vaut «04/05/2018»
    Et la date de fin de l'allocation du bénéficiaire vaut «04/04/2018»
    Et la région du bénéficiaire vaut «Île-de-France»
    Et la liste des codes ROME de la formation vaut [«A1101»]
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation artisan» n'est pas proposé
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 758
    Et la RFF applicable vaut 652.02
    Et la date de fin de la RFF applicable vaut «04/05/2018»
    Et la date de début de la RFF applicable vaut «04/04/2018»
    Et la date de fin de la rémunération applicable vaut «04/04/2018»

Scénario: AIF permis B
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 18
    Et la durée en heures de la formation vaut 20
    Et c'est un permis B
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 310.39
    Et le texte de description vaut «Vous pouvez utiliser votre CPF pour financer tout ou partie de votre permis de conduire catégorie B.⏎Pôle emploi peut éventuellement vous apporter un complément de financement.⏎Votre auto-école doit impérativement vous présenter à l'examen de conduite au plus tard six mois après votre inscription.»

Scénario: AIF bilan de compétences
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 18
    Et la durée en heures de la formation vaut 20
    Et c'est un bilan de compétences
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 310.39
    Et le texte de description vaut «L’aide individuelle à la formation professionnelle (AIF) est une aide de Pôle emploi qui vise à financer certains besoins individuels de formation auxquels les achats d’action de formation collectives ne peuvent répondre.⏎L’AIF bilan de compétences finance des préparations de bilan ou d'évaluation des acquis professionnels.»
