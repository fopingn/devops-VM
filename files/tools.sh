#!/bin/bash
 sudo  yum -y update
 sudo  yum -y install git
 sudo  yum -y install openssl
# Installation docker and docker-compose
 sudo  yum -y install docker
 usermod -a -G docker ec2-user
 sudo  yum -y install python3-pip
 pip3 install --user docker-compose
 sudo  systemctl enable docker.service
 sudo  systemctl start docker.service

# Installation kubectl
 curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.7/2022-06-29/bin/linux/amd64/kubectl
 sudo chmod +x ./kubectl
 mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
 echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

# Installation ssm-agent
 sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
 sudo systemctl enable amazon-ssm-agent
 sudo systemctl start amazon-ssm-agent

# Installation ssm-session
 pip3 install aws-ssm-tools

# Installation Helm
 curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
 chmod 700 get_helm.sh
 ./get_helm.sh
# Installation ssm-plugin
 curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm"
 sudo yum install -y session-manager-plugin.rpm

