bold=$(tput bold)
normal=$(tput sgr0)

##
sudo echo "${bold}Update settigns/keybindings${normal}"
echo ""

sh ./files/dconf/dconf-load.sh

##
echo ""
echo "${bold}Setup tilix as default${normal}"
echo ""
sudo update-alternatives --config x-terminal-emulator


##
echo ""
echo "${bold}Install PulseEffects${normal}"
echo ""
sudo add-apt-repository ppa:mikhailnov/pulseeffects -y
sudo apt-get install -y pulseeffects pulseaudio --install-recommends

##
echo ""
echo "${bold}Install custom dotfiles${normal}"
echo ""
git clone https://github.com/Racle/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
rm ~/.zshrc ~/.p10k.zsh ~/.docker_aliases ~/.config/albert/albert.conf ~/.watchers.xml 
stow default zsh albert phpstorm

sudo rm /root/.oh-my-zsh /root/.zshrc /root/.p10k.zsh /root/.docker_aliases
sudo ln -s $HOME/.oh-my-zsh /root/
sudo ln -s $HOME/.zshrc /root/
sudo ln -s $HOME/.p10k.zsh /root/
sudo ln -s $HOME/.docker_aliases /root/