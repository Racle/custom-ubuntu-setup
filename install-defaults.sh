#!/bin/bash
set -eu

# Colors and styles
BOLD=$(tput bold)
RESET=$(tput sgr0)
BLUE=$(tput setaf 4)
GREEN=$(tput setaf 2)

print_title() {
  echo ""
  echo "${BLUE}==>${RESET} ${BOLD}${GREEN}$1${RESET}"
  echo ""
}

print_title "Set ubuntu mirror to fi"
echo ""
# Ubuntu 24.04 uses ubuntu.sources
if [ -f /etc/apt/sources.list.d/ubuntu.sources ]; then
  sudo sed -i 's/us.archive/fi.archive/' /etc/apt/sources.list.d/ubuntu.sources
elif [ -f /etc/apt/sources.list ]; then
  # Fallback for older Ubuntu versions
  sudo sed -i 's/us.archive/fi.archive/' /etc/apt/sources.list
fi

print_title "Install nodejs 22 repo"
echo ""
curl -sL https://deb.nodesource.com/setup_22.x | sudo -E bash -

print_title "Install neovim repo"
echo ""
# This script updates Neovim to the latest nightly AppImage version and extracts it.
(
  sudo bash ./files/setup/nvim.sh
)

print_title "Enable gnome tweak tool repo"
echo ""
sudo add-apt-repository universe -y

##
print_title "Install defaults"

echo ""
sudo apt-get install -y zsh \
  git \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  gnupg \
  python3 \
  python3-pip \
  build-essential \
  cmake \
  xsel \
  rlwrap \
  shellcheck \
  redshift \
  snapd \
  stow \
  nodejs \
  gnome-browser-connector \
  xclip \
  copyq \
  flameshot \
  silversearcher-ag \
  powerline \
  tmux \
  libxext-dev \
  atool \
  caca-utils \
  highlight \
  poppler-utils \
  mediainfo \
  ripgrep \
  zathura \
  meld \
  expect \
  redis-tools \
  gnome-tweaks \
  pipx \
  ffmpeg \
  7zip \
  jq \
  imagemagick \
  fd-find \
  gnome-terminal \
  flatpak

##
print_title "Disable screenshot sound"
sudo mv /usr/share/sounds/freedesktop/stereo/camera-shutter.oga /usr/share/sounds/freedesktop/stereo/camera-shutter-disabled.oga

##
print_title "Install go"
echo ""
(
  sudo bash ./files/setup/go.sh
)

##
print_title "Install rust & cargo"
echo ""
curl https://sh.rustup.rs -sSf | sh -s -- -y

##
print_title "Install yazi (file manager)"
echo ""
(
  # Ensure cargo is in path
  . "$HOME/.cargo/env"
  if ! command -v yazi >/dev/null 2>&1; then
    cargo install --locked --force yazi-build
  else
    echo "yazi already installed, skipping."
  fi
)

##
print_title "Install dotnet"
echo ""
(
  if ! command -v dotnet >/dev/null 2>&1; then
    cd /tmp || exit
    wget https://dot.net/v1/dotnet-install.sh
    sudo chmod +x dotnet-install.sh
    ./dotnet-install.sh --version latest
    rm /tmp/dotnet-install.sh
  else
    echo "dotnet already installed, skipping."
  fi
)

##
print_title "Install kitty and set as default terminal"
echo ""
(
  # Run as user to install in user home
  bash ./files/setup/kitty.sh
)

##
print_title "Install google-chrome"
echo ""
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/chrome.deb
sudo dpkg -i ~/chrome.deb
rm ~/chrome.deb

##
print_title "Install VS Code"
echo ""
sudo snap install code --classic

##
print_title "Install docker + docker-compose"
echo ""
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${VERSION_CODENAME:-$VERSION_CODENAME}") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

##
print_title "Install gnome templates"
echo ""
if [ ! -d "$HOME/Templates" ]; then
  cp ./files/Templates.tar.gz "$HOME/Templates.tar.gz"
  tar -xzvf "$HOME/Templates.tar.gz" -C "$HOME"
  rm "$HOME/Templates.tar.gz"
