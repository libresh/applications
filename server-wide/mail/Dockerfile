FROM ubuntu:trusty
RUN apt-get update
RUN apt-get install -y --download-only postfix postfix-mysql dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-mysql mysql-server
RUN apt-get install -y pwgen
ADD ./install /install

EXPOSE 25
EXPOSE 465
EXPOSE 587
EXPOSE 993
EXPOSE 995

# See the readme for how to use this image.
