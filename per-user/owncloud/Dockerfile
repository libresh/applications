FROM indiehosters/lamp

# Download latest version of ownCloud into /app
RUN apt-get update && \
	apt-get -yq install \
		bzip2 && \
	curl -L https://download.owncloud.org/community/owncloud-7.0.2.tar.bz2 \
		| tar xj && \
	mv owncloud/* app && \
	apt-get -yq remove bzip2 && \
        apt-get -yq autoclean && \
	rm -rf /var/lib/apt/lists/*

ADD oc-config.php /app/oc-config.php

# Add script to create 'owncloud' DB
ADD run-owncloud.sh /run-owncloud.sh
RUN chmod 755 /run-owncloud.sh

# Expose environment variables
ENV DB_HOST **LinkMe**
ENV DB_PORT **LinkMe**
ENV DB_NAME owncloud
ENV DB_USER admin
ENV DB_PASS **ChangeMe**

EXPOSE 80
VOLUME ["/app/oc-content", "/app/.htaccess"]
CMD ["/run-owncloud.sh"]
