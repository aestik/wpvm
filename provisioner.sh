#!/bin/bash

# before installing
sudo apt-get update
sudo apt-get upgrade -y

# prepare password for mysql installation
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password mysqlhehehe'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password mysqlhehehe'

# installing packages
sudo apt-get install -y unzip php5 php5-curl php5-common php5-gd php5-imagick php5-mcrypt php5-memcache php5-memcached php5-mysql apache2 mysql-server-5.5 mysql-client vim zsh

# setup apache2 & mysql
sudo a2enmod rewrite
sudo service apache2 restart
