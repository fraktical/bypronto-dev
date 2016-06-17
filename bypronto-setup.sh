git clone -b '1.3.0' git://github.com/Varying-Vagrant-Vagrants/VVV.git vvv-bypronto
cp vvv-hosts vvv-bypronto/www/
cp vvv-init.sh vvv-bypronto/www/
cp vvv-nginx.conf vvv-bypronto/www/
cp nginx-wp-with-hhvm.conf-sample vvv-bypronto/www/
cp wp-tests-config.php vvv-bypronto/www/
cp bootstrap.php vvv-bypronto/www/
git clone git@github.com:prontodev/bypronto.git vvv-bypronto/www/bypronto
mv vvv-bypronto ..

echo "The folder 'vvv-bypronto' is created outside this folder."
echo "Go to that folder and run 'vagrant up'."
