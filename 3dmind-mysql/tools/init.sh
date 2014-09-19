#!/bin/bash

groupadd -g $OWNER_GID owner
if [[ $? -ne 9 ]];then
useradd -u $OWNER_UID -p '$6$eR60h2j0iFI/6$Rydt2yT0gZaIXpZENV53rAqwDzn.jYYAjQNes33ALBMzxyOwg04AkK7PJAiAhFoitfu6.WVeBTxhU2zvbvKBt0' -g owner -G sudo owner
chown owner -R /var/run/mysqld /var/log/mysql*
cp /work/tools/my.cnf /etc/mysql/
fi
service mysql start

/bin/bash

