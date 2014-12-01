#!/bin/bash

exec mysqld_safe &
exec cron &
git clone $DATA_REPO /data
cd /data
git remote add secondary $SECONDARY_REPO
git config --local user.email "backup@IndieHosters"
git config --local user.name "IndieHosters backup"
git config --global push.default simple
sleep 5
mysql < /data/dump.sql
source /etc/apache2/envvars
exec apache2 -D FOREGROUND
