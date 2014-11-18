# Usage:

PASS=`pwgen 20 1`
sudo docker pull debian:jessie
sudo docker build -t indiehosters/lamp ../lamp
sudo docker build -t indiehosters/wordpress .
sudo docker run -d -e MYSQL_PASS=$PASS --name mysql indiehosters/mysql
sudo docker run -d -p 80:80 --link mysql:db -e DB_PASS=$PASS indiehosters/wordpress
sleep 10
curl -I http://localhost/
