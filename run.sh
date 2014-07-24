sudo docker stop resite
sudo docker rm resite
sudo docker stop bouncer
sudo docker rm bouncer
sudo docker run -d -v /home/michiel/michiel-data:/data --name resite michielbdejong/resite
sudo docker run -d -v /home/michiel:/home/michiel --name bouncer --link resite:resite -p 80:80 -p 443:443 michielbdejong/3pp-bouncer
sudo docker ps
