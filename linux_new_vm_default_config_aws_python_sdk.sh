#!/bin/bash

mkdir ~/.aws
cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id = xxxxxxxxxxxxxxxxxxx
aws_secret_access_key = yyyyyyyyyyyyyyyyyyyyyy
region=ap-south-1
EOF
