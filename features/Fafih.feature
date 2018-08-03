Fonctionnalité: Fafih
    Les scénarios de tests Fafih.

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=56WbdWSnGVeKYcg4TkJiTGrhDwQssHVCQRssoscl_RMss4RlSOOjasoh9YcGm2PiHei2iBP74e0jQ7dN1vvPGvsRYYy4aQUHj0e8iIyPB6vG3s4KTfoDD1SfFCFlDQtRPObWpas_qdE%3DmBKH3vCyvfoGrGvmYi7qyVBr4HIQ2qsJHm1G%3DcmDJmfN%3D1shaVws3W3BWc1p4TgVg%3DRUjoe-HGfTcDHySRYjRMuv9HsqdIHGckcX0MQTSNsi34o4Lx55xqh3slFrDnA7QGLq5tFiYgotg9kbCsTJbG07GP5XpXxrtEikIfLm5rvvaGMyfQV990fIUDwsZ1EojvLjuWQYdTeWeKk-7-ZGuTaaNmPrmTBfmyrrAwU-cN7VZf_WFpTgBfI_xkmj579xkUsmlmQR%3D1ZhPsj2iF5e3sY%3DiGjXKxsdIIDU8lgqHgXgRGR7uMds
Scénario: Cas d'un permis B
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1600
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 120
    Et le type de contrat du bénéficiaire vaut «CDD»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 48
    Et le nombre de mois travaillés par le bénéficiaire dans la dernière année vaut 12
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 12
    Et le code NAF de l'établissement du bénéficiaire vaut «5510Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut 800
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et la domaine FORMACODE langues vaut 152
    Et c'est une formation éligible COPANEF
    Et le niveau de sortie de la formation vaut «aucun»
    Et la durée en heures de la formation vaut 31.0
    Et c'est un permis B
    Et la durée en mois de la formation vaut 12
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 750
    Et la rémunération applicable vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 750
    Et la rémunération applicable vaut 0

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=%3D2qS6Ln6GVeKYcg4TkJiTI_EBDGssHeCQRssoscl_RMss4RlSOOjasoh9TfKPiHaIOYHcii2JGpu8usYsvr0jd7JyfKsssyvfYkpQ3dN34KscucOUoD8C1RMt1EqMOOy5jFRsYe9jJ-Tp0kJ3yHoGQ4m54uuFtyoN4I1x%3DaHs7kkQAVcK6PsQaIpQ2NUIYwD4vj2yLvkkUJ5%3D3cvgIHGPIeudgKIIuN_LWacPgKYsm-kEhr42vG4Bqsrsh-33UueLacxv6lDojf-uteCINBDXFjkEllG_Jbsnr-DjM-%3DKrtwEHvgjyrF1NKXRG-%3D2Vm-jpZEsZ9IrjJUdVusLqwsSedk-7WTj2jb7mByWfMPRmYgo210NorgrtZeB32SccA8CKoyMynEDG44_7sRq2LH-1y3VqkONsYMcGj1IJQHB%3DgOJCWFSme-KkRCgKZK
Scénario: Cas d'un bilan de compétences
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1600
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 120
    Et le type de contrat du bénéficiaire vaut «CDD»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 48
    Et le nombre de mois travaillés par le bénéficiaire dans la dernière année vaut 12
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 12
    Et le code NAF de l'établissement du bénéficiaire vaut «5510Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut 800
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et la domaine FORMACODE langues vaut 152
    Et c'est une formation éligible COPANEF
    Et le niveau de sortie de la formation vaut «aucun»
    Et la durée en heures de la formation vaut 24
    Et c'est un bilan de compétences
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 960
    Et la rémunération applicable vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 960
    Et la rémunération applicable vaut 0


Scénario: Cas nominal d'une période de professionnalisation
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «800»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 10
    Et c'est une formation qualifiante
    Et la liste des domaines FORMACODE de la formation vaut [427]
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 3000
    Et la rémunération applicable vaut 1400


