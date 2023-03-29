#!/bin/bash
yum install java-11-openjdk-devel -y
yum install wget -y
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins