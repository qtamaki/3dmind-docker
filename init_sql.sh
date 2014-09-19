#!/bin/bash

if [[ -d volumes/sql ]];then
  svn up --non-interactive --no-auth-cache --username docker --password docker99 volumes/sql
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

# Create databases and users.
docker run -t --name 3dmind1 --rm --link 3dmind-mysql1:db -v `pwd`/tools:/work/tools -v `pwd`/volumes/sql:/work/sql 3dmind/3dmind /bin/bash -x /work/tools/init_db.sh

