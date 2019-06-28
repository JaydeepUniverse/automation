#!/bin/bash

install_docker_in_centos()
{
    	yum update -y
	yum install -y yum-utils device-mapper-persistent-data lvm2
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	yum install -y docker-ce docker-ce-cli containerd.io
	systemctl start docker
	systemctl enable docker
	docker run hello-world
}

install_python3_in_amazonec2()
{
	yum update -y
	amazon-linux-extras install docker -y
	systemctl start docker
	systemctl enable docker
	docker run hello-world
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
