#!/bin/bash
cd /scuttlebot
./client.js server > log.txt &
./client.js add --type follows --'$feed' $ssb_master
tail -f log.txt
