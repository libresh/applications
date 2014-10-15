#!/bin/bash

#judgement
if [[ -a /etc/supervisor/conf.d/supervisord.conf ]]; then
  exit 0
fi

#supervisor
cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true

[program:postfix]
command=/opt/postfix.sh

[program:rsyslog]
command=/usr/sbin/rsyslogd -n
EOF

############
# postfix
############
cat >> /opt/postfix.sh <<EOF
#!/bin/bash
service postfix start
touch /var/log/mail.log
tail -f /var/log/mail.log
EOF
chmod +x /opt/postfix.sh

# Configure email domain on first run:
echo ${HOSTNAME} > /etc/mailname
/usr/sbin/postconf -e "myhostname=${HOSTNAME}"
/usr/sbin/postconf -e "mydestination=${HOSTNAME}"
