sudo docker run -d -v /root/michiel-data/resite:/data/resite -p 127.0.0.1:80:80 michielbdejong/resite
sudo docker run -d -v /root/michiel-data/cell:/data/cell -p 80:80 -p 443:443 michielbdejong/cell
