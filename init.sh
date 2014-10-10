#!/bin/sh

git pull --rebase
git submodule init
git submodule update

  cd server-wide/yunohost
  git submodule init
  git submodule update
  git remote add me git@github.com:michielbdejong/YunoHost-install_script
  git fetch me
  git checkout me/add-Dockerfile -b add-Dockerfile
  cd ../..

  cd per-user/idno
  git submodule init
  git submodule update
  git remote add me git@github.com:michielbdejong/idno
  git fetch me
  git checkout me/add-Dockerfile -b add-Dockerfile
  cd ../..
