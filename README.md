#IndieHosters Dockerfiles

This is a first draft of the containers I'm running on k1.michiel.indiehosters.net.

To use it:

* take a server with Docker (e.g. CoreOS or Ubuntu),
* git clone git@github.com:indiehosters/dockerfiles
* cd dockerfiles
* sh ./initServer.sh k1.michiel.indiehosters.net
* sh ./addDomain.sh michielbdejong.com
* edit the certificate files in `/data/per-user/michielbdejong.com/bouncer/cert/`
* sh ./run.sh
