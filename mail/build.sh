#!/bin/bash

docker build -t indiehosters/postfix postfix/
docker stop postfix
docker rm postfix
docker run -p 25:25 -d --name="postfix" --hostname="indiehosters.net" indiehosters/postfix
docker ps -l
sleep 2
docker logs `docker ps -lq`
docker run -it --volumes-from="postfix" ubuntu /bin/bash
