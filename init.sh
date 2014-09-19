#!/bin/bash

3dmind-mysql/init_and_run.sh

echo "sleep..."
sleep 3

./init_sql.sh

./init_and_run.sh


