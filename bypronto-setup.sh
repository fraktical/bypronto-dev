git clone git://github.com/Varying-Vagrant-Vagrants/VVV.git vvv-bypronto
cp vvv-hosts vvv-bypronto/www/
cp vvv-init.sh vvv-bypronto/www/
cp vvv-nginx.conf vvv-bypronto/www/
cp wp-tests-config.php vvv-bypronto/www/
git clone git@github.com:prontodev/bypronto.git vvv-bypronto/www/bypronto
mv vvv-bypronto ..
cd ../vvv-bypronto/
