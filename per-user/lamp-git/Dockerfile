FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -yq install \
		apache2 \
		curl \
		git \
		libapache2-mod-php5 \
		mysql-client \
		mysql-server-5.5 \
		php-apc \
		php-pear \
		php5-curl \
		php5-gd \
		php5-mysql \
		php5-xmlrpc \
	&& rm -rf /var/lib/apt/lists/*

# Add image configuration and scripts
COPY apache.conf /etc/apache2/sites-enabled/000-default.conf
COPY init /init
COPY run.sh /run.sh
RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini \
	&& a2enmod rewrite \
	&& chmod 755 /run.sh

CMD ["/run.sh"]
EXPOSE 80
