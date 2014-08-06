sudo docker pull michielbdejong/resite
sudo docker pull michielbdejong/3pp-bouncer

sudo docker stop resite
sudo docker rm resite
sudo docker stop bouncer
sudo docker rm bouncer
sudo docker run -d -v /root/michiel-data/resite:/data/resite --name resite michielbdejong/resite
sudo docker run -d -v /root/michiel-data/bouncer:/data/bouncer --name bouncer --link resite:resite -p 80:80 -p 443:443 -p 7678:7678 michielbdejong/3pp-bouncer
sudo docker run -d -v /root/michiel-data/mail:/data/mail --name mail -p 25:25 -p 143:143 -p 993:993 cpuguy83/mail
sudo docker run -d -v /root/michiel-data/mailpile:/data/mailpile --name mailpile -p 2001:33411 mazzolino/mailpile
sudo docker ps
sudo docker logs bouncer
sudo docker logs resite
sudo docker logs mail
sudo docker logs mailpile
