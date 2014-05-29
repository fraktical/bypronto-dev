Bypronto Development
====================

Vagrant development for Bypronto based on VVV

Getting Started
---------------

1. Install Vagrant plugins. Run the following commands:
  1. `vagrant plugin install vagrant-hostsupdater`
  2. `vagrant plugin install vagrant-triggers`
2. Run `sh bypronto-setup.sh`. 
3. The script above creates a new folder called `vvv-bypronto` outside this repository. We will go and do our development there.
4. Under the folder `vvv-bypronto`, run `vagrant up`. This will take time to finish up.

Running WordPress Unit Tests on VVV
-----------------------------------

1. Turn on the VVV machine, run `vagrant up`.
2. Run `vagrant ssh`.
3. Go to the folder `/srv/www/wordpress-develop/bypronto`.
4. Run `phpunit`.
