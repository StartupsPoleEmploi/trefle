#!/bin/bash
docker cp authorisations.csv `docker ps -n 1 --filter "name=_trefle_" -q`:/srv/.
docker container exec -it `docker ps -n 1 --filter "name=_trefle_" -q` /bin/bash /srv/start.sh
