#!/bin/bash
echo hostname is $1
mkdir -p /data/server-wide/bouncer/
echo default $1 > /data/server-wide/bouncer/sites-enabled.txt
echo default $1 > /data/server-wide/mail/sites-enabled.txt
echo $1 > /data/server-wide/mail/hostname
mkdir -p /data/per-user
echo adding default site
sh ./addSite.sh default
echo building images
docker build -t michielbdejong/mail .
docker run -h $1 michielbdejong/mail /install/init.sh
docker commit `docker ps -lq` my-mailserver-with-passwords
