Fonctionnalité: Forco
    Tests de couverture des règles pour Forco.

Scénario: Formation CPF
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut «50»
    Et la rémunération du bénéficiaire vaut «1200»
    Et le âge du bénéficiaire vaut 17
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 12
    Et le nombre de mois travaillés par le bénéficiaire dans la dernière année vaut 4
    Et le type de contrat du bénéficiaire vaut «CDD»
    Et le code NAF de l'établissement du bénéficiaire vaut «9499Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1406»
    Et la région de l'établissement du bénéficiaire vaut «Centre-Val de Loire»
    Et c'est une formation éligible COPANEF
    Et c'est une formation éligible région «Pays de la Loire»
    Et la régions éligibles COPAREF vaut [52]
    Et la liste des codes FORMACODE de la formation vaut [42752]
    Et la liste des domaines FORMACODE de la formation vaut [427]
    Et le code CERTIFINFO de la formation vaut 83257
    Et la durée en heures de la formation vaut 2236
    Et les codes NAF CPNE éligibles vaut [«9499Z»,«5610B»,«7990Z»,«5040Z»,«5621Z»,«5121Z»,«5520Z»,«9321Z»,«5110Z»,«9200Z»,«9329Z»,«9103Z»,«5629B»]
    Et le niveau de sortie de la formation vaut «aucun»
    Et c'est une formation certifiante
    Et la durée en mois de la formation vaut 12
    Et la durée en semaines de la formation vaut 52
    Et la durée hebdomadaire de la formation vaut 43
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Forco»
    Et le plafond de prise en charge vaut 2250
    Et la rémunération applicable vaut 1200
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Forco»
    Et le plafond de prise en charge vaut 2250
    Et la rémunération applicable vaut 0


Scénario: Formation CPF réservée
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut «50»
    Et la rémunération du bénéficiaire vaut «1200»
    Et le âge du bénéficiaire vaut 17
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 12
    Et le nombre de mois travaillés par le bénéficiaire dans la dernière année vaut 4
    Et le type de contrat du bénéficiaire vaut «CDD»
    Et le code NAF de l'établissement du bénéficiaire vaut «9499Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1406»
    Et la région de l'établissement du bénéficiaire vaut «Centre-Val de Loire»
    Et les codes financeur de la formation vaut [4,5,10,16,17]
    Et c'est une formation éligible COPANEF
    Et c'est une formation éligible région «Pays de la Loire»
    Et la régions éligibles COPAREF vaut [52]
    Et la liste des codes FORMACODE de la formation vaut [42752]
    Et la liste des domaines FORMACODE de la formation vaut [427]
    Et le code CERTIFINFO de la formation vaut 83257
    Et la durée en heures de la formation vaut 2236
    Et les codes NAF CPNE éligibles vaut [«9499Z»,«5610B»,«7990Z»,«5040Z»,«5621Z»,«5121Z»,«5520Z»,«9321Z»,«5110Z»,«9200Z»,«9329Z»,«9103Z»,«5629B»]
    Et le niveau de sortie de la formation vaut «aucun»
    Et c'est une formation certifiante
    Et la durée en mois de la formation vaut 12
    Et la durée en semaines de la formation vaut 52
    Et la durée hebdomadaire de la formation vaut 43
    Quand je demande un calcul de financement
    Alors aucun financement n'est proposé


Scénario: Cas nominal d'une période de professionnalisation CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1406»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Et c'est une formation certifiante
    Et la liste des domaines FORMACODE de la formation vaut [345]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Forco»
    Et le plafond de prise en charge vaut 915
    Et la rémunération applicable vaut 1400
