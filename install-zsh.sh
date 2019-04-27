bold=$(tput bold)
normal=$(tput sgr0)

##
echo "${bold}Install zsh and powerline fonts${normal}"
echo ""
# sudo apt-get install zsh fonts-powerline
# just to be sure and getting latest fonts, git clone
cd /tmp/
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

##
echo ""
echo "${bold}Install oh-my-zsh and theme+plugin${normal}"
echo ""
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# no need for custom folder git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions

##
echo ""
echo "${bold}Get custom setup${normal}"
echo ""
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/.zshrc -O ~/.zshrc

##
echo ""
echo "${bold}Symlink to root${normal}"
echo ""
sudo rm /root/.oh-my-zsh
sudo rm /root/.zshrc
sudo ln -s $HOME/.oh-my-zsh /root/
sudo ln -s $HOME/.zshrc /root/

##
echo ""
echo "${bold}Set zsh as default shell${normal}"
echo ""
chsh -s $(which zsh)
