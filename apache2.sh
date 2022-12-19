#!/bin/bash

sudo apt-get update 
sudo apt-get install apache2 default-mysql-client libapache2-mod-php php php-pear php-mysql php-gd -y
echo '<!doctype html><html><body><h1>Hello You Successfully was able to run a webserver on GCP with Terraform!</h1></body></html>' | sudo tee /var/www/html/index.html
echo '<?php phpinfo (); ?>' | sudo tee /var/www/html/phpinfo.php
sudo chown -R www-data:www-data /var/www
sudo a2enmod rewrite
sudo phpenmod mcrypt
sudo systemctl restart apache2
