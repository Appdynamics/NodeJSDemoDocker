#/bin/bash

VERSION=nodemobileApp

# Pull images
docker pull appdynamics/nodemobile_redis:nodeRedis
docker pull appdynamics/nodemobile_mongodb:nodeMongo
docker pull appdynamics/nodemobile_app:${VERSION}
