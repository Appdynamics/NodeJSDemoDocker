FROM ubuntu

MAINTAINER Gabriella Querales gabriella.querales@appdynamics.com)

################## BEGIN INSTALLATION ######################

# Update the repository sources list
RUN apt-get update

# Install npm
RUN \ 
  apt-get install -y wget && \
  cd /opt && \
  wget http://nodejs.org/dist/v0.10.40/node-v0.10.40-linux-x64.tar.gz && \
  tar -xzf node-v0.10.40-linux-x64.tar.gz && \
  mv node-v0.10.40-linux-x64 node && \
  cd /usr/local/bin && \
  ln -s /opt/node/bin/* . && \
  rm -f /opt/node-v0.10.40-linux-x64.tar.gz
RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y unzip
RUN apt-get install -y default-jre

#n Add app source
ADD /mobile_movietickets /appdynamics/mobile_movietickets

# Install app dependencies
RUN cd /appdynamics/mobile_movietickets && npm install

# Install Machine Agent
ENV MACHINE_AGENT_HOME /appdynamics/MachineAgent
ADD /MachineAgent.zip /appdynamics/
RUN mkdir /appdynamics/MachineAgent
RUN unzip -o -d /appdynamics/MachineAgent /appdynamics/MachineAgent.zip
ADD /startMachineAgent.sh /appdynamics/MachineAgent/
RUN chmod 777 /appdynamics/MachineAgent/startMachineAgent.sh
ADD /killMachineAgent.sh /appdynamics/MachineAgent/
RUN chmod 777 /appdynamics/MachineAgent/killMachineAgent.sh

# Set envrironment variable
ADD /env.sh /appdynamics/
RUN chmod 777 /appdynamics/env.sh
ADD /startup.sh /appdynamics/
RUN chmod 777 /appdynamics/startup.sh

##################### INSTALLATION END #####################

# Expose Ports
EXPOSE 3000

# Set environment variable and start the App
CMD /appdynamics/startup.sh && tail -F /var/log/dmesg 
