#!/bin/sh
DATE=`date +%A`
DAY=`date +%d`
DIR="."
TREFLE_DATA="trefle-data_${DAY}.tar.gz"
if [ "$1" ]
then
        DIR="$1"
fi

tar --exclude=data/* --exclude=log/* --exclude=*.tar.gz -czvf $DIR/$TREFLE_DATA /home/docker/*
