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
5. After the process is complete, go to the folder `vvv-bypronto/www/wordpress-develop/web` and run `git reset --hard HEAD`.

Running WordPress Unit Tests on VVV
-----------------------------------

1. Turn on the VVV machine, run `vagrant up`.
2. Run `vagrant ssh`.
3. Go to the folder `/srv/www/wordpress-develop/web`.
4. Run `phpunit`.
