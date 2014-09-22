#!/bin/bash

./build.sh

docker push 3dmind/3dmind
docker push 3dmind/3dmind-mysql

