#!/bin/bash

yum update -y
yum install -y python2-virtualenv

############### AZ CLI INSTALLATION ###########################
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
cliVersion=`tail -n3 index.html | head -n1 | cut -d "\"" -f 2`
wget https://packages.microsoft.com/yumrepos/azure-cli/$cliVersion
rpm -ivh $cliVersion
