#!/bin/bash
LINKS=""
cd /data/per-user
for i in *
do
  docker stop resite-$i
  docker rm resite-$i
  docker run -d -v /data/per-user/$i/resite:/data/resite --name resite-$i indiehosters/resite
  docker logs resite-$i
  LINKS="${LINKS} --link resite-$i:resite-$i "
done

docker stop bouncer
docker rm bouncer
docker run -d -v /data:/data --name bouncer $LINKS-p 80:80 -p 443:443 -p 7678:7678 indiehosters/bouncer
docker logs bouncer

docker run -d -h `cat /data/server-wide/mail/hostname` -p 25:25 -p 465:465 -p 587:587 -p 993:993 -p 995:995 my-mailserver-with-passwords /install/run.sh

docker ps
