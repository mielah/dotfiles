#!/bin/bash

sudo yum update -y

#Uninstall docker
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

#Install Docker
sudo yum install -y docker

sudo service docker start

sudo docker run hello-world

#Install Node.js
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

. ~/.nvm/nvm.sh

nvm install 8.11.3

node -e "console.log('Running Node.js ' + process.version)"


#Install Golang
sudo yum install -y golang


#Install VS code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo yum install -y code

#Changing to zsh shell: right click terminal, go to Title and Command, check all checkboxes
#and set custom command to zsh

#Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#Set locale
sudo localedef -c -i en_US -f UTF-8 en_US.UTF-8

#create rsa key pair
if ! [ -e ~/.ssh/id_rsa.pub ]
then    
    ssh-keygen -o
fi

#get public key
cat ~/.ssh/id_rsa.pub

echo "Press enter when SSH key has been added"

read

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_rsa

#Check ssh connection
ssh -T git@github.com


#Add go path variables to .bash_profile
if ! grep --quiet "export GOROOT=/usr/lib/golang" ~/.bash_profile 
then
    echo "export GOROOT=/usr/lib/golang" >> ~/.bash_profile
fi

if ! grep --quiet "export GOPATH=$HOME/projects" ~/.bash_profile 
then
    echo "export GOPATH=$HOME/projects" >> ~/.bash_profile
fi

if ! grep --quiet "export PATH=$PATH:$GOROOT/bin" ~/.bash_profile 
then
    echo "export PATH=$PATH:$GOROOT/bin" >> ~/.bash_profile
fi
