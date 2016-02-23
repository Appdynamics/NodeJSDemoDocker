#/bin/bash

# Push images
docker push appdynamics/nodemobile_redis:nodeRedis
docker push appdynamics/nodemobile_mongodb:nodeMongo
docker push appdynamics/nodemobile_app:nodemobileApp
docker push appdynamics/nodemobile_load:latest