# https://labonneformation.beta.pole-emploi.fr/engager-les-demarches?a=LM5CC32uGVeKYcg4TkJiTALYNwsssH7CQg4QllQysssGtqCCkPs47LoyfyQm32vuopOBKGdIpkefYHeyQsJsssoejyjdiIJyQsssY8ypmhEOBE96FV8UO8uTgjZy%3D_jEZ3e3993LPKRmTiWcMmkhRHcq3MmdOqp9-pyveX--v7bfowJBIQj9eVpA4ryAY8waW8kiYRXDm7DRrTWr1q2hfrVT%3DkEtHGekL1viec5a%3DoaY7Wyc2FVhq49Y1CIf4EnD5FiDyFxvUwVYGMxFogVOyHS8geLZA_IHKMa3IEHn-_ji-Mqy7cX4wFWKrfbNjq43sHnBsV2eaKWJeIXISyG-2lfrZioscGaopx1q0o4fMplxRQDrdak5SuewgV1Ila4QfQhEEU3K9jekVcY7s7EH9MR3abqDvtbDMNIWIH4TxJ4-
Scénario: Période de professionnalisation CQP hydrotechnicien
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1500.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1979»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «21231»
    Et le âge du bénéficiaire vaut 31
    Et la région de l'établissement du bénéficiaire vaut «Bourgogne-Franche-Comté»
    Et la liste des codes FORMACODE de la formation vaut [43418]
    Et la liste des domaines FORMACODE de la formation vaut [434]
    Et le code CERTIFINFO de la formation vaut 80019
    Et la durée en heures de la formation vaut 693
    Et le prix horaire de la formation vaut 0
    Et c'est une formation qualifiante
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 20790
    Et la rémunération applicable vaut 1500.0


# https://labonneformation.beta.pole-emploi.fr/engager-les-demarches?a=%3DbnO662OGVeKYcg4TkJiTJ1Oi7-ssH%3DCQRssIycl_RMsG4RlJOO7asohIG2vHeKmaj2de6frdI-GbKyYY4KsJYsJyvfr2aoeKveNBKRcBK-ocio8j-MnEDGEbOFvT%3DtFYtx5B3ABXFje50f%3DVGNSMsS-OXDFHwF%3DhD7fIfrB-fO9Coc97wHo-NBZMtT5d2X8orkMLro4gnmk1Sh2soyo01ABCG-QKccwT6wt97MFgMREeK0h293jA9l1xwYacIU4Q3_qwrlweDW%3DlMibDrH6%3DOhYhD7UEh4bUq8jRFEmyaubo7ApJxqD1LyYc7YiIEYvcTXV3mZdGZgUL-%3DmpoAIKZskqrWkWAMrPwRKQeimRSnTtASRm4yooeIU0os5u5nGxvQIU4VUVyKNTLHpnc4qispV_QV7yTRA780KW7yiJwaG3uVCdwQDMNIWIHRMtI19
Scénario: Période de professionnalisatoin CQP pizzaïolo
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1000
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1979»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «75056»
    Et le âge du bénéficiaire vaut 31
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et la liste des codes FORMACODE de la formation vaut [42704]
    Et la liste des domaines FORMACODE de la formation vaut [427]
    Et le code CERTIFINFO de la formation vaut 83262
    Et la durée en heures de la formation vaut 380
    Et c'est une formation qualifiante
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 11400
    Et la rémunération applicable vaut 1000


# https://labonneformation.beta.pole-emploi.fr/engager-les-demarches?a=6MO3qWbOGVeKYcg4TkJiTMVgHDmssHaCQg4QllQysosGt5CCkPs47LoyfyvQQuyvQ22yQ0VskehmuYms3sYssskvKHN30jYss2ss3_A4gf05o__0sDCpDCrFEBDXbSjni7qEfBNCVQRmpS%3DsjfD8X4Sg44YL0SFQJ3IwiaRpmJpVH3nTIjU4oStgulRF2srRea9hrcsUNdToMfDjVLLBTIf7Q_1ao6MSBfmVYqmp6Kp2gGpYqBu2bTU6Hnvyih6uxunNZyF9wxwe8mX-lsGpZnaIj-U09FOZW3GWuBG95pYFkVNw51GArBnG7GFa6FKZsi5rGVfI07EnjrR0a-EwhFhASrm4KwRIjDxrsfpBlDofd7Eqvk9I2Rm9h3xb-y7yReLdBkd1KVRc93ws09vFMAc877b3lrnNr0RfmJ77kFGz
Scénario: période de professionnalisation gouvernant en hôtellerie
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1000.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1979»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «75056»
    Et le âge du bénéficiaire vaut 31
    Et la liste des codes FORMACODE de la formation vaut [42797]
    Et la liste des domaines FORMACODE de la formation vaut [427]
    Et le code CERTIFINFO de la formation vaut 82782
    Et le code RNCP de la formation vaut 2561
    Et la durée en heures de la formation vaut 700
    Et c'est une formation RNCP
    Et le niveau de sortie de la formation vaut «IV»
    Et c'est une formation qualifiante
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 21000
    Et la rémunération applicable vaut 1000
