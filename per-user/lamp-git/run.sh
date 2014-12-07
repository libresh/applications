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

mysql < /data/dump.sql
source /etc/apache2/envvars
exec apache2 &

cd /data

while true; do
  mysqldump --all-databases > dump.sql
  git add *
  git commit -am"backup `date`"
  git status
  date
  echo "Next backup in one hour..."
  sleep 3540
done
