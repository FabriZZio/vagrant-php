Vagrant PHP
===========
This is a Vagrant (http://www.vagrantup.com) box setup with a LAMP stack for developing PHP 5.3+ applications.

The main goal of this project is to provide a virtual machine containing all required tools for a modern PHP application (think: Symfony2, ZF2, ...)

What do I get?
--------------

The following is a list of pre-installed software packages:

- PHP 5.3.+ (latest via dotdeb)
- MySQL 5.5.28
- Apache 2.2.22

Non-standard PHP Modules:
- apc
- curl
- gd
- gearman
- mbstring
- mcrypt
- memcache
- mysql
- mysqli
- mysqlnd
- openssl
- pcntl
- PDO
- pdo_mysql
- pdo_sqlite
- SQLite
- sqlite3
- xdebug
- xhprof
- xmlrpc
- zip
- Xdebug

Extra tools/packages:

- git
- sendmail
- capistrano
- curl
- gearman
- memcached
- sqlite3
- PHPMyAdmin
- PHPUnit
- webgrind
- supervisord


This list is configured using the `roles/lamp.json` file,
so you can easily create another role with only the required packages of your choice.
Using your own role is as easy as defining it in the main `Vagrantfile`:

    config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "cookbooks"
        chef.roles_path = "roles"
        chef.add_role "<your-custom-role>"

Box setup
---------
This box requires the default Ubuntu Precise64 base box (http://files.vagrantup.com/precise64.box) and will be downloaded automatically when you don't have it already.

PHP is set up using PHP-FPM running as user `vagrant` avoiding any possible permission issues.

MySQL is set up to use UTF-8 encoding.

Port forwarding has been setup as following:

- local port 8000 maps to port 80 on the box (Apache)
- local port 9000 maps to port 9001 on the box (Supervisord)

SSH agent forwarding has been activated so you can use git within your vagrant box.
Make sure you allow ssh agent forwarding on your physical machine. See (https://help.github.com/articles/using-ssh-agent-forwarding)

VirtualBox Guest Additions
--------------------------

> todo: provide base box precise64 voor versie VB 4.2.6.

How to use
----------

1) Integrating Vagrant-PHP can easily be done trough Composer (http://www.getcomposer.org):

    {
        require: {
            "fabrizzio/vagrant-php": "dev-develop"
        }
    }

A Composer install script `bin/install` has been provided so Composer can load this project's dependencies automagically.

2) You might consider copying the "Vagrantfile" in this repository into your project's root folder. (or you might create a new one through `vagrant init`)

3) startup your vagrant virtual machine

    vagrant up

4) the "docs" folder is configured as the default Apache vhost, and accessible through http://localhost:8000

5) login to your freshly installed pimped out chromed out dev box:

    vagrant ssh

MySQL
-----

MySQL has been installed with the most original root password ever invented: `root`.

Using Webgrind
--------------

XDebug and Webgrind have been installed allowing you to easily profile your application. You can access webgrind via the Apache Vhost alias `/webgrind`:

![PHPInfo with Xdebug enabled](http://github.com/FabriZZio/vagrant-php/raw/develop/images/phpinfo_xdebug.png)

Mind the ?XDEBUG_PROFILE=1 flag to enable profiling for this request, resulting in the following webgrind profile:

![Webgrind PHPInfo](http://github.com/FabriZZio/vagrant-php/raw/develop/images/webgrind.png)

Supervisord
-----------

Supervisord is a daemon taking care of your background processes. (http://www.supervisord.org)
You can define your supervisord configuration in `/etc/supervisor/conf.d/`.
The interface is available on port 9000:

![Supervisord interface](http://github.com/FabriZZio/vagrant-php/raw/develop/images/supervisord.png)


Todo
----

- Move apc.php and memcache.php naar vhost alias
- sphinx + graphviz
- node for requireJs optimizations
