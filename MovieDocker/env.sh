#!/bin/bash

if [ -z "${CONTROLLER}" ]; then
        export CONTROLLER="controller";
fi

if [ -z "${APPD_PORT}" ]; then
        export APPD_PORT=8090;
fi

if [ -z "${APP_NAME}" ]; then
        export APP_NAME="Movie Tickets Online";
fi

if [ -z "${TIER_NAME}" ]; then
        export TIER_NAME="MobileFront";
fi

if [ -z "${NODE_NAME}" ]; then
        export NODE_NAME="movieMobile-0";
fi

if [ -z "${ACCOUNT_NAME}" ]; then
        export ACCOUNT_NAME="customer1";
fi

if [ -z "${ACCESS_KEY}" ]; then
        export ACCESS_KEY="access_key";
fi

if [ -z "${APPD_VERSION}" ]; then
        export APPD_VERSION="4.2.0";
fi

if [ -z "${MOVIE_TIX}" ]; then
        export MOVIE_TIX="localhost";
fi

if [ -z "${MONGO_URL}" ]; then
        export MONGO_URL="nodemobile_mongodb";
fi

if [ -z "${REDIS_URL}" ]; then
        export REDIS_URL="nodemobile_redis";
fi

if [ -z "${MACHINE_PATH_1}" ]; then 
        export MACHINE_PATH_1=Movie-Tickets-Online
fi

if [ -z "${MACHINE_PATH_2}" ]; then 
        export MACHINE_PATH_2=MobileFront
fi
