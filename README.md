#IndieHosters Dockerfiles

This is a first draft of the containers I'm running on k1.michiel.indiehosters.net.

To use it:

* take a server with Docker (e.g. CoreOS or Ubuntu),
* git clone git@github.com:indiehosters/dockerfiles
* cd dockerfiles
* sh ./build.sh
* docker run -i -t -v /data:/data indieserver/admin /install/initserver.sh k1.michiel.indiehosters.net
* docker run -i -t -v /data:/data indieserver/admin /install/addDomain.sh michielbdejong.com
* edit the certificate files in `/data/per-user/michielbdejong.com/bouncer/cert/`
* sh ./run.sh
