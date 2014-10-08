FROM tutum/nginx
MAINTAINER Michiel de Jong "michiel@unhosted.org"

RUN apt-get update
RUN apt-get install -y wget

# Add php (taken from https://github.com/fideloper/docker-nginx-php):
RUN apt-get install -y php5-cli php5-fpm php5-mysql php5-pgsql php5-sqlite php5-curl\
                       php5-gd php5-mcrypt php5-intl php5-imap php5-tidy
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini

# Install Known on top of nginx:
RUN wget http://assets.withknown.com/releases/known-0.6.3.tgz && \
    tar -xzf ../known-0.6.3.tgz && \
    rm /app/* && \
    mv /known-0.6.3/* /app
