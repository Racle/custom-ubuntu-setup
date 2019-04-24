sudo apt-get install zsh git apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# install google-chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get install docker-ce docker-ce-cli containerd.io

# check latest version at https://docs.docker.com/compose/install/
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker $USER
newgrp docker

# change apt mirror to FI
sudo apt install python3 python3-pip
sudo pip3 install apt-select
cd /tmp
sudo apt-select -C FI
sudo mv /etc/apt/source.list  /etc/apt/source.list.bak
sudo cp source.list /etc/apt/
