#!/bin/bash
mkdir -p /data/server-wide/bouncer/cert
mkdir -p /data/per-user
echo adding default site
sh ./addSite.sh default
