#!/bin/bash

3dmind-mysql/init_and_run.sh
if [[ ! 0 -eq $? ]];then
  exit 1
fi

echo "sleep..."
sleep 3

./init_sql.sh
if [[ ! 0 -eq $? ]];then
  exit 1
fi

./init_and_run.sh
if [[ ! 0 -eq $? ]];then
  exit 1
fi


