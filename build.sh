#!/bin/sh

git pull --rebase

for folder in server-wide per-user; do
  for image in $(find $folder/* -type d | cut -d "/" -f 2); do
    sudo docker build -t indiehosters/$image $folder/$image/;
 done
done
