#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
echo "<h2>Apache WebServer</h2><br>Server bootstrapped by Terraform" > /var/www/html/index.html
sudo service httpd start
sudo chkconfig httpd on