#!/bin/sh

# die on any error
set -e

# clone repo
git clone git://gitorious.org/mediagoblin/mediagoblin.git
cd mediagoblin
git submodule update --init

# set up the deps and main code
(virtualenv --system-site-packages . || virtualenv .) && ./bin/python setup.py develop

# install flup for fcgi
./bin/easy_install flup
