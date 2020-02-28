#!/bin/bash

echo "[INIT] Scaling trefle up"
docker-compose up -d --scale trefle=2 --no-recreate trefle
echo "[INIT] Remove older continer trefle"
docker stop $(docker ps -n 2 --filter "name=trefle_" -q | tail -1) && docker container prune -f
echo "[INIT] Scaling trefle down"
docker-compose up -d --scale trefle=1 --no-recreate trefle
