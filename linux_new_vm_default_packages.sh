#!/bin/bash

if [ -f "/etc/system-release" ]; then
	os_type=`head -n1 /etc/system-release`
	if [[ $os_type == "CentOS"* ]]; then
        echo "CentOS"
        # Write down commands for ansible installation for centos
	elif [[ $os_type == "Amazon"* ]]; then
        echo "Amazon EC2"
        # Write down commands for ansible installation for ec2
	fi
elif [ -f "/etc/os-release" ]; then
	grep Ubuntu /etc/os-release
	if [[ $? == 0 ]]; then
		echo "UPDATING ALL PACKAGES"
		sudo apt update -y
		for i in 1 2 3 4 5
		do
			echo "					"
		done
		echo "INSTALLING software-properties-common"
		sudo apt install software-properties-common -y
		for i in 1 2 3 4 5
		do
			echo "					"
		done
		echo "INSTALLING ppa:ansible/ansible REPOSITORY"
		sudo apt-add-repository --yes --update ppa:ansible/ansible -y
		for i in 1 2 3 4 5
		do
			echo "					"
		done
		echo "INSTALLING ANSIBLE"
		sudo apt install ansible -y
	fi
fi
