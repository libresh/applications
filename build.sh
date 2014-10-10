#!/bin/sh

git pull --rebase
git submodule update

  cd server-wide/yunohost
  git checkout add-Dockerfile
  cd ../..

  cd per-user/idno
  git checkout add-Dockerfile
  cd ../..

  cd per-user/anchorcms
  git checkout add-Dockerfile
  cd ../..

for folder in server-wide per-user; do
  for image in $(find $folder/* -type d | cut -d "/" -f 2); do
    sudo docker build -t indiehosters/$image $folder/$image/;
 done
done
