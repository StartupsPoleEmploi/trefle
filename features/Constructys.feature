Fonctionnalité: Constructys
    Les scénarios de test d'Constructys.

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=bS3u%3DqLuGVeKYcg4TkJiTI8ZPj3ssmWCQ4ssllQysssGt_CC2Ps4c21cBcHavvvNpG33ciusBi31H6HKsssssNf70nBo1iH6vv0jJs28kk4gxeKg6L8K17n3pwyY%3DqYuSHu30VXk91wooGxx9g0cVrbk0AZvhs3Q%3DgvtR%3Do9KtgRrZygTKvPrkrMRypQst2LgZ4w9oPQX4kyGhBs2mF7yWVKse2JKBHY0loPK14I14416JJM-n_ZlXRFX2Ohdq9iVY82FQX5-L2d-Jr0QULdbiUjvcUk3u84-rZNQ1_I0DGp7BQi7t7Hia5YjKo2tgvX4YGjiF2uIarNrdE3HydRJtpVy23hhhBBtyZo33x7hSALCFt9QXnRcwv5wy9Eg5eB_gw4KyT6pa-0-JlqclgqHgXgRGG_FXZG
Scénario: Formation COPANEF
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1400
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 100
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 36
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 36
    Et le code NAF de l'établissement du bénéficiaire vaut «8130Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut 2409
    Et c'est une formation éligible COPANEF
    Et le niveau de sortie de la formation vaut 5
    Et la durée en heures de la formation vaut 2320
    Et la durée en mois de la formation vaut 22
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme tutelle est «Constructys»
    Et le montant de prise en charge vaut 3000
    Et la rémunération vaut 1400
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme tutelle est «Constructys»
    Et le montant de prise en charge vaut 3000
    Et la rémunération vaut 0
