#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo bash -c 'echo The IP of the instance is $(hostname -I) > /var/www/html/index.html'
