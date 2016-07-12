#
#   Inherit from the latest Jenkins 2.0 build (because we want pipeline functionality)
#
FROM jenkinsci/jenkins

#
#   It's-a-me
#
MAINTAINER tobyjmarks@gmail.com

#
#   We need to install Docker and other necessary apps as root
#
USER root

#
#   Install Docker prereqs, including supervisor to start the daemon
#
RUN apt-get update -qq && apt-get install -qqy apt-transport-https ca-certificates supervisor

#
# Create log folders for supervisor, jenkins and docker
#
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /var/log/docker
RUN mkdir -p /var/log/jenkins

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#
#   Install Docker
#
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list.d/docker.list
RUN apt-get update -qq
#RUN apt-cache policy docker-engine
#RUN apt-get update -qq
RUN apt-get install -qqy docker-engine

#
#   Add jenkins to docker group so jenkins has permission to run docker
#
#RUN groupadd docker
RUN gpasswd -a jenkins docker

#
#   Install the magic wrapper
#
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker


#
#   Pre-install selected Jenkins plugins and disable banner page
#
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

#
#   Switch back to root and start Jenkins, Docker
#
USER root
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf