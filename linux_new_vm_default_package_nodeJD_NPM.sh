#!/bin/bash

curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
yum install nodejs -y
node --version
npm --version
