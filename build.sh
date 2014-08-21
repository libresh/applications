#!/bin/bash
echo building server-wide images
docker build -t indiehosters/admin server-wide/admin/
docker build -t indiehosters/bouncer server-wide/bouncer/
docker build -t indiehosters/mail server-wide/mail/
docker build -t indiehosters/sockethub server-wide/sockethub/

echo building per-user images
docker build -t indiehosters/resite per-user/resite/
docker build -t indiehosters/owncloud per-user/owncloud/
docker build -t indiehosters/pump.io per-user/pump.io/
docker build -t indiehosters/idno per-user/idno/
docker build -t indiehosters/cozy per-user/cozy/
