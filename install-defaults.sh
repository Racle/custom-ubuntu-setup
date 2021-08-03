bold=$(tput bold)
normal=$(tput sgr0)

echo ""
echo "${bold}Set ubuntu mirror to fi${normal}"
echo ""
sudo sed -i 's/us.archive/fi.archive/' /etc/apt/sources.list

echo ""
echo "${bold}Install nodejs 14 repo${normal}"
echo ""
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

echo ""
echo "${bold}Install neovim repo${normal}"
echo ""
sudo add-apt-repository ppa:neovim-ppa/unstable

##
echo ""
sudo echo "${bold}Install defaults${normal}"
echo ""
sudo apt-get install -y zsh \
                     git \
                     apt-transport-https \
                     ca-certificates \
                     curl \
                     gnupg-agent \
                     python3 \
                     python3-pip \
                     neovim \
                     python-dev \
                     build-essential \
                     cmake \
                     xsel \
                     rlwrap \
                     gnome-tweak-tool \
                     tilix \
                     code \
                     shellcheck \
                     redshift \
                     snapd \
                     stow \
                     nodejs \
                     chrome-gnome-shell \
                     xclip \
                     copyq \
                     flameshot \
                     silversearcher-ag \
                     powerline \
                     tmux \
                     ranger \
                     libxext-dev \
                     atool \
                     caca-utils \
                     highlight \
                     w3m \
                     poppler-utils \
                     mediainfo \
                     ripgrep \
                     zathura \
                     meld \
                     expect \
                     proxychains


##
echo ""
echo "${bold}Install go${normal}"
echo ""
sudo snap install --classic go

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
wget "https://discordapp.com/api/download?platform=linux&format=deb" -O ~/discord.deb
sudo dpkg -i ~/discord.deb
rm ~/discord.deb

##
echo ""
echo "${bold}Install docker + docker-compose${normal}"
echo ""
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   bionic \
   stable"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

##
echo ""
echo "${bold}Check latest version at https://docs.docker.com/compose/install/${normal}"
echo ""
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose
#sudo usermod -aG docker $USER
#newgrp docker

##
echo ""
echo "${bold}Install albert${normal}"
echo ""
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key -O Release.key
sudo apt-key add - < Release.key
rm Release.key
sudo apt-get update
sudo apt-get instal -y albert

##
echo ""
echo "${bold}Install gnome templates${normal}"
echo ""
cp ./files/Templates.tar.gz ~/Templates.tar.gz
tar -xzvf ~/Templates.tar.gz
rm ~/Templates.tar.gz

##
echo ""
echo "${bold}Install tmux plugin manager${normal}"
echo ""
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

##
echo ""
echo "${bold}Install ueberzug (plugin for image preview in ranger)${normal}"
echo ""
sudo pip3 install ueberzug

##
echo ""
echo "${bold}Install ranger icons${normal}"
echo ""
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

##
echo ""
echo "${bold}Install lazygit${normal}"
echo ""
sudo apt install -f
sudo add-apt-repository ppa:lazygit-team/release -y
sudo apt install -y lazygit

##
echo ""
echo "${bold}Set max file watchers${normal}"
echo ""
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl --system

##
echo ""
echo "${bold}Set cursor repeat rate (xset r rate 210 30) (add also to .profile)${normal}"
echo ""
xset r rate 210 30

##
echo ""
echo "${bold}(copied to clipboard) run manually sudo chmod +x /usr/local/bin/docker-compose && sudo usermod -aG docker $USER && newgrp docker${normal}"
echo ""
echo "sudo chmod +x /usr/local/bin/docker-compose && sudo usermod -aG docker \$USER && newgrp docker" | xclip -sel clip
