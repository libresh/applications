echo Unpacking latest WordPress into /data/www-content...
curl -L https://wordpress.org/latest.tar.gz | tar xz
rm -rf /data/www-content
mv wordpress /data/www-content

echo Creating wp-config.php...
mv wp-config.php /data/www-content/wp-config.php
curl -L https://api.wordpress.org/secret-key/1.1/salt/ >> /data/www-content/wp-config.php

echo Setting ownership and permissions...
chown -R root:www-data /data
chmod -R 600 /data
chmod -R 650 /data/www-content
chmod -R 770 /data/www-content/wp-content

echo Starting MySQL so that you can import wordpress.sql...
mysqld_safe 
