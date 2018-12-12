#!/bin/sh

sudo mkdir /var/www
sudo apt-get update -y
sudo apt-get install nfs-common -y
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-b39d567b.efs.eu-west-1.amazonaws.com:/ /var/www
sudo apt-get install apache2 php php-{bcmath,bz2,intl,gd,mbstring,mysql,zip}
sudo systemctl start apache2.service
sudo systemctl enable apache2.service
