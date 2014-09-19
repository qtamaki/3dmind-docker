#!/bin/bash

for i in `docker ps -a |cut -f 1 -d " "`; do   docker stop $i; done
for i in `docker ps -a |cut -f 1 -d " "`; do   docker rm $i; done

rm -rf 3dmind-mysql/volumes/mysql

