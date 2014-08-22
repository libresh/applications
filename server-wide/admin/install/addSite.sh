#!/bin/bash
if [ -d /data/per-user/$1 ]
then
    echo site $1 already exists
else
    echo activating web for http://$1/ and https://$1/:
    mkdir -p /data/per-user/$1/resite
    echo $1 > /data/per-user/$1/resite/sitename.txt
    echo $1 >> /data/server-wide/bouncer/sites-enabled.txt

    echo activating email for anything@$1:
    echo $1 >> /data/server-wide/mail/sites-enabled.txt
    mkdir -p /data/per-user/$1/mail/password
    pwgen -c -n -1 12 >> /data/per-user/$1/mail/password/anything
    cp /install/addSite.mysql tmp.mysql
    sed -i "s/domain.com/$1/g" tmp.mysql
    sed -i "s/userpassword/`cat /data/per-user/$1/mail/password/anything`/g" tmp.mysql
    /etc/init.d/mysql start
    cat tmp.mysql | mysql -p`cat /data/server-wide/mail/mysqlpassword` mailserver
    rm tmp.mysql
    echo IMAP password for anything@$1 saved to /data/per-user/$1/mail/password/anything

    echo empty site created for $1. Now run "sh run.sh" on the server host.
fi
