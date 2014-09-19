#!/bin/bash

if [[ -d volumes/three-d-mind ]];then
  (cd volumes/three-d-mind;git pull)
else
  (mkdir -p volumes && cd volumes && git clone https://github.com/qtamaki/three-d-mind.git)
  if [[ $? -ne 0 ]];then
    echo "git clone faild."
    exit 1
  fi
fi

# Run the unicorn server.
docker run -it -d --name 3dmind1 --link 3dmind-mysql1:db -e OWNER_UID=`id -u` -e OWNER_GID=`id -g` -p 3000:3000 -v `pwd`/tools:/work/tools -v `pwd`/volumes/three-d-mind:/work/three-d-mind 3dmind/3dmind /bin/bash -x /work/tools/init.sh
#docker attach 3dmind1

