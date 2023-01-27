bold=$(tput bold)
normal=$(tput sgr0)

echo ""
echo "${bold}Set ubuntu mirror to fi${normal}"
echo ""
# Deprecated
# sudo sed -i 's/us.archive/fi.archive/' /etc/apt/sources.list
sudo sed -i 's/us.archive/fi.archive/' /etc/apt/sources.list.d/system.sources

echo ""
echo "${bold}Install nodejs 16 repo${normal}"
echo ""
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -

echo ""
echo "${bold}Install neovim repo${normal}"
echo ""
sudo add-apt-repository ppa:neovim-ppa/unstable

echo ""
echo "${bold}Enable gnome tweak tool repo${normal}"
echo ""
sudo add-apt-repository universe

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
  build-essential \
  cmake \
  xsel \
  rlwrap \
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
  proxychains \
  redis-tools \
  gnome-tweaks

##
echo ""
echo "${bold}Install go${normal}"
echo ""
(
  cd /tmp
  rm -rf go*.tar.gz
  wget https://go.dev/dl/go1.19.2.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go*.tar.gz
  rm -rf go*.tar.gz
)
# sudo snap install --classic go

##
echo ""
echo "${bold}Install rust${normal}"
echo ""
curl https://sh.rustup.rs -sSf | sh

##
echo ""
echo "${bold}Install dotnet${normal}"
echo ""
(
  cd /tmp
  wget https://dot.net/v1/dotnet-install.sh
  sudo chmod +x dotnet-install.sh
  ./dotnet-install.sh --version latest
  # if omnisharp languageserver doesn't work, try this
  #./dotnet-install.sh  --channel 7.0
  rm /tmp/dotnet-install.sh
)

##
echo ""
echo "${bold}Install kitty and set as default terminal${normal}"
echo ""
sudo sh ./files/setup/kitty.sh

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
echo "${bold}Install docker + docker-compose${normal}"
echo ""
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable"
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

#sudo chmod +x /usr/local/bin/docker-compose
#sudo usermod -aG docker $USER
#newgrp docker

##
# echo ""
# echo "${bold}Install albert${normal}"
# echo ""
# sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
# wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key -O Release.key
# sudo apt-key add - < Release.key
# rm Release.key
# sudo apt-get update
# sudo apt-get instal -y albert

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
echo "${bold}Install lazygit with go${normal}"
echo ""
go install github.com/jesseduffield/lazygit@latest
# old way
# sudo apt install -f
# sudo add-apt-repository ppa:lazygit-team/release -y
# sudo apt install -y lazygit
# echo "${bold}Change impish to hirsute in lazygit source${normal}"
# sudo sed -i 's/impish/hirsute/g' /etc/apt/sources.list.d/lazygit-team-ubuntu-release-impish.list

##
echo ""
echo "${bold}Install delta https://github.com/dandavison/delta/releases${normal}"
echo ""
wget https://github.com/dandavison/delta/releases/download/0.12.1/git-delta_0.12.1_amd64.deb
sudo dpkg -i git-delta_0.12.1_amd64.deb
rm git-delta*.deb

##
echo ""
echo "${bold}Install flatpak packages${normal}"
echo ""
flatpak install flathub dev.rdm.RDM
flatpak install flathub com.getpostman.Postman
flatpak install flathub com.discordapp.Discord
flatpak install com.slack.Slack
flatpak install com.spotify.Client
flatpak install org.signal.Signal
#dbeaver + extras
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub io.dbeaver.DBeaverCommunity
sudo flatpak install io.dbeaver.DBeaverCommunity.Client.pgsql
sudo flatpak install io.dbeaver.DBeaverCommunity.Client.mariadb
flatpak install flathub com.github.tchx84.Flatseal

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
echo "${bold}Set neovim as default editor${normal}"
echo ""
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 100

##
echo ""
echo "${bold}(copied to clipboard) run manually sudo chmod +x /usr/local/bin/docker-compose && sudo usermod -aG docker $USER && newgrp docker${normal}"
echo ""
echo "sudo usermod -aG docker \$USER && newgrp docker" | xclip -sel clip
