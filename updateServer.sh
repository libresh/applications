#!/bin/bash
echo building images
docker build -t indieservers/mail server-wide/mail/
docker run -h `cat /data/server-wide/mail/hostname` indieservers/mail /install/init.sh
docker commit `docker ps -lq` my-mailserver-with-passwords
docker build -t indiehosters/resite per-user/resite/
docker build -t indiehosters/bouncer server-wide/bouncer/
docker build -t indiehosters/mail server-wide/mail/
