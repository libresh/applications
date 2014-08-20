docker build -t indiehosters/resite per-user/resite/
docker build -t indiehosters/bouncer server-wide/bouncer/
docker build -t indiehosters/mail server-wide/mail/

docker stop resitedefault
docker rm resitedefault
docker run -d -v /data/default/resite:/data/resite --name resitedefault indiehosters/resite
docker logs resitedefault

docker stop resitemichiel
docker rm resitemichiel
docker run -d -v /data/michiel/resite:/data/resite --name resitemichiel indiehosters/resite
docker logs resitemichiel

#docker stop resitejoebloggs
#docker rm resitejoebloggs
#docker run -d -v /data/joebloggs/resite:/data/resite --name resitejoebloggs indiehosters/resite
#docker logs resitejoebloggs

docker stop bouncer
docker rm bouncer
#... --link resitejoebloggs:resitejoebloggs ...
docker run -d -v /data/default/bouncer:/data/bouncer --name bouncer --link resitedefault:resitedefault --link resitemichiel:resitemichiel -p 80:80 -p 443:443 -p 7678:7678 indiehosters/bouncer
docker logs bouncer

docker ps
