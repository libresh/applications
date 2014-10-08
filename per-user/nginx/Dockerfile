FROM indiehosters/ubuntu
MAINTAINER Michiel de Jong "michiel@unhosted.org"

# Adapted from https://github.com/dockerfile/nginx
# From the root of the indiehosters/dockerfiles, repo, please run:
#
#    docker build -t indiehosters/ubuntu base/ubuntu
#    docker build -t indiehosters/nginx per-user/nginx


# Install Nginx.
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx
RUN rm -rf /var/lib/apt/lists/*
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]

WORKDIR /etc/nginx
CMD ["nginx"]
EXPOSE 80
