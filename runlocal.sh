sudo docker build -t michielbdejong/resite resite/
sudo docker build -t michielbdejong/3pp-bouncer bouncer/

sudo docker stop resite
sudo docker rm resite
sudo docker stop bouncer
sudo docker rm bouncer
sudo docker run -d -v /root/michiel-data/resite:/data/resite --name resite michielbdejong/resite
sudo docker run -d -v /root/michiel-data/bouncer:/data/bouncer --name bouncer --link resite:resite -p 80:80 -p 443:443 -p 7678:7678 michielbdejong/3pp-bouncer
sudo docker ps
sudo docker logs bouncer
sudo docker logs resite
