#!/bin/bash
echo hostname is $1
mkdir -p /data/server-wide/bouncer
echo default $1 > /data/server-wide/bouncer/sites-enabled.txt
mkdir -p /data/server-wide/mail
echo default $1 > /data/server-wide/mail/sites-enabled.txt
echo $1 > /data/server-wide/mail/hostname
mkdir -p /data/per-user
echo adding default site
sh ./addSite.sh default
echo updating
sh ./updateServer.sh
