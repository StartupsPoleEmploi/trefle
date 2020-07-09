#!/bin/bash

SERVICE_NAME=${1?"Usage: ./update_api.sh [trefle|trefle-old]"}

date >> update.log
echo $* >> update.log

echo "[INIT] Scaling $SERVICE_NAME up"
docker-compose up -d --scale $SERVICE_NAME=2 --no-recreate $SERVICE_NAME \
    || { echo "[FAILED] Can't scale $SERVICE_NAME" | tee -a update.log; exit 1; } \
    && LAST_DOCKERID=$(docker ps -ql)

until [[ $(docker ps -q -f "health=healthy" -f "id=$LAST_DOCKERID") ]]; do
    echo "[WAIT] New instance is healthy"
    sleep 1;
done
echo "[DONE] New container healthy" | tee -a update.log

echo "[INIT] Remove older container $SERVICE_NAME"
docker stop $(docker ps -n 2 --filter "name=_${SERVICE_NAME}_" -q | tail -1) && docker container prune -f
echo "[DONE] Remove older container" | tee -a update.log

echo "[INIT] Scaling $SERVICE_NAME down"
docker-compose up -d --scale $SERVICE_NAME=1 --no-recreate $SERVICE_NAME
echo "[DONE] Scaling down" | tee -a update.log \

echo "[INIT] Update access"
sh ./update_access.sh
echo "[DONE] update access" | tee -a update.log \
    && exit 0
