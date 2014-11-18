# Work in progress

This image doesn't work yet, still needs some permissions tweaking and such.

# Usage:

PASS=`pwgen 20 1`
sudo docker pull debian:jessie
sudo docker build -t indiehosters/lamp ../lamp
sudo docker build -t indiehosters/owncloud .
sudo docker run -d -e MYSQL_PASS=$PASS --name mysql indiehosters/mysql
sudo docker run -d -p 80:80 --link mysql:db -e DB_PASS=$PASS indiehosters/owncloud
echo Using $PASS as the database password. Waiting for everything to be up...
sleep 20
curl -I http://localhost/
