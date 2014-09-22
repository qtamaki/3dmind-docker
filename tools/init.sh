#!/bin/bash

service rsyslog start
service postfix start

. /etc/profile
groupadd -g $OWNER_GID owner
if [[ $? -ne 9 ]];then
  useradd -d / -u $OWNER_UID -p '$6$eR60h2j0iFI/6$Rydt2yT0gZaIXpZENV53rAqwDzn.jYYAjQNes33ALBMzxyOwg04AkK7PJAiAhFoitfu6.WVeBTxhU2zvbvKBt0' -g owner -G sudo owner
fi
cd /work/three-d-mind
rm -rf tmp
bundle install
export RAILS_ENV=production
export SECRET_KEY_BASE=`rake secret`
su owner -c ". /etc/profile && rake assets:precompile"
su owner -c ". /etc/profile && rake unicorn:start"
su owner

