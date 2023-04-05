#!/bin/bash

#Update all yum package repositories
yum update -y

#Install Apache Web Server
yum install -y httpd.x86_64

#Start and Enable Apache Web Server
systemctl start httpd.service
systemctl enable httpd.service

#Install epel for easy access to install packages for commonly used software
amazon-linux-extras install epel -y

#Install stress to enable us to test EC2 Instance under stress work loads
yum install stress -y

#Adds our custom webpage html code to "index.html" file.
echo "<html><body><h1>Welcome to REX TECH!</h1></body><html>" > /var/www/html/index.html