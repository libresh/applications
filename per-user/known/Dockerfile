FROM indiehosters/lamp

# Download latest version of Known into /app
RUN curl -L http://assets.withknown.com/releases/known-0.6.4.tgz | tar xz && \
  mv known-0.6.4/* app
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

EXPOSE 80
VOLUME ["/app/known-content", "/app/.htaccess"]
CMD ["/run-known.sh"]
