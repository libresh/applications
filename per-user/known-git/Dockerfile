FROM indiehosters/lamp-git

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -yq install \
		pwgen \
	&& rm -rf /var/lib/apt/lists/*

RUN cd /init && curl -L http://assets.withknown.com/releases/known-0.6.5.tgz

COPY init/known.sh /init/known.sh
COPY init/config.ini /init/config.ini
