# lamp-git

This image pulls in a database dump and a www-content folder from a git repo, and hosts it as a lamp application.


````
sudo docker build -t indiehosters/lamp-git .
sudo docker run -d -e DATA_REPO=git@123.123.123.123:test.dev -e SECONDARY_REPO=git@124.124.124.124:test.dev -v /home/user/.ssh:/root/.ssh indiehosters/lamp-git
````
