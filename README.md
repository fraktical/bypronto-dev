Bypronto Development
====================

Vagrant development for Bypronto based on VVV

Getting Started
---------------

0. Clone `git@github.com:prontodev/bypronto-dev.git` and go to bypronto-dev directory
1. Install Vagrant plugins. Run the following commands: (make sure you already upgraded Vagrant to the latest version)
  1. `vagrant plugin install vagrant-hostsupdater`
  2. `vagrant plugin install vagrant-triggers`
2. Run `sh bypronto-setup.sh`. 
3. The script above creates a new folder called `vvv-bypronto` outside this repository. We will go and do our development there.
4. Under the folder `vvv-bypronto`, run `vagrant up`. This will take time to finish up.
5. `vagrant ssh`
6. `rm -rf /srv/www/bypronto/web/wp-content/plugins/jetpack`
7. `mv /srv/www/wordpress-develop /srv/www/wordpress-develop-backup`
8. `ln -s /srv/www/bypronto /srv/www/wordpress-develop`

To solve Jetpack's issue on local for now, given we already removed Jetpack from the instruction above, follow these steps:

1. On Vagrant, run `wp theme activate twentyfifteen --allow-root --path=/srv/www/bypronto/web/`.
2. On Local, run `git reset --hard HEAD` in order to bring Jetpack back.
3. Go to the plugin page then activate Jetpack.
4. On Vagrant, run `wp theme activate phoenix-child --allow-root --path=/srv/www/bypronto/web/`.
5. The `local.bypronto.dev` should work with Phoenix theme now.

Running WordPress Unit Tests on VVV
-----------------------------------

1. Turn on the VVV machine, run `vagrant up`.
2. Run `vagrant ssh`.
3. Go to the folder `/srv/www/wordpress-develop/web`.
4. Run `phpunit`.
