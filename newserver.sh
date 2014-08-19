sudo rsync -r /root/michiel-data root@$1:/root/michiel-data
ssh root@$1 docker run -d -v /root/michiel-data/resite:/data/resite -p 127.0.0.1:801:80 michielbdejong/resite
ssh root@$1 docker run -d -v /root/michiel-data/cell:/data/cell -p 80:80 -p 443:443 michielbdejong/cell
