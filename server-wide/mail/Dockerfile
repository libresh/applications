FROM ubuntu:trusty
RUN apt-get update
RUN apt-get install -y --download-only postfix postfix-mysql dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-mysql mysql-server

RUN echo "mysql-server mysql-server/root_password password changeme" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password changeme" | debconf-set-selections
RUN echo "postfix postfix/mailname string changeme" | debconf-set-selections
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
RUN echo "dovecot-core dovecot-core/create-ssl-cert boolean true" | debconf-set-selections
RUN echo "dovecot-core dovecot-core/ssl-cert-name string changeme" | debconf-set-selections

RUN apt-get install -y postfix postfix-mysql dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-mysql mysql-server

EXPOSE 25
EXPOSE 465
EXPOSE 587
EXPOSE 993
EXPOSE 995

CMD service mysql start && service postfix start && dovecot && tail -f /var/log/*
