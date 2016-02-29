#!/bin/bash

# This is a starup script for the Node app

# Set ENV Variables
source /appdynamics/env.sh

# Edit hosts file
source /appdynamics/env.sh && echo "${MOVIE_TIX} http://api.partner.imdb.com" >> /etc/hosts
source /appdynamics/env.sh && echo "${MOVIE_TIX} http://maps.googleapis.com" >> /etc/hosts
source /appdynamics/env.sh && echo "${MOVIE_TIX} http://api.twitter.com" >> /etc/hosts

# Set Environment variables
source /appdynamics/env.sh && sed -i "s/CONTROLLER/${CONTROLLER}/g" /appdynamics/mobile_movietickets/mobileFront.js
source /appdynamics/env.sh && sed -i "s/APPD_PORT/${APPD_PORT}/g"  /appdynamics/mobile_movietickets/mobileFront.js
source /appdynamics/env.sh && sed -i "s/ACCOUNT_NAME/${ACCOUNT_NAME}/g" /appdynamics/mobile_movietickets/mobileFront.js
source /appdynamics/env.sh && sed -i "s/ACCESS_KEY/${ACCESS_KEY}/g" /appdynamics/mobile_movietickets/mobileFront.js
source /appdynamics/env.sh && sed -i "s/APP_NAME/${APP_NAME}/g" /appdynamics/mobile_movietickets/mobileFront.js
source /appdynamics/env.sh && sed -i "s/TIER_NAME/${TIER_NAME}/g" /appdynamics/mobile_movietickets/mobileFront.js
source /appdynamics/env.sh && sed -i "s/NODE_NAME/${NODE_NAME}/g" /appdynamics/mobile_movietickets/mobileFront.js
source /appdynamics/env.sh && sed -i "s/MOVIE_TIX/${MOVIE_TIX}/g" /appdynamics/mobile_movietickets/mobileRoutes.js

#source /appdynamics/mobile_movietickets/env.sh && sed -i "s/MOBILE_MOVIE_TIX/${MOBILE_MOVIE_TIX}/g" /appdynamics/mobile_movietickets/mobileFront.js

# Install AppDynamics
cd /appdynamics/mobile_movietickets && npm install appdynamics@${APPD_VERSION}


# Start Node App
source /appdynamics/mobile_movietickets/start.sh

# Start Machine Agent
source $MACHINE_AGENT_HOME/startMachineAgent.sh

exit 0
