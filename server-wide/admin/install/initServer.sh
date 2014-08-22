#!/bin/bash
echo hostname is $1

#General:
mkdir -p /data/server-wide
mkdir -p /data/per-user
echo adding default site
sh ./addSite.sh default
echo updating
sh ./updateServer.sh

#Bouncer:
mkdir -p /data/server-wide/bouncer
echo default $1 > /data/server-wide/bouncer/sites-enabled.txt

#Mail:general:
mkdir -p /data/server-wide/mail
echo default $1 > /data/server-wide/mail/sites-enabled.txt
echo $1 > /data/server-wide/mail/hostname

#Mail:Mysql:
pwgen -c -n -1 12 > /data/server-wide/mail/mysqlpwd
mkdir -p /data/server-wide/mail/var/mysql
mv /var/mysql/data /data/server-wide/mail/var/mysql/
ln -s /data/server-wide/mail/var/mysql/data /var/mysql/data
cp /install/initServer.mysql tmp.mysql
sed -i "s/hostname.com/$1/g" tmp.mysql
sed -i "s/mailuserpass/`cat /data/server-wide/mail/mysqlpwd`/g" tmp.mysql
/etc/init.d/mysql start
mysqladmin -u root -p'changeme' password `cat /data/server-wide/mail/mysqlpwd`
mysqladmin -p'`cat /data/server-wide/mail/mysqlpwd`' create mailserver
cat tmp.mysql | mysql -p'`cat /data/server-wide/mail/mysqlpwd`' mailserver
rm tmp.mysql

#Mail:Postfix:
mkdir -p /data/server-wide/mail/etc
mv /etc/postfix /data/server-wide/mail/etc/
ln -s /data/server-wide/mail/etc/postfix /etc/postfix
cp /install/postfix/main.cf /etc/postfix/main.cf
cp /install/postfix/mysql-virtual-mailbox-domains.cf /etc/postfix/mysql-virtual-mailbox-domains.cf
cp /install/postfix/mysql-virtual-mailbox-maps.cf /etc/postfix/mysql-virtual-mailbox-maps.cf
cp /install/postfix/mysql-virtual-alias-maps.cf /etc/postfix/mysql-virtual-alias-maps.cf
cp /install/postfix/master.cf /etc/postfix/master.cf
sed -i "s/hostname.com/$1/g" /etc/postfix/*
sed -i "s/mailuserpass/`cat /data/server-wide/mail/mysqlpwd`/g" /etc/postfix/*

#Mail:Dovecot:
sed -i "s/mailuserpass/`cat /data/server-wide/mail/mysqlpwd`/g" /etc/dovecot/dovecot-sql.conf.ext
cp install/dovecot/dovecot.conf /etc/dovecot/dovecot.conf
cp install/dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf
mkdir -p /var/mail/vhosts/$1
groupadd -g 5000 vmail
useradd -g vmail -u 5000 vmail -d /var/mail
chown -R vmail:vmail /var/mail
cp install/dovecot/conf.d/10-auth.conf /etc/dovecot/conf.d/10-auth.conf
cp install/dovecot/conf.d/auth-sql.conf.ext /etc/dovecot/conf.d/auth-sql.conf.ext
cp install/dovecot/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext
chown -R vmail:dovecot /etc/dovecot
chmod -R o-rwx /etc/dovecot
cp install/dovecot/conf.d/10-master.conf /etc/dovecot/conf.d/10-master.conf
cp install/dovecot/conf.d/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf

