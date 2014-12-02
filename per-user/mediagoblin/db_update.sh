#!/bin/bash

# die on any error
set -e
set -x

# start up postgres
/etc/init.d/postgresql start
sleep 2;

# load up virtualenv
. bin/activate

# update the database
./bin/gmg dbupdate