else
  echo "Templates directory already exists, skipping extraction."
fi

##
print_title "Install tmux plugin manager"
echo ""
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  # Install tmux plugin manager if not already present
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "tmux plugin manager already installed, skipping."
fi

##
print_title "Install ranger icons (keeping for legacy/other tools)"
echo ""
if [ ! -d "$HOME/.config/ranger/plugins/ranger_devicons" ]; then
  # Install ranger_devicons plugin for ranger if not already present
  git clone https://github.com/alexanderjeurissen/ranger_devicons "$HOME/.config/ranger/plugins/ranger_devicons"
else
  echo "ranger_devicons already installed, skipping."
fi

##
print_title "Install lazygit with go"
echo ""
export PATH=$PATH:/usr/local/go/bin
go install github.com/jesseduffield/lazygit@latest

##
print_title "Install delta"
echo ""
DELTA_VERSION="0.18.2"
wget "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
sudo dpkg -i "git-delta_${DELTA_VERSION}_amd64.deb"
rm "git-delta_${DELTA_VERSION}_amd64.deb"

print_title "Install zellij and aichat"
echo ""
(
  # Ensure cargo is in path
  . "$HOME/.cargo/env"
  pkgs=""
  if ! command -v zellij >/dev/null 2>&1; then
    pkgs="$pkgs zellij"
  else
    echo "zellij already installed, skipping."
  fi
  if ! command -v aichat >/dev/null 2>&1; then
    pkgs="$pkgs aichat"
  else
    echo "aichat already installed, skipping."
  fi

  if [ -n "$pkgs" ]; then
    # shellcheck disable=SC2086
    cargo install $pkgs
  fi
)

##
print_title "Install terraform"
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
print_title "Install flatpak packages"
echo ""
# Ensure flathub remote exists
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user install flathub com.redis.RedisInsight -y
flatpak --user install flathub com.getpostman.Postman -y
flatpak --user install flathub com.discordapp.Discord -y
flatpak --user install com.slack.Slack -y
flatpak --user install com.spotify.Client -y
flatpak --user install org.signal.Signal -y
#dbeaver + extras
flatpak --user install flathub io.dbeaver.DBeaverCommunity -y
flatpak --user install io.dbeaver.DBeaverCommunity.Client.pgsql -y
flatpak --user install io.dbeaver.DBeaverCommunity.Client.mariadb -y
flatpak --user install flathub com.github.tchx84.Flatseal -y

##
print_title "Set max file watchers"
echo ""
if ! grep -q 'fs.inotify.max_user_watches=524288' /etc/sysctl.conf; then
  echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
  sudo sysctl --system
else
  echo "fs.inotify.max_user_watches already set."
fi

##
print_title "Set cursor repeat rate (xset r rate 210 30) (add also to .profile)"
echo ""
xset r rate 210 30 # Consider adding to ~/.profile for persistence

##
print_title "Set neovim as default editor"
echo ""
# Note: Pointing to /usr/local/bin/nvim which is where the nightly script installs it
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 100

##
print_title "(copied to clipboard) run manually sudo chmod +x /usr/local/bin/docker-compose && sudo usermod -aG docker $USER && newgrp docker"
echo ""
echo "sudo usermod -aG docker \$USER && newgrp docker" | xclip -sel clip

##
print_title "Install Albert (Launcher)"
echo ""
echo "deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_24.04/ /" | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_24.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg >/dev/null
sudo apt update
sudo apt install -y albert

##
print_title "Install Logiops (Logitech Driver)"
echo ""
sudo apt-get install -y cmake pkg-config libevdev-dev libudev-dev libconfig++-dev libglib2.0-dev
if [ ! -d "/tmp/logiops" ]; then
  git clone https://github.com/PixlOne/logiops.git /tmp/logiops/
fi
(
  cd /tmp/logiops/ || exit
  mkdir -p build
  cd build
  cmake ..
  make
  sudo make install
  sudo systemctl enable --now logid
)

if [ -f "./files/logid.cfg" ]; then
  echo "Copying logid.cfg..."
  sudo cp ./files/logid.cfg /etc/logid.cfg
  sudo systemctl restart logid
fi
