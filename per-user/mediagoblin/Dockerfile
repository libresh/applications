# based on Nate Jones's https://github.com/mediatemple/federated_services_oscon_2013/tree/master/docker/mediagoblin
FROM ubuntu

# Install needed OS packages
RUN apt-get update \
	&& apt-get -yq install \
		build-essential \
		git-core \
		openssh-server \
		python \
		python-dev \
		python-lxml \
		python-imaging \
		python-virtualenv \
		python-psycopg2 \
		postgresql \
		postgresql-client \
		sudo \
		supervisor \
	&& rm -rf /var/lib/apt/lists/*

# Make a home for mediagoblin
RUN mkdir /srv/mediagoblin

# Setup the environment: clone the mediagoblin repo, install python packages
COPY ./env_setup.sh /srv/mediagoblin/env_setup.sh
RUN bash -c "cd /srv/mediagoblin; chmod +x env_setup.sh"
RUN bash -c "cd /srv/mediagoblin; ./env_setup.sh"

# Patch the email code so that test emails are logged
COPY ./email_logging.patch /srv/mediagoblin/email_logging.patch
RUN bash -c "cd /srv/mediagoblin/mediagoblin; patch -p0 < ../email_logging.patch"

# Set up the mediagoblin database in postgresql
COPY ./db_setup.sh /srv/mediagoblin/db_setup.sh
RUN bash -c "cd /srv/mediagoblin; chmod +x db_setup.sh"
RUN bash -c "cd /srv/mediagoblin; ./db_setup.sh"

# Configure the database connection and create the initial tables
COPY ./mediagoblin_local.ini /srv/mediagoblin/mediagoblin/mediagoblin_local.ini
COPY ./db_update.sh /srv/mediagoblin/db_update.sh
RUN bash -c "cd /srv/mediagoblin; chmod +x db_update.sh"
RUN bash -c "cd /srv/mediagoblin; cd mediagoblin; ../db_update.sh"

# Insert the script to run mediagoblin
COPY ./run_app.sh /srv/mediagoblin/run_app.sh
RUN bash -c "cd /srv/mediagoblin; chmod +x run_app.sh"

# Create a couple of required directories
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor
RUN locale-gen en_US en_US.UTF-8

# Configure supervisord
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose the ports and set the command to run
EXPOSE 6543
CMD ["/usr/bin/supervisord", "-n"]
