#!/bin/sh
DATE=`date +%A`
DAY=`date +%d`
DIR="."
TREFLE_DATA="trefle-data_${DAY}.tar"
if [ "$1" ]
then
        DIR="$1"
fi

tar --exclude=data/* --exclude=log/* -cjvf $DIR/$TREFLE_DATA /home/docker/*
