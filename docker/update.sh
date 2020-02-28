#!/bin/bash

echo "[INIT] Scaling trefle up"
docker-compose up -d --scale trefle=2 --no-recreate trefle && \
LAST_DOCKERID=$(docker ps -ql)
until [[ $(docker ps -q -f "health=healthy" -f "id=$LAST_DOCKERID") ]]; do
	echo "[WAIT] New instance is healthy"
	sleep 1;
done
echo "[DONE] New container healthy"
echo "[INIT] Remove older container trefle"
docker stop $(docker ps -n 2 --filter "name=trefle_" -q | tail -1) && docker container prune -f
echo "[DONE] Remove older container"
echo "[INIT] Scaling trefle down"
docker-compose up -d --scale trefle=1 --no-recreate trefle
echo "[DONE] Sclaling down"
docker-compose ps
