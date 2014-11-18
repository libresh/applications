# Build and fire up database server:
PASS=`pwgen 20 1`
sudo docker build -t indiehosters/known .
sudo docker run -d -e MYSQL_PASS=$PASS --name mysql indiehosters/mysql

# Run webserver:
sudo docker run -d -p 80:80 --link mysql:db -e DB_PASS=$PASS indiehosters/known
curl -I http://localhost/

It will take a while for the site to come up (it needs to create the database first).
