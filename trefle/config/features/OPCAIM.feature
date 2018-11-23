Fonctionnalité: OPCAIM
    Tests de couverture des règles pour OPCAIM.


Scénario: période de professionnalisation CDI
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «914»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 1
    Et la liste des domaines FORMACODE de la formation vaut [316]
    Et c'est une formation certifiante
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors l'organisme à contacter est «OPCAIM»
    Et le plafond de prise en charge vaut 3200
    Et la rémunération applicable vaut 1400


Scénario: formation non certifiante
    Soit un bénéficiaire et une formation
    Et c'est un bénéficiaire de droit privé
    Et la rémunération du bénéficiaire vaut 1400
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'IDCC de l'établissement du bénéficiaire vaut «914»
    Et la durée en heures de la formation vaut 100
    Et la durée en mois de la formation vaut 1
    Et la liste des domaines FORMACODE de la formation vaut [316]
    Quand je demande un calcul de financement
    Alors le financement «Période de professionnalisation sur son temps de travail» n'est pas proposé


# https://labonneformation-trefle.beta.pole-emploi.fr/engager-les-demarches?a=S2M5S5LOGVeKYcg4TkJiTJsosAQssmjCQg4QllQysosGt5CCkPs4coQ37L72YiyBYyfN32ymysyiiGJc4cio2aRI3vGveK2Gs5N3sa0FHsZ99BZc8B7Uj-ZMQvV0YPSix1jKFp3-hmoXXsdF4UtUOEIn9Rphi0cojbX1ANuZG9Av4oKMnDjK5BBhpIx4fiyhWRyfJTwf0w-0dLu0CkF6Mb1EjrC7OJreJ2Pw9QyC2a4SMqqLXHubq_Mg0u_8qELFg0Y%3Dv%3DkYobiHv%3DGtL3pQKtCtHTZhQwUBG6VbW0V420FoT4n9iUIJ1N6c87yO4R6mB-99ryI6c7cZAWJuVos07yTTvvE9n2D6IwY4kShKP9HghUp6a4uG4vL1o0gNVrwqHKK1YPvLMmhOplU%3D1BifGNHsosAQ
Scénario: est salarié OPCAIM période de professionnalisation FORMACODE 316 certifiante
    Soit un bénéficiaire et une formation
    Et la rémunération du bénéficiaire vaut 1800.0
    Et c'est un bénéficiaire de droit privé
    Et le type de contrat du bénéficiaire vaut «CDI»
    Et l'expérience professionnelle du bénéficiaire dans les cinq dernières années vaut 20
    Et l'ancienneté en mois du bénéficiaire dans son entreprise vaut 3
    Et le code NAF de l'établissement du bénéficiaire vaut «2511Z»
    Et l'IDCC de l'établissement du bénéficiaire vaut «914»
    Et le code INSEE de la commune de l'établissement du bénéficiaire vaut «75056»
    Et le âge du bénéficiaire vaut 28
    Et la région de l'établissement du bénéficiaire vaut «Île-de-France»
    Et la département de la formation vaut «Isère»
    Et les codes financeur de la formation valent [10]
    Et c'est une formation éligible COPANEF
    Et la liste des codes ROME de la formation vaut [I1302,I1304]
    Et la liste des codes FORMACODE de la formation vaut [31624]
    Et la liste des domaines FORMACODE de la formation vaut [316]
    Et le code CERTIFINFO de la formation vaut 93637
    Et le code RNCP de la formation vaut 2469
    Et la durée en heures de la formation vaut 1400
    Et le nombre d'heures en entreprise vaut 280
    Et le nombre d'heures en centre vaut 1120
    Et le prix horaire de la formation vaut 0.0
    Et la liste des codes CPF de la formation vaut [222848,215268,222278,215335,215485]
    Et c'est une formation certifiante
    Et c'est un contrat de professionnalisation
    Et le niveau de sortie de la formation vaut «III»
    Et ce n'est pas une formation à entrées-sorties permanentes
    Et la durée en semaines de la formation vaut 37
    Et la durée en mois de la formation vaut 8
    Et la durée hebdomadaire de la formation vaut 38
    Et c'est une formation ouverte aux bénéficiaires individuels
    Et c'est une formation de l'enseignement supérieur
    Quand je demande un calcul de financement
    Quand je sélectionne le financement «Période de professionnalisation sur son temps de travail»
    Alors la rémunération applicable vaut 1800.0
    Et la plafond de prise en charge vaut 44800.0
    Et l'organisme à contacter est «OPCAIM»
