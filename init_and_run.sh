#!/bin/bash

if [[ -d volumes/mysql ]];then
  echo "mysql dir exists. remove and retry it."
  exit 1
fi

if [[ -d volumes/three-d-mind ]];then
  (cd volumes/three-d-mind;git pull)
else
  (mkdir -p volumes && cd volumes && git clone https://github.com/qtamaki/three-d-mind.git)
  if [[ $? -ne 0 ]];then
    echo "git clone faild."
    exit 1
  fi
fi

if [[ -d volumes/sql ]];then
  svn up volumes/sql
else
  (
  mkdir -p volumes
  cd volumes
  svn co --non-interactive --no-auth-cache --username docker --password docker99  https://svn.applicative.jp/svn/projects/Applicative/3dmind/develop/sql/
  )
  if [[ $? -ne 0 ]];then
    echo "svn checkout faild."
    exit 1
  fi
fi

docker run -it -d --name 3dmind-mysql1 3dmind/3dmind-mysql /bin/bash
docker stop 3dmind-mysql1
docker cp 3dmind-mysql1:/var/lib/mysql volumes/
docker rm 3dmind-mysql1
docker run -it -d --name 3dmind-mysql1 -e OWNER_UID=`id -u` -e OWNER_GID=`id -g`  -v `pwd`/3dmind-mysql/tools:/work/tools -v `pwd`/volumes/mysql:/var/lib/mysql 3dmind/3dmind-mysql /bin/bash -x /work/tools/init.sh
echo "sleep..."
sleep 3
# Create databases and users.
docker run -t --name 3dmind1 --rm --link 3dmind-mysql1:db -v `pwd`/tools:/work/tools -v `pwd`/volumes/sql:/work/sql 3dmind/3dmind /bin/bash -x /work/tools/init_db.sh
# TODO load fixtures

# Run the unicorn server.
docker run -it -d --name 3dmind1 --link 3dmind-mysql1:db -e OWNER_UID=`id -u` -e OWNER_GID=`id -g` -p 3000:3000 -v `pwd`/tools:/work/tools -v `pwd`/volumes/three-d-mind:/work/three-d-mind 3dmind/3dmind /bin/bash -x /work/tools/init.sh
docker attach 3dmind1

