#!/bin/sh
set -e

sudo apt-get update
sudo apt-get install -V -y apache2

echo "
$ sudo service apache2 [stop|start|reload|restart]

Hold/unhold a package using apt-mark
$ sudo apt-mark hold apache2
$ sudo apt-mark unhold apache2

Help:
$ apache2 -h

Version and compiled modules:
$ apache2 -v
$ apache2 -V

Test Install:
$ curl http://$(hostname -I)

Config:
It is split into several files forming the configuration hierarchy outlined
below, all located in the /etc/apache2/ directory:

	/etc/apache2/
	|-- apache2.conf
	|	'--  ports.conf
	|-- mods-enabled
	|	|-- *.load
	|	'-- *.conf
	|-- conf-enabled
	|	'-- *.conf
	'-- sites-enabled
	 	'-- *.conf


* apache2.conf is the main configuration file (this file). It puts the pieces
  together by including all remaining configuration files when starting up the
  web server.

* ports.conf is always included from the main configuration file. It is
  supposed to determine listening ports for incoming connections which can be
  customized anytime.

* Configuration files in the mods-enabled/, conf-enabled/ and sites-enabled/
  directories contain particular configuration snippets which manage modules,
  global configuration fragments, or virtual host configurations,
  respectively.

  They are activated by symlinking available configuration files from their
  respective *-available/ counterparts. These should be managed by using our
  helpers a2enmod/a2dismod, a2ensite/a2dissite and a2enconf/a2disconf. See
  their respective man pages for detailed information.

* The binary is called apache2. Due to the use of environment variables, in
  the default configuration, apache2 needs to be started/stopped with
  /etc/init.d/apache2 or apache2ctl. Calling /usr/bin/apache2 directly will not
  work with the default configuration.

"
