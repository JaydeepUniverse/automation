#!/bin/bash

sudo apt-get update -y
echo "								"
echo "                                                          "
echo "                                                          "
echo "                                                          "
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
echo "                                                          "
echo "                                                          "
echo "                                                          "
echo "                                                          "
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "                                                          "
echo "                                                          "
echo "                                                          "
echo "                                                          "
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo "                                                          "
echo "                                                          "
echo "                                                          "
echo "                                                          "
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
echo "                                                          "
echo "                                                          "
echo "                                                          "
echo "                                                          "
sudo docker run hello-world
