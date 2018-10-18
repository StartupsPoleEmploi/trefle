Fonctionnalité: Auvergne-Rhône-Alpes

Scénario: cas nominal AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et l'âge du bénéficiaire vaut 30
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Aide individuelle à la formation»
    Alors la rémunération applicable vaut 401.09

Scénario: mauvais FORMACODE pour AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la liste des codes FORMACODE de la formation vaut [43448]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: Formation trop longue pour AIF
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la durée en mois de la formation vaut 14
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide individuelle à la formation» n'est pas proposé


Scénario: cas nominal API
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 22
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et c'est une formation certifiante
    Et la liste des codes FORMACODE de la formation vaut [23007]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Action projets individuels»
    Alors la rémunération applicable vaut 339.35

Scénario: Financement ESUP avec bon SIRET et FORMACODE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 22
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la formation éligible COPAREF de la région du bénéficiaire vaut «True»
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et le SIRET de l'organisme de formation vaut 19691775100014
    Et la liste des codes FORMACODE de la formation vaut [15093]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme Enseignement supérieur»
    Alors la rémunération applicable vaut 0

Scénario: Financement ESUP avec bon SIRET et FORMACODE (2)
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 22
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la formation éligible COPAREF de la région du bénéficiaire vaut «True»
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et le SIRET de l'organisme de formation vaut 34040220500033
    Et la liste des codes FORMACODE de la formation vaut [13017]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme Enseignement supérieur»
    Alors la rémunération applicable vaut 0

Scénario: Mauvais SIRET pour financement ESUP
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 22
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la formation éligible COPAREF de la région du bénéficiaire vaut «True»
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et le SIRET de l'organisme de formation vaut 34040220501033
    Et la liste des codes FORMACODE de la formation vaut [13017]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Programme Enseignement supérieur» n'est pas proposé

Scénario: cas nominal financement CARED
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 22
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et c'est une formation certifiante
    Et c'est une bénéficiaire ayant un contrat aidé en cours
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Contrat d'aide et retour à l'emploi durable»
    Alors la rémunération applicable vaut 339.35

Scénario: Mauvais FORMACODE pour CARED
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 22
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et c'est une formation certifiante
    Et c'est une bénéficiaire ayant un contrat aidé en cours
    Et la liste des codes FORMACODE de la formation vaut [43339]
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Contrat d'aide et retour à l'emploi durable» n'est pas proposé

Scénario: Durée en centre trop longue pour CARED
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 22
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et c'est une formation certifiante
    Et c'est une bénéficiaire ayant un contrat aidé en cours
    Et le nombre d'heures en centre vaut 810
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Contrat d'aide et retour à l'emploi durable» n'est pas proposé

Scénario: financement CARED collectif
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et c'est une formation CARED
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Contrat d'aide et retour à l'emploi durable collectif»
    Alors la rémunération applicable vaut 401.09

Scénario: cas nominal financement PCP
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la département du bénéficiaire vaut «Drôme»
    Et la département de la formation vaut «Drôme»
    Et c'est une formation PCP
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 800
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programmation compétences premières»
    Alors la rémunération applicable vaut 800

Scénario: financement PCP non ARE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la département du bénéficiaire vaut «Drôme»
    Et la département de la formation vaut «Drôme»
    Et c'est une formation PCP
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programmation compétences premières»
    Alors le texte de la rémunération vaut «Renseignez-vous auprès de votre conseiller sur les conditions de rémunération par la Région.»

Scénario: financement PCP sur FORMACODE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la département du bénéficiaire vaut «Drôme»
    Et la département de la formation vaut «Drôme»
    Et la liste des codes FORMACODE de la formation vaut [15061]
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programmation compétences premières»
    Alors la rémunération applicable vaut 0

Scénario: PCP impossible pour département hors ex Rhône-Alpes
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la département du bénéficiaire vaut «Cantal»
    Et la département de la formation vaut «Drôme»
    Et la liste des codes FORMACODE de la formation vaut [15061]
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Alors le financement «Programmation compétences premières» n'est pas proposé

