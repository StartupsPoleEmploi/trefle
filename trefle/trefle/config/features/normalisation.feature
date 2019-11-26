Fonctionnalité: Tests de la normalisation

Scénario: le formation n'est pas RNCP
    Soit un bénéficiaire et une formation
    Et le code RNCP de la formation vaut 0
    Quand je demande un calcul de financement
    Alors ce n'est pas une formation RNCP


Scénario: formation langues
    Soit un bénéficiaire et une formation
    Et la liste des domaines FORMACODE de la formation valent [152]
    Et la liste des codes FORMACODE de la formation valent [15235]
    Quand je demande un calcul de financement
    Alors c'est une formation langues
    Et c'est une formation FLE


Scénario: formation POEC
    Soit un bénéficiaire et une formation
    Et la durée en heures de la formation est 300
    Et les codes financeur de la formation valent [«OPCO»]
    Quand je demande un calcul de financement
    Alors c'est une préparation opérationnelle à l'emploi collective


Scénario: formation enseignement supérieur nouvelle nomenclature niveau
    Soit un bénéficiaire et une formation
    Et le niveau de sortie de la formation est 6
    Quand je demande un calcul de financement
    Alors c'est une formation de l'enseignement supérieur
