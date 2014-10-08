FROM ubuntu:trusty
#trusty is 14.04. beware of the bash bug mentioned in the comments of https://registry.hub.docker.com/_/ubuntu/
MAINTAINER Michiel de Jong "michiel@unhosted.org"
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install wget

RUN sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/owncloud.list"
RUN wget http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/Release.key
RUN apt-key add - < Release.key
RUN apt-get -y update
RUN apt-get -y install owncloud

VOLUMES ["/var/www/owncloud/data", "/var/www/owncloud/config"]

EXPOSE :80
CMD ["/usr/sbin/apache2ctl", "-D",  "FOREGROUND"]
