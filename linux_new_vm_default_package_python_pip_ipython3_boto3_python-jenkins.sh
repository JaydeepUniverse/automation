#!/bin/bash

yum update -y

# PYTHON
# PIP
# IPYTHON
# BOTO3
# INSTALLATION ##########################
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
        pip3.7 install boto3
		pip3.7 install python-jenkins
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
        pip3 install boto3
		pip3 install python-jenkins
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
