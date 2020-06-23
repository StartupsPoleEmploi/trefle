#!/bin/bash

date >> update.log
echo $* >> update.log

echo "[INIT] rebuild"
docker-compose up -d --build --no-deps web \
    || { echo "[FAILED] Can't rebuild web container" | tee -a update.log; exit 1; }

echo "[INIT] refresh access" | tee -a update.log
./update_access.sh \
    || { echo "[FAILED] Can't refresh access" | tee -a update.log; exit 1; } \

echo "[DONE] refresh access" | tee -a update.log \
    && exit 0
