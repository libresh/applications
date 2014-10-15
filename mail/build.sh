#!/bin/bash

docker build -t indiehosters/postfix postfix/
docker stop postfix
docker rm postfix
docker run -p 25:22 -d --name postfix indiehosters/postfix
docker ps -l
docker logs -f `docker ps -lq`
