#!/bin/bash

git config --global user.email "backup@IndieHosters"
git config --global user.name "IndieHosters backup"

chown -R root:www-data /data/uploads
chmod -R 770 /data/uploads

exec mysqld_safe &
exec cron &
sleep 5
mysql < /data/dump.sql
source /etc/apache2/envvars
exec apache2 &
cd /data
while (1); do
  mysqldump --all-databases > dump.sql;
  git add *;
  git commit -am"backup `date`";
  git status;
  date;
  echo "Next backup in one hour...";
  sleep 3540;
done
