# Init script for WordPress trunk site

echo "Commencing Bypronto Setup"

# Make a database, if we don't already have one
echo "Creating Bypronto database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS bypronto"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON bypronto.* TO wp@localhost IDENTIFIED BY 'wp';"

# Make a database, if we don't already have one
echo "Creating Bypronto database for test (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS bypronto_test"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON bypronto_test.* TO wp@localhost IDENTIFIED BY 'wp';"

# Checkout, install and configure WordPress trunk via develop.svn
if [[ ! -d "/srv/www/wordpress-test" ]]; then
    echo "Checking out WordPress trunk from develop.svn, see http://develop.svn.wordpress.org/trunk"
    svn checkout http://develop.svn.wordpress.org/trunk/ /srv/www/wordpress-test
    cp /srv/www/wp-tests-config.php /srv/www/wordpress-test/
fi

mv /srv/www/bypronto/ /srv/www/wordpress-test/

# Generate the wp-config file
wp core config --dbname="bypronto" --dbuser=root --dbpass=root --dbhost="localhost" --allow-root --path=/srv/www/wordpress-test/bypronto/ --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'SAVEQUERIES', true );
define( 'DEVBAR_NOTIFY', true );
PHP

# Install multisite
wp core multisite-install --url=local.bypronto.dev --subdomains --title="Bypronto" --admin_user=admin --admin_password=password --admin_email=admin@pronto.com --allow-root --path=/srv/www/wordpress-test/bypronto/
wp theme activate phoenix-child --path=/srv/www/wordpress-test/bypronto/

# Install plugins
wp plugin install debug-bar --activate --path=/srv/www/wordpress-test/bypronto/
wp plugin install log-deprecated-notices --activate --path=/srv/www/wordpress-test/bypronto/

## The Vagrant site setup script will restart Nginx for us

## Let the user know the good news
echo "Bypronto site is now installed!";
