FROM ubuntu

MAINTAINER Gabriella Querales (gabriella.querale@appdynamics.com)

################## BEGIN INSTALLATION ######################

# Update the repository sources list
RUN apt-get update

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org

# Setup SSH
RUN apt-get -y install openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:welcome1' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Create appdynamics dir
RUN mkdir /appdynamics

# Create data dir
RUN mkdir /data
RUN mkdir /data/db

# Add startup script
ADD /data.json /appdynamics/

# Add startup script
ADD /startup.sh /appdynamics/
RUN chmod 777 /appdynamics/startup.sh

##################### INSTALLATION END #####################

# Expose Ports
EXPOSE 27017

# Start the App
#ENTRYPOINT ["/usr/bin/mongod"]
CMD /appdynamics/startup.sh && tail -F /var/log/mongodb/mongod.log 
