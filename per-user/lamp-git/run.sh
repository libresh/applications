#!/bin/bash

exec mysqld_safe &
for ((i=0;i<10;i++))
do
    DB_CONNECTABLE=$(mysql -e 'status' >/dev/null 2>&1; echo "$?")
    if [[ DB_CONNECTABLE -eq 0 ]]; then
        break
    fi
    echo "Waiting for database server..."
    sleep 1
done

mkdir -p /data/uploads
mkdir -p /data/www-content
touch /data/dump.sql

chown -R root:www-data /data
chmod -R 770 /data/uploads
chmod -R 750 /data/www-content

mysql < /data/dump.sql
source /etc/apache2/envvars
exec apache2 &

cd /data
git init
git config --local user.email "backup@IndieHosters"
git config --local user.name "IndieHosters backup"
git config --local push.default simple

while true; do
  mysqldump --all-databases > dump.sql
  git add *
  git commit -am"backup `date`"
  git status
  date
  echo "Next backup in one hour..."
  sleep 3540
done
