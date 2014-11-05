# Usage:

sudo docker build -t indiehosters/known .
sudo docker run -d -e MYSQL_PASS=humptydumpty --name mysql indiehosters/mysql
sudo docker run -d -p 80:80 --link mysql:db -e DB_PASS=humptydumpty indiehosters/known
curl -I http://localhost/
