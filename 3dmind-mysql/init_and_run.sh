#!/bin/bash

cd `dirname $0`

if [[ -d volumes/mysql ]];then
  echo "mysql dir exists. remove and retry it."
  exit 1
fi

docker pull 3dmind/3dmind-mysql
docker run -it -d --name 3dmind-mysql1 3dmind/3dmind-mysql /bin/bash
docker stop 3dmind-mysql1
docker cp 3dmind-mysql1:/var/lib/mysql volumes/
docker rm 3dmind-mysql1
docker run -it -d --name 3dmind-mysql1 -e OWNER_UID=`id -u` -e OWNER_GID=`id -g` -p 3306:3306 -v `pwd`/tools:/work/tools -v `pwd`/volumes/mysql:/var/lib/mysql 3dmind/3dmind-mysql /bin/bash -x /work/tools/init.sh

