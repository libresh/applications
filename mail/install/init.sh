#!/bin/sh
MYSQL_PASSWORD=`pwgen -c -n -1 12`
MICHIEL_PASSWORD=`pwgen -c -n -1 12`
HOST_NAME=`hostname -f`
sed -i "s/mailuserpass/$MYSQL_PASSWORD/g" /install/init.mysql
sed -i "s/michielpassword/$MICHIEL_PASSWORD/g" /install/init.mysql
sed -i "s/mailuserpass/$MYSQL_PASSWORD/g" /install/dovecot/dovecot-sql.conf.ext
sed -i "s/mailuserpass/$MYSQL_PASSWORD/g" /install/postfix/*
sed -i "s/hostname.com/$HOST_NAME/g" /install/init.mysql
sed -i "s/hostname.com/$HOST_NAME/g" /install/postfix/*
echo "mysql-server mysql-server/root_password password $MYSQL_PASSWORD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD" | debconf-set-selections
echo "postfix postfix/mailname string $HOST_NAME" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
echo "dovecot-core dovecot-core/create-ssl-cert boolean true" | debconf-set-selections
echo "dovecot-core dovecot-core/ssl-cert-name string $HOST_NAME" | debconf-set-selections

apt-get install -y postfix postfix-mysql dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-mysql mysql-server

#MySQL
/etc/init.d/mysql start && mysqladmin -p$MYSQL_PASSWORD create mailserver
/etc/init.d/mysql start && cat /install/init.mysql | mysql -p$MYSQL_PASSWORD mailserver

#Postfix
#cp /install/postfix/main.cf /etc/postfix/main.cf
#cp /install/postfix/mysql-virtual-mailbox-domains.cf /etc/postfix/mysql-virtual-mailbox-domains.cf
#cp /install/postfix/mysql-virtual-mailbox-maps.cf /etc/postfix/mysql-virtual-mailbox-maps.cf
#cp /install/postfix/mysql-virtual-alias-maps.cf /etc/postfix/mysql-virtual-alias-maps.cf
# cp /install/postfix/master.cf /etc/postfix/master.cf

#Dovecot
cp /install/dovecot/dovecot.conf /etc/dovecot/dovecot.conf
cp /install/dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf
mkdir -p /var/mail/vhosts/$HOST_NAME
groupadd -g 5000 vmail
useradd -g vmail -u 5000 vmail -d /var/mail
chown -R vmail:vmail /var/mail
cp /install/dovecot/conf.d/10-auth.conf /etc/dovecot/conf.d/10-auth.conf
cp /install/dovecot/conf.d/auth-sql.conf.ext /etc/dovecot/conf.d/auth-sql.conf.ext
cp /install/dovecot/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext
chown -R vmail:dovecot /etc/dovecot
chmod -R o-rwx /etc/dovecot
cp /install/dovecot/conf.d/10-master.conf /etc/dovecot/conf.d/10-master.conf
cp /install/dovecot/conf.d/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf

echo Password for anything at michielbdejong.com set to $MICHIEL_PASSWORD
