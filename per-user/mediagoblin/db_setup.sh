#!/bin/bash

# die on any error
set -e
set -x

# start up postgres
/etc/init.d/postgresql start
sleep 2;

# create root user
sudo -u postgres createuser root -R -S -D

# create root db
sudo -u postgres createdb root
