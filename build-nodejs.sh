#!/bin/bash

# Set build version
VERSION=staging

cleanUp() {
  rm -rf MovieDocker/MachineAgent.zip 

  # Cleanup temp dirs
  rm -rf .appdynamics

#  # Remove dangling images left-over from build
#  if [[ `docker images -q --filter "dangling=true"` ]]
#  then
#    echo
#    echo "Deleting intermediate containers..."
#    docker images -q --filter "dangling=true" | xargs docker rmi;
#  fi
}
trap cleanUp exit

buildContainers() {
  echo; echo "Building container: nodemobile_app"
  (cd MovieDocker; docker build -t appdynamics/nodemobile_app:${VERSION} .) || exit $?
}

copyAgents() {
  echo "Copying agent installers"
  cp .appdynamics/MachineAgent.zip MovieDocker/
}

# Usage information
if [[ $1 == *--help* ]]
then
  echo "Specify agent locations: build-nodejs.sh
          -m <Path to Machine Agent>
          [-b Build nodemobile_app image]"
  echo "Prompt for agent locations: build-nodejs.sh"
  exit
fi

# Temp dir for installers
mkdir -p .appdynamics

# Prompt for location of Controller and EUEM Installers if called without arguments
if  [ $# -eq 0 ]
then   
    read -e -p "Enter path to Machine Agent Installer: " MA_INSTALL
    cp ${MA_INSTALL} .appdynamics/MachineAgent.zip
else
  # Download latest NodeJS Agent, MA, and JA Installers from download.appdynamics.com
  # Requires an AppDynamics portal login: prompt user for email/password
  if [[ $1 == *--download* ]]
  then
    # Requires an AppDynamics portal login to download AppServer, Machine and DB Agents

    echo "Please Sign In to download agent..."
    echo "Email ID/UserName: "
    read USER_NAME

    stty -echo
    echo "Password: "
    read PASSWORD
    stty echo

    if [ "$USER_NAME" != "" ] && [ "$PASSWORD" != "" ];
    then
        wget --save-cookies cookies.txt  --post-data "username=$USER_NAME&password=$PASSWORD" --no-check-certificate https://login.appdynamics.com/sso/login/

        echo "Downloading Machine Agent..."
        wget --load-cookies cookies.txt https://download.appdynamics.com/onpremise/public/latest/MachineAgent.zip -O .appdynamics/MachineAgent.zip
        if [ $? -ne 0 ]; then
            rm cookies.txt index.html*
            exit 
        fi
        MA_INSTALL=".appdynamics/MachineAgent.zip"
    else
        echo "Username or Password missing"
    fi

    # Clean up - remove cookies and index.html
    rm cookies.txt index.html*

  else

    # Allow user to specify locations of NodeJS, Machine and Java Agent Installers
    while getopts "m:base" opt; do
      case $opt in
        m)
          MA_INSTALL=$OPTARG
          if [ ! -e ${MA_INSTALL} ]
          then
            echo "Not found: ${MA_INSTALL}"
            exit
          fi
          cp ${MA_INSTALL} .appdynamics/MachineAgent.zip
          ;;
        b)
          BUILD_BASE=true
          ;;
        \?)
          echo "Invalid option: -$OPTARG"
          ;;
      esac
    done

  fi

fi

copyAgents
buildContainers
cleanUp
