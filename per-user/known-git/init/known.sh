#!/bin/bash

VERSION="0.6.5"

echo "Extracting Known $(VERSION}..."
cd /data/www-content
tar xzf /init/known-$VERSION.tgz

echo "Setting default config..."
cp /init/config.ini .

echo "Creating empty database..."
echo "CREATE DATABASE IF NOT EXISTS known" | mysql

PWD=`pwgen 40 1`
echo "user: " > /data/login.txt
echo "pass: $PWD" >> /data/login.txt
echo "Please use your browser to set up a user, and edit /data/login.txt manually:"
cat /data/login.txt
