#!/bin/bash
apt update && sudo apt upgrade -y
#Install Java:
apt install openjdk-8-jdk -y
#Add key for the Jenkins apt repository:
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
#Add Jenkins Apt Repo:
sh -c 'echo deb https://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
#Install Jenkins
apt-get install jenkins -y
#AWS-CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt install unzip -y
./aws/install 
echo 'jenkins ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
until [ id -u jenkins >/dev/null 2>&1 ];
do
    sleep 5
done
touch /var/lib/jenkins/.bashrc
chmod 776 /var/lib/jenkins/.bashrc