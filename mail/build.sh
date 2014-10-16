#!/bin/bash

docker build -t indiehosters/postfix postfix/
docker stop postfix
docker rm postfix
docker run -p 25:25 -d --name="postfix" -v /root/dockerfiles/mail/data:/data indiehosters/postfix
docker ps -l
sleep 2
docker logs `docker ps -lq`
docker run -it --volumes-from="postfix" ubuntu /bin/bash

# design principle:
# * a postfix+supervisor+rsyslog image that is as vanilla as possible (domain example.com and settings all postfix defaults)
# * at runtime, configure the desired behavior:
#   * set the hostname it should announce in the banner from /data/hostname
#   * mount in DKIM certs for relaying domains from /data/server-wide/postfix/dkim/example.com/*
#   * mount in TLS cert from /data/server-wide/postfix/dkim/example.com/ and /data/server-wide/postfix/
#   * relay any outgoing email from the Docker network 172.17.*.* (with DKIM!)
#   * postmap email forwards from /data/server-wide/postfix/virtual-regexp
