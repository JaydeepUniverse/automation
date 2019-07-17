#!/bin/bash

pip3.7 install awscli --upgrade --user
grep "export PATH\=\/root\/\.local\/bin\:\$PATH" ~/.bash_profile
ret_status=`echo $?`
if [ $ret_status == 1 ];
then
	sed -i '/^export PATH/i export PATH=/root/.local/bin:$PATH'  ~/.bash_profile
else
	grep "export PATH\=\/root\/\.local\/bin\:\$PATH" ~/.bash_profile
fi
mkdir ~/.aws
echo "Enter aws_access-Key_id"
read aws_access_key_id
echo "Enter aws_secret_access_key"
read aws_secret_access_key
cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id = $aws_access_key_id
aws_secret_access_key = $aws_secret_access_key
region=ap-south-1
EOF
