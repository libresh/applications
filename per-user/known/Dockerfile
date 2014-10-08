FROM indiehosters/nginx
MAINTAINER Michiel de Jong "michiel@unhosted.org"

# Adapted from https://github.com/dockerfile/nginx
# From the root of the indiehosters/dockerfiles, repo, please run:
#
#    docker build -t indiehosters/ubuntu base/ubuntu
#    docker build -t indiehosters/nginx per-user/nginx
#    docker build -t indiehosters/nginx per-user/known


# Install Known on top of nginx:
RUN wget http://assets.withknown.com/releases/known-0.6.3.tgz
RUN tar -xzf known-0.6.3.tgz
