#IndieHosters Dockerfiles

This is a first draft of the containers I'm running on k1.michiel.indiehosters.net.

To use it:

* take a server (e.g. CoreOS or Ubuntu),
* if you use CoreOS, Docker is already available. Otherwise, you have two options:
  * install standard Docker and set up systemd or upstart yourself
  * install Docker version 1.2 (e.g. install the latest binary)
* git clone git@github.com:indiehosters/dockerfiles
* cd dockerfiles
* sh ./build.sh
* docker run -i -t -v /data:/data indieserver/admin /install/initserver.sh k1.michiel.indiehosters.net
* docker run -i -t -v /data:/data indieserver/admin /install/addDomain.sh michielbdejong.com
* edit the certificate files in `/data/per-user/michielbdejong.com/bouncer/cert/`
* sh ./run.sh
* if you want to use systemd or upstart (e.g. when you are running on CoreOS), and/or if are using docker version < 1.2, then you will need to use `sh ./run-no-restart.sh` instead of `sh ./run.sh`.
