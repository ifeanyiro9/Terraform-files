#!/bin/bash
yum install java-11-openjdk-devel -y
yum install wget -y
yum install firewalld -y
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --add-port=8080/tcp --permanent
firewall-cmd --reload