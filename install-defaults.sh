bold=$(tput bold)
normal=$(tput sgr0)

##
echo "${bold}Install defaults${normal}"
echo ""
sudo apt-get install zsh git apt-transport-https ca-certificates curl gnupg-agent software-properties-common python3 python3-pip fonts-powerline

##
echo ""
echo "${bold}Install google-chrome${normal}"
echo ""
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

##
echo ""
echo "${bold}Install docker + docekr-compose${normal}"
echo ""
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get install docker-ce docker-ce-cli containerd.io

##
echo ""
echo "${bold}Check latest version at https://docs.docker.com/compose/install/${normal}"
echo ""
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker $USER
newgrp docker

##
echo ""
echo "${bold}Change apt mirror to FI${normal}"
echo ""
sudo pip3 install apt-select
cd /tmp
sudo apt-select -C FI
sudo mv /etc/apt/source.list  /etc/apt/source.list.bak
sudo cp source.list /etc/apt/
