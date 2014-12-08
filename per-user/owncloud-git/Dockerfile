FROM indiehosters/lamp-git

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -yq install \
		bzip2 \
		pwgen \
	&& rm -rf /var/lib/apt/lists/*

RUN cd /init && curl -O https://download.owncloud.org/community/owncloud-7.0.2.tar.bz2

COPY init/owncloud.sh /init/owncloud.sh
COPY init/config.php /init/config.php
