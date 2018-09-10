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
    Et c'est une formation certifiante
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
    Et c'est une formation certifiante
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
    Et c'est une formation certifiante
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
    Et c'est une formation certifiante
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 21000
    Et la rémunération applicable vaut 1000


# https://labonneformation.beta.pole-emploi.fr/engager-les-demarches?a=dM2nb5bMGVeKYcg4TkJiTMU80jossH7CQg4QllQysosGt5CCkPs47mQ3m33oP1iiGcuBho87sVYoi3PiIv0jsaiGs2ysyiiGJc4cio2aCAQBJDbRCUePVDn2tS1MTrF%3DSFZhXOMaWIBlCrRmM9dKAb05rJmpjXgwbKMGHq7RmjnGQV2ej2uAexBNTeV-v9AYtX5%3DSR%3DRm9jyCY1RB1nbMBr_Q9KtY1aj3ix223NvxbBPuG-uY-awPxCyt4F0A8M-1d8ThOLNZyF9wxwe8m8snf4vt9UkxcXd1byZyrwy17gvx49Ief4_6kR3k824kybx96r9482HRTArMKZt9m7Mxs-d5XSDvmQyQMHkeTMGoE786WNYWjU4ZrjYrKhunwb-wBc4QxqVIKJ2HIKlAB-IavFSQXF2ZS3lU%3D1BifGNaU80josz
Scénario: Période de professionnalisation sur formation certifiante
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1000.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «1979»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «75056»
    Et le âge du bénéficiaire vaut 31
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et la liste des codes FORMACODE de la formation vaut [42797]
    Et la liste des domaines FORMACODE de la formation vaut [427]
    Et le code CERTIFINFO de la formation vaut 82782
    Et la durée en heures de la formation vaut 350
    Et c'est une formation certifiante
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 10500
    Et la rémunération applicable vaut 1000.0


# https://labonneformation.beta.pole-emploi.fr/engager-les-demarches?a=2L%3DO2d5OGVeKYcg4TkJiTMMFgM9ssH7CQg4QllQyssQGt5CCkPs4EoQ2oYR2iyeNsOmdKyGasavvQ1yRyvm3poeKPk2i2P7s3Jss28Tsm9M6T%3D29v5n55nStp7vSr%3Db3%3DI_MP19YPYKmfVEQYDAKW1LY%3DAfVBMARkKWGfxVkm9nXP3%3DU7ogqQAJxNKjxktP2THNUKZDvkUJWEcV0SMOnq1mYYxSoA1K0hV2hEg90SPwjffjp4QW_PWXBCFkdpfIeeikfYIq275mj0pwmb-QU%3DWaktCobIuM9nWkGWpmK%3DpOWCY47uTnmKamodjVoDyd5LLAQ4ETWJqu270cCjiAJKY7T0LouBGoS4COx3uqD45nEOmJxpApQhPC761BMH10KsC1JQ-B9AkfVvVkPb7XRfN5Sxs%3DAjZSxlU%3D1BifGNaMFgM9z
Scénario: formation non éligible à la période de prof (durée trop courte)
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1250.0
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 150
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 58
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 958
    Et le code NAF de l'établissement du bénéficiaire vaut «9200Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2257»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «78597»
    Et le âge du bénéficiaire vaut 31
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et ce n'est pas une formation éligible COPANEF
    Et la liste des codes FORMACODE de la formation vaut [42879, 21547, 42766]
    Et la liste des domaines FORMACODE de la formation vaut [427, 428, 215]
    Et la durée en heures de la formation vaut 35
    Et le prix horaire de la formation vaut 0
    Et la code AIS de la formation vaut «Certification»
    Et ce n'est pas une formation ouverte à distance
    Et c'est une formation certifiante
    Et ce n'est pas une formation RNCP
    Et le niveau de sortie de la formation vaut «aucun»
    Et la durée en semaines de la formation vaut 52
    Et la durée en mois de la formation vaut 12
    Et la durée hebdomadaire de la formation vaut 1
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Alors le financement «Période de professionnalisation sur son temps de travail» n'est pas proposé


# https://labonneformation.beta.pole-emploi.fr/engager-les-demarches?a=65bS%3DSW3GVeKYcg4TkJiTTTJ-oNssHaCQg4QllQyssQGt5CCkPs4EAoyeNUH6HYNvNUyO7wj4SGasavvQ1yRyvm3poeKGA8B6eefyHeeKy48j-fciTblD2Yh7l2AlX9B9kU8quY%3DeSg3kJK0aGQXVX-qV07wKuuaaPM0oQ%3DowcVkJ9nXroXKAXc-rVxJj%3DJ42wfryV%3D5sJfIaPNKJR2HmwoGSxxZ8VMNZN_prVSiqt2N5EDCWy8ecciQyc%3D1CsbGltalV-UqqttdRakn9PPplpgGhGp3DWmIZH138fTxZfG1-9L4J1NHJv7p90Hxg9mg-3wyBgxxig9s7MX4YnGrKZVpaeimcgHY01JkRsoprwW0P2PQX5x1n-xvNAmQhPxjhJITrh6O-c-vpao2krIa9NeVOoFRfN5Jxs2ZIDOVlrnNr0Rfma9xQHmzet
Scénario: période de prof FAFIH-licence pro
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1250.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 58
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 958
    Et le code NAF de l'établissement du bénéficiaire vaut «9200Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2257»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «78597»
    Et le âge du bénéficiaire vaut 31
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et ce n'est pas une formation éligible COPANEF
    Et la liste des codes FORMACODE de la formation vaut [42766]
    Et la liste des domaines FORMACODE de la formation vaut [427]
    Et le code CERTIFINFO de la formation vaut 42441
    Et le code RNCP de la formation vaut 19773
    Et la durée en heures de la formation vaut 1200
    Et le prix horaire de la formation vaut 0
    Et la liste des codes CPF de la formation vaut [12969]
    Et la code AIS de la formation vaut «Certification»
    Et ce n'est pas une formation ouverte à distance
    Et c'est une formation certifiante
    Et c'est une formation RNCP
    Et le niveau de sortie de la formation vaut «II»
    Et la durée en semaines de la formation vaut 53
    Et la durée en mois de la formation vaut 12
    Et la durée hebdomadaire de la formation vaut 23
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 36000
    Et la rémunération applicable vaut 1250.0
    Alors le financement «Plan de formation sur son temps de travail» n'est pas proposé


Scénario: période de professionnalisation FAFIH - formation partiellement certifiante
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1325.0
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 150
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 54
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 154
    Et le code NAF de l'établissement du bénéficiaire vaut «9200Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «2257»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «95210»
    Et le âge du bénéficiaire vaut 31
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et les codes financeur de la formation valent [10]
    Et c'est une formation éligible COPANEF
    Et la liste des codes FORMACODE de la formation vaut [42797]
    Et la liste des domaines FORMACODE de la formation vaut [427]
    Et le code CERTIFINFO de la formation vaut 82782
    Et le code RNCP de la formation vaut 2561
    Et la durée en heures de la formation vaut 350
    Et c'est une formation certifiante
    Et c'est une formation RNCP
    Et le niveau de sortie de la formation vaut «IV»
    Et la durée en semaines de la formation vaut 12
    Et la durée en mois de la formation vaut 3
    Et la durée hebdomadaire de la formation vaut 29
    Et c'est une formation ouverte aux bénéficiaires individuels
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 10500
    Et la rémunération applicable vaut 1325.0
    Alors le financement «Plan de formation sur son temps de travail» n'est pas proposé
