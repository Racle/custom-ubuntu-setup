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
  cd /tmp || exit
  rm -rf go*.tar.gz
  LATEST_GO_VERSION="$(curl --silent "https://go.dev/VERSION?m=text" | head -n 1)"
  LATEST_GO_DOWNLOAD_URL="https://go.dev/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz"
  wget "$LATEST_GO_DOWNLOAD_URL"
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
  rm /tmp/dotnet-install.sh
)

##
echo ""
echo "${bold}Install kitty and set as default terminal${normal}"
echo ""
sudo sh ./files/setup/kitty.sh

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
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

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
echo "${bold}Install terraform${normal}"
echo ""
{
  wget -O- https://apt.releases.hashicorp.com/gpg |
    gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null

  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update
  sudo apt-get install terraform -y
}

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
