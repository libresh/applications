FROM indiehosters/lamp

# Download latest version of Known into /app
RUN mkdir -p ; cd /app ; curl -L http://assets.withknown.com/releases/known-0.6.4.tgz | tar xz
ADD known-config.php /app/known-config.php

# Add script to create 'known' DB
ADD run-known.sh /run-known.sh
RUN chmod 755 /run-known.sh

# Expose environment variables
ENV DB_HOST **LinkMe**
ENV DB_PORT **LinkMe**
ENV DB_NAME known
ENV DB_USER admin
ENV DB_PASS **ChangeMe**

# to be cleaned up:
RUN apt-get update
RUN apt-get install -y php5-xmlrpc
RUN mkdir /uploads
RUN chown www-data:www-data /uploads

ADD config.ini /app/config.ini
RUN mv /app/htaccess.dist /app/.htaccess

EXPOSE 80
VOLUME ["/app"]
CMD ["/run-known.sh"]
