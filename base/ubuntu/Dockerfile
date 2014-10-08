FROM ubuntu:trusty
#trusty is 14.04. beware of the bash bug mentioned in the comments of https://registry.hub.docker.com/_/ubuntu/
MAINTAINER Michiel de Jong "michiel@unhosted.org"
RUN apt-get -y update
RUN apt-get -y upgrade

# This is used as a base image for all our per-user as well as server-wide images.
# That way our images stay more uniform, and we can easily yet precisely control things
# like security updates.
#
# All other images should ideally only track application-specific sources.
#
# Please build this as:
#
#     docker build -t indiehosters/ubuntu .
#
# And then you can use it as the base for nginx, haproxy, and the other application-specific Dockerfiles.

# Generic tools:
RUN apt-get install -y software-properties-common
RUN apt-get -y install wget
RUN apt-get -y install git
RUN apt-get install -y build-essential
