FROM jenkinsci/jenkins

USER root

RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list.d/docker.list
RUN apt-get update
RUN apt-get install docker-engine

RUN groupadd docker
RUN gpasswd -a jenkins docker
RUN service docker start

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state