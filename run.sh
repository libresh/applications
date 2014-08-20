#or: docker build -t michielbdejong/3pp-bouncer bouncer/
docker pull michielbdejong/resite
docker pull michielbdejong/3pp-bouncer

docker stop resitedefault
docker rm resitedefault
docker run -d -v /data/default/resite:/data/resite --name resitedefault michielbdejong/resite
docker logs resitedefault

docker stop resitemichiel
docker rm resitemichiel
docker run -d -v /data/michiel/resite:/data/resite --name resitemichiel michielbdejong/resite
docker logs resitemichiel

#docker stop resitejoebloggs
#docker rm resitejoebloggs
#docker run -d -v /data/joebloggs/resite:/data/resite --name resitejoebloggs michielbdejong/resite
#docker logs resitejoebloggs

docker stop bouncer
docker rm bouncer
#... --link resitejoebloggs:resitejoebloggs ...
docker run -d -v /data/default/bouncer:/data/bouncer --name bouncer --link resitedefault:resitedefault --link resitemichiel:resitemichiel -p 80:80 -p 443:443 -p 7678:7678 michielbdejong/3pp-bouncer
docker logs bouncer

docker ps
