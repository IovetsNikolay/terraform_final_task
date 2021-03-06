#!/bin/bash
echo "--------START----------"
sudo yum -y update
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo yum install jenkins java-1.8.0-openjdk-devel -y
sudo systemctl daemon-reload
sudo service jenkins start
echo "--------FINISH----------"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "--------GET_TERRAFORM----------"
wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
unzip terraform_0.13.5_linux_amd64.zip
sudo mv terraform /usr/bin/
echo "--------GET_DOCKER_ENGINE----------"
sudo yum update -y
sudo yum install docker -y
sudo sudo chkconfig docker on
sudo service docker start
echo "--------GET_GIT----------"
sudo yum install git -y
echo "--------GET_ANSIBLE----------"
sudo amazon-linux-extras install ansible2 -y
echo "--------FINISH_INSTALL----------"