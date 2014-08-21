#!/bin/bash
if [ -d /data/per-user/$1 ]
then
    echo site $1 already exists
else
    mkdir -p /data/per-user/$1/resite
    echo $1 > /data/per-user/$1/resite/sitename.txt
    echo empty site created for $1
fi
