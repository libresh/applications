#!/bin/sh

git pull --rebase
git submodule update

  cd per-user/idno
  git checkout add-Dockerfile
  cd ../..

  cd per-user/anchorcms
  git checkout add-Dockerfile
  cd ../..

  for image in $(ls per-user/* | cut -d "/" -f 2); do
    echo sudo docker build -t indiehosters/$image per-user/$image/;
  done

  for image in $(ls server-wide/* | cut -d "/" -f 2); do
    echo sudo docker build -t indiehosters/$image server-wide/$image/;
  done
