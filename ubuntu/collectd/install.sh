#!/bin/sh

sudo apt-get install collectd collectd-utils

# example collection3
sudo cp -r /usr/share/doc/collectd-core/examples/collection3 /var/www/html
sudo apt-get install -y librrds-perl libconfig-general-perl libhtml-parser-perl  libregexp-common-perl
sudo a2enmod alias
sudo a2enmod cgi

echo "
Config file: /etc/collectd/collectd.conf

Add the following to /etc/apache2/site-available/000-default.conf:

    <Directory /var/www/html/collection3>
        Options +ExecCGI
        AddHandler cgi-script .cgi .pl
    </Directory>

References:
https://collectd.org/wiki/index.php/First_steps
http://www.cloudgurus.net/blog/2010/06/14/Collectd_part_1.html
http://www.unixmen.com/install-collectd-ubuntu-server-13-10/
"
