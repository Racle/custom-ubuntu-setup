#!/bin/sh
set -eu

bold=$(tput bold)
normal=$(tput sgr0)

echo ""
echo "${bold}Set ubuntu mirror to fi${normal}"
echo ""
# Ubuntu 24.04 uses ubuntu.sources
if [ -f /etc/apt/sources.list.d/ubuntu.sources ]; then
	sudo sed -i 's/us.archive/fi.archive/' /etc/apt/sources.list.d/ubuntu.sources
elif [ -f /etc/apt/sources.list ]; then
	# Fallback for older Ubuntu versions
	sudo sed -i 's/us.archive/fi.archive/' /etc/apt/sources.list
fi

echo ""
echo "${bold}Install nodejs 22 repo${normal}"
echo ""
curl -sL https://deb.nodesource.com/setup_22.x | sudo -E bash -

echo ""
echo "${bold}Install neovim repo${normal}"
echo ""
# This script updates Neovim to the latest nightly AppImage version and extracts it.
(
	sudo sh ./files/setup/nvim.sh
)

echo ""
echo "${bold}Enable gnome tweak tool repo${normal}"
echo ""
sudo add-apt-repository universe -y

##
echo ""
echo "${bold}Install defaults${normal}"

echo ""
sudo apt-get install -y zsh \
	git \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
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
	zoxide

##
echo ""
echo "${bold}Install go${normal}"
echo ""
(
	sudo sh ./files/setup/go.sh
)

##
echo ""
echo "${bold}Install rust & cargo${normal}"
echo ""
curl https://sh.rustup.rs -sSf | sh -s -- -y

##
echo ""
echo "${bold}Install yazi (file manager)${normal}"
echo ""
(
	# Ensure cargo is in path
	. "$HOME/.cargo/env"
	cargo install --locked yazi-fm yazi-cli
)

##
echo ""
echo "${bold}Install dotnet${normal}"
echo ""
(
	cd /tmp || exit
	wget https://dot.net/v1/dotnet-install.sh
	sudo chmod +x dotnet-install.sh
	./dotnet-install.sh --version latest
	rm /tmp/dotnet-install.sh
)

##
echo ""
echo "${bold}Install kitty and set as default terminal${normal}"
echo ""
(
	# Run as user to install in user home
	sh ./files/setup/kitty.sh
)

##
echo ""
echo "${bold}Install google-chrome${normal}"
echo ""
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/chrome.deb
sudo dpkg -i ~/chrome.deb
rm ~/chrome.deb

##
echo ""
echo "${bold}Install VS Code${normal}"
echo ""
sudo snap install code --classic

##
echo ""
echo "${bold}Install docker + docker-compose${normal}"
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
echo ""
echo "${bold}Install gnome templates${normal}"
echo ""
if [ ! -d "$HOME/Templates" ]; then
	cp ./files/Templates.tar.gz "$HOME/Templates.tar.gz"
	tar -xzvf "$HOME/Templates.tar.gz" -C "$HOME"
	rm "$HOME/Templates.tar.gz"
else
	echo "Templates directory already exists, skipping extraction."
fi

##
echo ""
echo "${bold}Install tmux plugin manager${normal}"
echo ""
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	# Install tmux plugin manager if not already present
	git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
	echo "tmux plugin manager already installed, skipping."
fi

##
echo ""
echo "${bold}Install ranger icons (keeping for legacy/other tools)${normal}"
echo ""
if [ ! -d "$HOME/.config/ranger/plugins/ranger_devicons" ]; then
	# Install ranger_devicons plugin for ranger if not already present
	git clone https://github.com/alexanderjeurissen/ranger_devicons "$HOME/.config/ranger/plugins/ranger_devicons"
else
	echo "ranger_devicons already installed, skipping."
fi

##
echo ""
echo "${bold}Install lazygit with go${normal}"
echo ""
go install github.com/jesseduffield/lazygit@latest

##
echo ""
echo "${bold}Install delta${normal}"
echo ""
DELTA_VERSION="0.18.2"
wget "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
sudo dpkg -i "git-delta_${DELTA_VERSION}_amd64.deb"
rm "git-delta_${DELTA_VERSION}_amd64.deb"

echo ""
echo "${bold}Install zellij and aichat${normal}"
echo ""
cargo install zellij aichat

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
echo ""
echo "${bold}Set max file watchers${normal}"
echo ""
if ! grep -q 'fs.inotify.max_user_watches=524288' /etc/sysctl.conf; then
	echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
	sudo sysctl --system
else
	echo "fs.inotify.max_user_watches already set."
fi

##
echo ""
echo "${bold}Set cursor repeat rate (xset r rate 210 30) (add also to .profile)${normal}"
echo ""
xset r rate 210 30 # Consider adding to ~/.profile for persistence

##
echo ""
echo "${bold}Set neovim as default editor${normal}"
echo ""
# Note: Pointing to /usr/local/bin/nvim which is where the nightly script installs it
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 100

##
echo ""
echo "${bold}(copied to clipboard) run manually sudo chmod +x /usr/local/bin/docker-compose && sudo usermod -aG docker $USER && newgrp docker${normal}"
echo ""
echo "sudo usermod -aG docker \$USER && newgrp docker" | xclip -sel clip
