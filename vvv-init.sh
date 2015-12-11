# Init script for WordPress trunk site

# Install required packages
apt-get -y install curl libcurl3 libcurl3-dev php5-curl

# Install HHVM
echo "Setup the HHVM repository"
sudo wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
sudo apt-get update
sudo apt-get install hhvm -y --force-yes
sudo update-rc.d hhvm defaults
sudo apt-get -y install libgmp-dev libmemcached-dev

# Restart NGINX and HHVM
echo "Restart nginx to apply HHVM changes"
sudo service nginx restart
sudo service hhvm restart

echo "Copying NGINX WordPress subdirectory configuration"
cd /
sudo cp /srv/www/nginx-wp-with-hhvm.conf-sample /etc/nginx/nginx-wp-with-hhvm.conf
echo " * /srv/www/nginx-wp-with-hhvm.conf -> /etc/nginx/nginx-wp-with-hhvm.conf"

echo "Commencing Bypronto Setup"

# Make a database, if we don't already have one
echo "Creating Bypronto database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS bypronto"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON bypronto.* TO wp@localhost IDENTIFIED BY 'wp';"

# Make a database, if we don't already have one
echo "Creating Bypronto database for test (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS bypronto_test"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON bypronto_test.* TO wp@localhost IDENTIFIED BY 'wp';"

rm -rf /srv/www/wordpress-develop/
ln -sf /srv/www/bypronto /srv/www/wordpress-develop
cp /srv/www/wp-tests-config.php /srv/www/wordpress-develop/web/
cp /srv/www/bootstrap.php /srv/www/wordpress-develop/tests/phpunit/includes/

# Generate the wp-config file
wp core config --dbname="bypronto" --dbuser=root --dbpass=root --dbhost="localhost" --allow-root --path=/srv/www/wordpress-develop/web/ --extra-php <<PHP
\$memcached_servers = array( 'default' => array( '127.0.0.1:11211' ) );
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'SAVEQUERIES', true );
define( 'DEVBAR_NOTIFY', true );
PHP

# Install multisite
wp core multisite-install --url=local.bypronto.dev --subdomains --title="Phoenix Test" --admin_user=admin --admin_password=password --admin_email=admin@pronto.com --allow-root --path=/srv/www/wordpress-develop/web/
wp theme activate phoenix-child --allow-root --path=/srv/www/wordpress-develop/web/

# Install plugins
wp plugin install debug-bar --activate --allow-root --path=/srv/www/wordpress-develop/web
wp plugin install log-deprecated-notices --activate --allow-root --path=/srv/www/wordpress-develop/web/

# Enable Object Cache on Bypronto.
echo "Enable Object Cache on Bypronto"
ln -s /srv/www/wordpress-develop/conf/object-cache.php /srv/www/wordpress-develop/web/wp-content/

# Install WP Mock
echo "Install WP Mock on Bypronto"
composer require --dev 10up/wp_mock:dev-master
mv composer.json /srv/www/wordpress-develop/web/
mv composer.lock /srv/www/wordpress-develop/web/
mv vendor /srv/www/wordpress-develop/web/

## The Vagrant site setup script will restart Nginx for us

## Let the user know the good news
echo "Bypronto site is now installed!";
