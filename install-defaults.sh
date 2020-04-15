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
                     redshift

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


# old 
#gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['']"
#settings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['']"
#gsettings set org.gnome.settings-daemon.plugins.media-keys home '<Super>e'
#gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
#gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "['<Shift><Super>Left']"  
#gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "['<Shift><Super>Right']"  


# get configs
#dconf dump /org/gnome/desktop/wm/keybindings/  > keybindings.dconf

#remember to set SSH_URL to file
#dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/  > custom-keybindings.dconf

#dconf dump /org/gnome/terminal/legacy/profiles:/  > terminal-profiles.dconf

echo ""
echo "${bold}Set keybinds${normal}"
echo ""

wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/keybindings.dconf -O ~/keybindings.dconf
dconf load /org/gnome/desktop/wm/keybindings/ < ~/keybindings.dconf
rm ~/keybindings.dconf


echo ""
echo "${bold}Set custom keybinds${normal}"
echo ""

wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/custom-keybindings.dconf -O ~/custom-keybindings.dconf
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/custom-keybindings.dconf
rm ~/custom-keybindings.dconf

echo ""
echo "${bold}Set terminal profiles${normal}"
echo ""
echo "${bold}Set SSH user@url: ${normal}"
read ssh_url
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/terminal-profiles.dconf -O ~/terminal-profiles.dconf
sed -ri "s/SSH_URL/$ssh_url/" ~/custom-keybindings.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < ~/terminal-profiles.dconf
rm ~/terminal-profiles.dconf


##
echo ""
echo "${bold}Set menu key to super key${normal}"
sudo sed -i 's/Menu/Super_R/' /usr/share/X11/xkb/symbols/pc
echo ""


##
echo ""
echo "${bold}Setup tilix as default and get default config${normal}"
echo ""
sudo update-alternatives --config x-terminal-emulator

# Get config file
# dconf dump /com/gexperts/Tilix/ > ~/tilix.dconf
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/tilix.dconf -O ~/tilix.dconf
dconf load /com/gexperts/Tilix/ < ~/tilix.dconf
rm ~/tilix.dconf

#get phpstorm default watchers
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/watchers.xml -O ~/watchers.xml

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

##
echo ""
echo "${bold}Install PulseEffects and Racle preset${normal}"
echo ""
sudo add-apt-repository ppa:mikhailnov/pulseeffects -y
sudo apt-get install -y pulseeffects pulseaudio --install-recommends
mkdir -p ~/.config/pulse/presets
wget wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/PulseEffectsRacle.preset -O ~/.config/pulse/presets/Racle.preset

