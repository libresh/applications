#!/bin/bash

cd /srv/mediagoblin/mediagoblin
. bin/activate
./lazyserver.sh --server-name=broadcast
