#!/bin/bash

git config --global user.email "backup@IndieHosters"
git config --global user.name "IndieHosters backup"

chown root:www-data /data/uploads
chmod g+rwx /data/uploads

exec mysqld_safe &
exec cron &
sleep 5
mysql < /data/dump.sql
source /etc/apache2/envvars
exec apache2 -D FOREGROUND
