# Hébergement

Trèfle est déployé avec `docker-compose`.

La stack est composé de 4 dockers:
* le docker *trefle* conteneur de l'API
* le docker *trefle-old* conteneur de l'API en version n-1
* le docker *web* conteneur pour le serveur web nginx
* le docker *backup* conteneur pour la sauvegarde du dossier docker (utile pour le .env et authorisations.csv)

Le serveur web expose une interface pas version d'API, chaque interface doit-être compatible avec la version API déployé. Ce sont les variables d'env `TREFLE_VERSION` et `TREFLE_OLD_VERSION` qui indiquent les numéros de version depuis lesquels déployer les interfaces. Ces variables sont renseognées dans le fichier `.gitlab-ci` et dans le fichier `docker-compose.override.yml`.

## pré-requis

* docker-ce
* docker-compose

## Déploiement

1. Cloner le projet : https://git.beta.pole-emploi.fr/open-source/trefle.git
2. Renseigner les variables d'environement :

    VERSION=api-vX.X.X
    OLD_VERSION=api-vX.X.X
    BACK_VERSION=backoffice-vX.X.X
    CATALOG_USER={HERE-YOUR-LBF-CATALOG-API-USER}
    CATALOG_KEY={HERE-YOUR-LBF-CATALOG-API-KEY}
    CATALOG_URL=https://labonneformation.pole-emploi.fr/api/v1/detail
    TREFLE_GIT=https://git.beta.pole-emploi.fr/open-source/trefle.git
    GITLAB_TOKEN={HERE-YOUR-GITLAB-TOKEN}

3. Builder les conteneurs :
    `docker-compose build`
4. Déployer les conteneurs :
    - Avec les images registry (attention dans le gitlab-ci TREFLE_OLD_VERSION sera la version du backoffice de la version n-1) :
        `docker-compose up -d`
    - Build complétement :
        `docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d`

