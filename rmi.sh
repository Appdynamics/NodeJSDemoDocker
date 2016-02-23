#!/bin/bash

docker images -q --filter "dangling=true" | xargs docker rmi

#exit 0
