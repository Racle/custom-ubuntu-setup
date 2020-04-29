bold=$(tput bold)
normal=$(tput sgr0)

##
sudo echo "${bold}Install defaults${normal}"
echo ""
sudo apt-get install -y zsh \
                     git \
                     apt-transport-https \
                     ca-certificates \
                     curl \
                     gnupg-agent \
                     software-properties-common \
                     python3 \
                     python3-pip \
                     fonts-powerline \
                     vim \
                     python-dev \
                     build-essential \
                     cmake \
                     python-software-properties \
                     xsel \
                     rlwrap \
                     gnome-tweak-tool \
                     tilix \
                     code \
                     shellcheck \
                     redshift \
                     snapd
##
echo ""
echo "${bold}Install go${normal}"
echo ""
sudo snap install --classic go

echo ""
echo "${bold}Install nodejs 12${normal}"
echo ""
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -

##
echo ""
echo "${bold}Install gnome templates${normal}"
echo ""
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/Templates.tar.gz -O ~/Templates.tar.gz 
tar -xzvf Templates.tar.gz
rm Templates.tar.gz

##
echo ""
echo "${bold}Setup tilix as default and get default config${normal}"
echo ""
sudo update-alternatives --config x-terminal-emulator

echo ""
echo "${bold}Install cheat${normal}"
echo ""
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cheat
sudo chmod +x /usr/local/bin/cheat

##
echo ""
echo "${bold}Install google-chrome${normal}"
echo ""
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/chrome.deb
sudo dpkg -i ~/chrome.deb
rm ~/chrome.deb

##
echo ""
echo "${bold}Install discord${normal}"
echo ""
wget https://discordapp.com/api/download?platform=linux&format=deb -O ~/discord.deb
sudo dpkg -i ~/discord.deb
rm ~/discord.deb

##
echo ""
echo "${bold}Install docker + docker-compose${normal}"
echo ""
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -y
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

##
echo ""
echo "${bold}Check latest version at https://docs.docker.com/compose/install/${normal}"
echo ""
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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

##
echo ""
echo "${bold}Install albert${normal}"
echo ""
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update
sudo apt-get install albert
