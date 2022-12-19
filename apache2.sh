#!/bin/bash

apt-get update 
apt-get install apache2 default-mysql-client libapache2-mod-php php php-pear php-mysql php-gd -y
apt-get install wget -y
wget -P /var/www/html https://uk.wordpress.org/wordpress-5.6.9-uk.zip
unzip -j wordp*
rm wordpress-5.6.9-uk.zip
chown -R www-data:www-data /var/www
a2enmod rewrite
phpenmod mcrypt
systemctl restart apache2
