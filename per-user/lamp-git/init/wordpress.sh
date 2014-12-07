curl -L https://wordpress.org/latest.tar.gz | tar xz
rm -rf /data/www-content
mv wordpress /data/www-content
mv wp-config.php /data/www-content/wp-config.php
wget https://api.wordpress.org/secret-key/1.1/salt/ >> /data/www-content/wp-config.php

chown -R root:www-data /data
chmod -R 650 /data
chmod -R 770 /data/www-content/wp-content
chmod -R 660 /data/www-content/.htaccess

mysqld_safe &

for ((i=0;i<10;i++))
do
    DB_CONNECTABLE=$(mysql -e 'status' >/dev/null 2>&1; echo "$?")
    if [[ DB_CONNECTABLE -eq 0 ]]; then
        break
    fi
    sleep 5
done

if [[ $DB_CONNECTABLE -eq 0 ]]; then
    DB_EXISTS=$(mysql -e "SHOW DATABASES LIKE '"wordpress"';" 2>&1 |grep "wordpress" > /dev/null ; echo "$?")

    if [[ DB_EXISTS -eq 1 ]]; then
        echo "=> Creating database wordpress"
        RET=$(mysql -e "CREATE DATABASE wordpress")
        if [[ RET -ne 0 ]]; then
            echo "Cannot create database for wordpress"
            exit RET
        fi
        if [ -f /init/wordpress.sql ]; then
            echo "=> Loading initial database data to wordpress"
            RET=$(mysql wordpress < /init/wordpress.sql)
            if [[ RET -ne 0 ]]; then
                echo "Cannot load initial database data for wordpress"
                exit RET
            fi
        fi
        echo "=> Done!"
    else
        echo "=> Skipped creation of database wordpress – it already exists."
    fi
else
    echo "Cannot connect to Mysql"
    exit $DB_CONNECTABLE
fi
fg
