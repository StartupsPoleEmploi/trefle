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
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 12
    Et le code NAF de l'établissement du bénéficiaire vaut «5510Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut 800
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et la deux fois le SMIC vaut 2997
    Et la trois fois le SMIC vaut 2997
    Et la domaine FORMACODE langues vaut 152
    Et c'est une formation éligible COPANEF
    Et le niveau de sortie de la formation vaut 1.0
    Et la durée en heures de la formation vaut 31.0
    Et c'est un permis B
    Et la durée en mois de la formation vaut 12
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 750
    Et la rémunération vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 750
    Et la rémunération vaut 0

# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=%3D2qS6Ln6GVeKYcg4TkJiTI_EBDGssHeCQRssoscl_RMss4RlSOOjasoh9TfKPiHaIOYHcii2JGpu8usYsvr0jd7JyfKsssyvfYkpQ3dN34KscucOUoD8C1RMt1EqMOOy5jFRsYe9jJ-Tp0kJ3yHoGQ4m54uuFtyoN4I1x%3DaHs7kkQAVcK6PsQaIpQ2NUIYwD4vj2yLvkkUJ5%3D3cvgIHGPIeudgKIIuN_LWacPgKYsm-kEhr42vG4Bqsrsh-33UueLacxv6lDojf-uteCINBDXFjkEllG_Jbsnr-DjM-%3DKrtwEHvgjyrF1NKXRG-%3D2Vm-jpZEsZ9IrjJUdVusLqwsSedk-7WTj2jb7mByWfMPRmYgo210NorgrtZeB32SccA8CKoyMynEDG44_7sRq2LH-1y3VqkONsYMcGj1IJQHB%3DgOJCWFSme-KkRCgKZK
Scénario: Cas d'un bilan de compétences
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1600
    Et c'est un bénéficiaire de droit privé
    Et le solde CPF du bénéficiaire vaut 120
    Et le type de contrat du bénéficiaire vaut «CDD»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 48
    Et le nombre de mois travaillés par le bénéficiaire dans la dernière année vaut 12
    Et l'ancienneté du bénéficiaire dans son entreprise vaut 12
    Et le code NAF de l'établissement du bénéficiaire vaut «5510Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut 800
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et la deux fois le SMIC vaut 2997
    Et la trois fois le SMIC vaut 2997
    Et la domaine FORMACODE langues vaut 152
    Et c'est une formation éligible COPANEF
    Et le niveau de sortie de la formation vaut 1.0
    Et la durée en heures de la formation vaut 24.0
    Et c'est un bilan de compétences
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «CPF sur son temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 2000
    Et la rémunération vaut 1600
    Quand je sélectionne le financement «CPF hors temps de travail»
    Alors l'organisme à contacter est «Fafih»
    Et le plafond de prise en charge vaut 2000
    Et la rémunération vaut 0
