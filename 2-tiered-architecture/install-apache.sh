#!/bin/bash

#Update all yum package repositories
yum update -y

#Install Apache Web Server
yum install -y httpd.x86_64

#Start and Enable Apache Web Server
systemctl start httpd.service
systemctl enable httpd.service

#Adds our custom webpage html code to "index.html" file.
echo "<html><body><h1>Welcome to REX TECH!</h1></body><html>" > /var/www/html/index.html