#!/bin/bash

git clone $DATA_REPO /data
exec mysqld_safe &
sleep 5
mysql < /data/dump.sql
source /etc/apache2/envvars
exec apache2 -D FOREGROUND
