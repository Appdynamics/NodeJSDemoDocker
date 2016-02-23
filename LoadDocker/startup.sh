#!/bin/bash

# Set Environment variables
source /appdynamics/env.sh && sed -i "s/127.0.0.1/${NODE_APP}/g" /appdynamics/startLoad.sh

# Start Load
source /appdynamics/startLoad.sh
