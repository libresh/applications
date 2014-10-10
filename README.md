# Dockerfiles

This repo contains the Dockerfiles for images used in [the IndieHosters infrastructure](https://github.com/indiehosters/infrastructure.git).

We have three ways of building Docker images:

* from source - In this repo, there will be a git submodule to a software project that includes a Dockerfile in its source repo.
    we will build images from that as indiehosters/project:tag, where project is the name of the submodule here, and tag is a git
    tag inside that repo. If what we need for the IndieHosters infrastructure is not available out of the box then we will fork the
    project, and submodule our fork, while at the same time submiting a pull request upstream. As soon as this pull request gets merged
    we will submodule the upstream project directly again.

* from package - In this repo, there will be a folder with a Dockerfile which refers to the actual software via a package system, probably
    apt-get.

* by reference - Same as from package, but instead of doing a package install like `apt-get`, it would do a source install, so `git clone` or
    `wget`. This might be useful for instance when an image combines code from several open source projects. In most cases though, it will be preferable to add the Dockerfile into the upstream source repo of the user-facing application.


NB: So far, at the time of writing, infrastructure doesn't use any of the images from this repo yet, but still uses the following third-party
packages which it pulls from the public image registry operated by docker.com:

Server-wide:

* dockerfile/haproxy

Per-user:

* tutum/wordpress-stackable
* tutum/mysql
* tutum/nginx

# Build

To build, run:

```bash
git pull --rebase
git submodule init
git submodule update
for folder in server-wide per-user; do
  for image in $(find $folder/* -type d | cut -d "/" -f 2); do
    sudo docker build -t indiehosters/$image $folder/$image/;
 done
done
```
