#!/bin/bash

# This is a starup script for the MongoDB Docker container

# Start ssh
sudo /etc/init.d/ssh start

# Bind MongoDb
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

# Start MongoDB
mongod --fork --logpath /var/log/mongodb.log --dbpath /var/lib/mongodb --smallfiles

# Import data
mongoimport --db userMobile --collection user --file /appdynamics/data.json
