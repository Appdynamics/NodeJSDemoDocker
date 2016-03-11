#!/bin/bash

# This is a script to start nodeJS front mobile for online movie on Docker

# Set variables
CONTR_HOST=
CONTR_PORT=
APP_NAME=
TIER_NAME=
NODE_NAME=
CTRLR_ACCOUNT=
CTRLR_KEY=
APPD_VERSION=
VERSION=
MOVIE_TIX=
NODE_APP=

echo "${CONTR_HOST} is the controller name and ${CONTR_PORT} is the controller port"

# Pull images
docker pull appdynamics/nodemobile_redis:nodeRedis
docker pull appdynamics/nodemobile_mongodb:nodeMongo
docker pull appdynamics/nodemobile_app:${VERSION}
docker pull appdynamics/nodemobile_load:latest

# Start containers
docker run -d --name nodemobile_redis -p 6379:6379 appdynamics/nodemobile_redis:nodeRedis
sleep 10

docker run -d --name nodemobile_mongodb -p 27017:27017 --link nodemobile_redis:nodemobile_redis appdynamics/nodemobile_mongodb:nodeMongo

sleep 10

docker run -d --name nodemobile_app -p 3000:3000 -e CONTROLLER=${CONTR_HOST} -e APPD_PORT=${CONTR_PORT} -e ACCOUNT_NAME=${CTRLR_ACCOUNT} -e ACCESS_KEY=${CTRLR_KEY} -e APPD_VERSION=${APPD_VERSION} -e MOVIE_TIX=${MOVIE_TIX} --link nodemobile_redis:nodemobile_redis --link nodemobile_mongodb:nodemobile_mongodb appdynamics/nodemobile_app:${VERSION}

sleep 10

docker run -d --name nodemobile_load -e NODE_APP=${NODE_APP} --link nodemobile_app:nodemobile_app appdynamics/nodemobile_load:latest

exit 0
