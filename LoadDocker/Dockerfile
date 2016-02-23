FROM ubuntu

MAINTAINER Jeff Morgan (jeff.morgan@appdynamics.com)

################## BEGIN INSTALLATION ######################

# Update the repository sources list
RUN apt-get update

# Install node
RUN \
  apt-get install -y wget && \
  cd /opt && \
  wget http://nodejs.org/dist/v0.10.40/node-v0.10.40-linux-x64.tar.gz && \
  tar -xzf node-v0.10.40-linux-x64.tar.gz && \
  mv node-v0.10.40-linux-x64 node && \
  cd /usr/local/bin && \
  ln -s /opt/node/bin/* . && \
  rm -f /opt/node-v0.10.40-linux-x64.tar.gz

# Install apache2-utils 
RUN apt-get -y install apache2-utils

# Create appdynamics dir
RUN mkdir /appdynamics

# Add load gen and startup scripts
ADD /startLoad.sh /appdynamics/
RUN chmod 777 /appdynamics/startLoad.sh
ADD /env.sh /appdynamics/
RUN chmod 777 /appdynamics/env.sh
ADD /startup.sh /appdynamics/
RUN chmod 777 /appdynamics/startup.sh

##################### INSTALLATION END #####################

# Set environment variables and start the app
CMD /appdynamics/startup.sh && tail -F /var/log/dmesg
