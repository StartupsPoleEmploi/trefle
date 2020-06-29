#!/bin/bash

OPTION=$1

date >> update.log
echo $* >> update.log

if [ -n "$OPTION" ]
then
    if [ "$OPTION" == "build-recreate" ]
    then
        echo "[INIT] Force rebuild and recreate new container" | tee -a update.log
        docker-compose up -d --build --force-recreate \
            || { echo "[FAILED] Can't rebuild and recreate container - try ./restart_stack.sh build-local" | tee -a update.log; exit 1; }
        echo "[DONE] All container rebuilt and restarted" | tee -a update.log
    elif [ "$OPTION" == "build-local" ]
    then
        echo "[INIT] Force rebuild locally and recreate new container" | tee -a update.log
        docker-compose -f docker-compose.yml -f docker-compose.override-build.yml up -d --build --force-recreate \
            || { echo "[FAILED] Can't rebuild and recreate container localy - try ./restart_stack.sh restart-docker" | tee -a update.log; exit 1; }
        echo "[DONE] All container locally rebuilt and restarted" | tee -a update.log
    elif [ "$OPTION" == "restart-docker" ]
    then
        echo "[INIT] Force restart docker" | tee -a update.log
        systemctl restart docker.service && ./restart_stack.sh \
            || { echo "[FAILED] Can't restart docker service and rebuild trefle stack" | tee -a update.log; exit 1; }
        echo "[DONE] Docker service restarted" | tee -a update.log
    fi
else
    echo "[INIT] restart container" | tee -a update.log
    docker-compose restart \
        || { echo "[FAILED] Can't restart container - try ./restart_stack.sh build-recreate" | tee -a update.log; exit 1; }
    echo "[DONE] All container restarted" | tee -a update.log
fi

./update_access.sh

exit 0;
