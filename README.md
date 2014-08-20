#IndieHosters Dockerfiles

This is a first draft of the containers I'm running on k1.michiel.indiehosters.net.

To use it:

* take a server with Docker (e.g. CoreOS or Ubuntu),
* `rsync -r ./data-sample root@newserver:/data`
* `ssh root@newserver`
* edit the certificate files in `/data/default/bouncer/cert/`
* paste the commands from `run.sh`
