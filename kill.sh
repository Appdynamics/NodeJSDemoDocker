#!/bin/bash

for i in $(docker ps -a -q); do docker kill $i && docker rm -f $i; done
for i in $(docker ps -a -q); do docker stop $i && docker rm -f $i; done
