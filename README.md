Vagrant PHP
===========
This is a Vagrant (http://www.vagrantup.com) box setup with a LAMP stack for developing PHP applications.

Requirements:

- default "lucid32" base box (http://files.vagrantup.com/lucid32.box)

PHP:

- latest official supported version for Ubuntu Server 10.0.4 LTS (Lucid Lynx)
- predefined set of parameters through custom .ini file

MySQL:

- username: root
- password: root

Additional packages:

- PHPUnit
- XDebug

How to use
----------

1) add the packaged box generated from this source code to vagrant

vagrant box add vagrant-php http://dl.dropbox.com/u/68032224/package.box

2) in your project folder, initialize vagrant

vagrant init

3) startup your vagrant virtual machine

vagrant up

4) the "public" folder is configured as the default Apache vhost, and accessible through http://localhost:8080 (port 80 has been mapped to port 8080)

Remarks
-------

Using a MySQL database on your Vagrant setup
********************************************

When destroying a Vagrant virtual machine, all data that has been saved in the virtual machine will be lost. This means that if you choose to use the MySQL database in Vagrant, you should only suspend the virtual machine so you can easily resume it later without loss of data.
Another option is to connect from Vagrant to a MySQL database running on your physical machine.
Your project code is safe since it is accessed using Oracle VirtualBox shared folder functionality (so it is on your physical machine).

Warning
-------

The purpose of this setup is creating an easy-to-use development box for our team at Marlon (http://www.marlon.be/).
It is in no way meant to be used in a production environment.