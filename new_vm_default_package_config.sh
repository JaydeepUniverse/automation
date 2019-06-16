#!/bin/bash

############### KUBECTL INSTALLATION ###########################
cat <<EOF > /etc/yum.repos.d/kubernetes.repo  
[kubernetes]  
name=Kubernetes  
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64  
enabled=1  
gpgcheck=1  
repo_gpgcheck=0 
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg  
EOF

yum install -y kubectl

kubectl version

############### AZ CLI INSTALLATION ###########################
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
cliVersion=`tail -n3 index.html | head -n1 | cut -d "\"" -f 2`
wget https://packages.microsoft.com/yumrepos/azure-cli/$cliVersion
rpm -ivh $cliVersion

############### GIT INSTALLATION ###########################
yum install -y git
git config --global user.mail "ecjaydeepsoni@gmail.com"
git config --global user.name "jaydeepuniverse"