Scénario: financement PCP avec intitulé PCP
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la département du bénéficiaire vaut «Drôme»
    Et la département de la formation vaut «Drôme»
    Et l'intitulé de la formation vaut «PCP»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programmation compétences premières»
    Alors la rémunération applicable vaut 0

Scénario: Mauvais label pour financement PCP
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et la département du bénéficiaire vaut «Drôme»
    Et la département de la formation vaut «Drôme»
    Et l'intitulé de la formation vaut «PCD»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Alors le financement «Programmation compétences premières» n'est pas proposé

Scénario: cas nominal "programme régional qualifiant"
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Quand je demande un calcul de financement
    Et je sélectionne le financement «Programme régional qualifiant»
    Alors la rémunération applicable vaut 401.09


Scénario: "programme régional qualifiant" exclu si pas le bon code financeur
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Quand je demande un calcul de financement
    Alors le financement «Programme régional qualifiant» n'est pas proposé

Scénario: "programme régional qualifiant" exclu si VAE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et le code CERTIFINFO de la formation vaut 83899
    Quand je demande un calcul de financement
    Alors le financement «Programme régional qualifiant» n'est pas proposé

Scénario: Pas de financement "programme régional qualifiant" pour une formation CARED
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et c'est une formation CARED
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Programme régional qualifiant» n'est pas proposé

Scénario: cas nominal financement «projets collectifs régionaux»
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Allier»
    Et la liste des codes FORMACODE de la formation vaut [15031]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Projets collectifs régionaux»
    Alors la rémunération applicable vaut 401.09

Scénario: financement «projets collectifs régionaux» pas possible si la formation n'est pas en ex-Auvergne
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Rhône»
    Et la liste des codes FORMACODE de la formation vaut [15031]
    Quand je demande un calcul de financement
    Alors le financement «Projets collectifs régionaux» n'est pas proposé


Scénario: financement «projets collectifs régionaux» pas possible si le bénéficiaire a un niveau supérieur à bac
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Allier»
    Et la liste des codes FORMACODE de la formation vaut [15031]
    Et le niveau scolaire du bénéficiaire vaut «II»
    Quand je demande un calcul de financement
    Alors le financement «Projets collectifs régionaux» n'est pas proposé

Scénario: "programme sanitaire et social" dans le Cantal
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Cantal»
    Et la liste des codes FORMACODE de la formation vaut [43092]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional sanitaire et social»
    Alors la rémunération applicable vaut 0


Scénario: "programme sanitaire et social" sur SIRET
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la liste des codes FORMACODE de la formation vaut [44028]
    Et le SIRET de l'organisme de formation vaut 19730016300049
    Et l'allocation du bénéficiaire vaut «allocation d'aide au retour à l'emploi»
    Et le montant de l'allocation du bénéficiaire vaut 800
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional sanitaire et social»
    Alors la rémunération applicable vaut 800


Scénario: "Programme régional sanitaire et social - ambulancier" dans la Drôme
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Drôme»
    Et la liste des codes FORMACODE de la formation vaut [31815]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Programme régional sanitaire et social - ambulancier»
    Alors la rémunération applicable vaut 401.09


Scénario: "Programme régional sanitaire et social - ambulancier" dans la Drôme
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région de la formation vaut «Auvergne-Rhône-Alpes»
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et les codes financeur de la formation valent [«Conseil régional»]
    Et la département de la formation vaut «Cantal»
    Et la liste des codes FORMACODE de la formation vaut [31815]
    Et le prix horaire de la formation vaut 0.0
    Quand je demande un calcul de financement
    Alors le financement «Programme régional sanitaire et social - ambulancier» n'est pas proposé

Scénario: Aide à la VAE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et c'est une formation VAE
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Aide à la VAE»
    Alors la rémunération applicable vaut 0
    Et le plafond de prise en charge vaut 1400

Scénario: Aide à la VAE impossible si la formation n'est pas VAE
    Soit un bénéficiaire et une formation
    Et c'est un demandeur d'emploi
    Et le âge du bénéficiaire vaut 38
    Et la durée en heures de la formation vaut 120
    Et la région du bénéficiaire vaut «Auvergne-Rhône-Alpes»
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Aide à la VAE» n'est pas proposé
