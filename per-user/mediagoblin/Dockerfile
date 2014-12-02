# Start off at Ubuntu 13.04
from    debian:jessie
# based on https://github.com/mediatemple/federated_services_oscon_2013/tree/master/docker/mediagoblin

# Install needed OS packages
run     apt-get update
run     apt-get install --force-yes -y git-core python python-dev python-lxml python-imaging python-virtualenv python-psycopg2 build-essential postgresql postgresql-client sudo supervisor openssh-server

# Make a home for mediagoblin
run     mkdir /srv/mediagoblin

# Setup the environment: clone the mediagoblin repo, install python packages
add     ./env_setup.sh /srv/mediagoblin/env_setup.sh
run     bash -c "cd /srv/mediagoblin; chmod +x env_setup.sh"
run     bash -c "cd /srv/mediagoblin; ./env_setup.sh"

# Patch the email code so that test emails are logged
#add     ./email_logging.patch /srv/mediagoblin/email_logging.patch
#run     bash -c "cd /srv/mediagoblin/mediagoblin; patch -p0 < ../email_logging.patch"

# Set up the mediagoblin database in postgresql
add     ./db_setup.sh /srv/mediagoblin/db_setup.sh
run     bash -c "cd /srv/mediagoblin; chmod +x db_setup.sh"
run     bash -c "cd /srv/mediagoblin; ./db_setup.sh"

# Configure the database connection and create the initial tables
add     ./mediagoblin_local.ini /srv/mediagoblin/mediagoblin/mediagoblin_local.ini
add     ./db_update.sh /srv/mediagoblin/db_update.sh
run     bash -c "cd /srv/mediagoblin; chmod +x db_update.sh"
run     bash -c "cd /srv/mediagoblin; cd mediagoblin; ../db_update.sh"

# Insert the script to run mediagoblin
add     ./run_app.sh /srv/mediagoblin/run_app.sh
run     bash -c "cd /srv/mediagoblin; chmod +x run_app.sh"

# Create a couple of required directories
run     mkdir -p /var/run/sshd
run     mkdir -p /var/log/supervisor
run     locale-gen en_US en_US.UTF-8

# Configure supervisord
add     ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose the ports and set the command to run
expose  22
expose  6543
cmd     ["/usr/bin/supervisord", "-n"]
