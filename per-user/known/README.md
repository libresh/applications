# Build and fire up database server:

sudo docker build -t indiehosters/known .
sudo docker run -d -e MYSQL_PASS=humptydumpty --name mysql indiehosters/mysql

# Import database schema:
sudo docker run -it --link mysql:db indiehosters/known /bin/bash
* cat /app/schemas/mysql/mysql.sql | mysql -h db -u admin -p known
* Password: humptydumpty

# Run webserver:
sudo docker run -d -p 80:80 --link mysql:db -e DB_PASS=humptydumpty indiehosters/known
curl -I http://localhost/

It will take a while for the site to come up (it needs to create the database first).
