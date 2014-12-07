if  [ $# -lt 4 ]; then
  echo Usage: ./wordpress.sh https://exampledomain.com/ "Example Domain" "example" "example@elsewhere.com"
  exit 1
fi
echo Unpacking latest WordPress into /data/www-content...
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php /root/wp-cli.phar --path="/data/www-content" --allow-root core download
php /root/wp-cli.phar --path="/data/www-content" --allow-root core config --dbname=wordpress --dbuser=root
php /root/wp-cli.phar --path="/data/www-content" --allow-root db create
PWD=`pwgen 40 1`
php /root/wp-cli.phar --path="/data/www-content" --allow-root core install \
	--url="$1" --title="$2" --admin_user="$3" --admin_password="$PWD" --admin_email="$4"
php /root/wp-cli.phar --path="/data/www-content" --allow-root plugin install wordpress-https
php /root/wp-cli.phar --path="/data/www-content" --allow-root plugin activate wordpress-https
echo "user: $3" > /data/login.txt
echo "pass: $PWD" >> /data/login.txt
echo "Done, login details saved to /data/login.txt"
