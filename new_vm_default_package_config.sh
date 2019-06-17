#!/bin/bash

yum update -y

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

################ PYTHON and PIP INSTALLATION ##########################
install_python3_in_centos()
{
        yum install gcc openssl-devel bzip2-devel  libffi-devel -y
        cd /usr/src
        wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
        tar xzf Python-3.7.0.tgz
        cd Python-3.7.0
        ./configure --enable-optimizations
        make altinstall
        rm -f /usr/src/Python-3.7.0.tgz
        python3.7 -V
        pip3.7 install ipython
}

install_python3_in_amazonec2()
{
        yum install python3 -y
        python3 --version
        cd /usr/src
        curl -O https://bootstrap.pypa.io/get-pip.py
        python3 get-pip.py --user
        export PATH=~/.local/bin:$PATH
        source ~/.bash_profile
        pip3 --version
        pip3 install ipython
}

os_type=`head -n1 /etc/system-release`
if [[ $os_type == "CentOS"* ]]; then
        echo "CentOS"
        install_python3_in_centos
elif [[ $os_type == "Amazon"* ]]; then
        echo "Amazon EC2"
        install_python3_in_amazonec2
else
        echo "New OS Type"
fi
