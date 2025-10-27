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
echo "${bold}Install custom dotfiles${normal}"
echo ""
git clone https://github.com/Racle/dotfiles.git ~/.dotfiles
cd ~/.dotfiles || exit 1
make stow
make link-root
