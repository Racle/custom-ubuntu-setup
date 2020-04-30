bold=$(tput bold)
normal=$(tput sgr0)

##
sudo echo "${bold}Install zsh and powerline fonts${normal}"
echo ""
sudo apt-get install -y zsh
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
echo "${bold}Install oh-my-zsh and theme+plugins${normal}"
echo ""
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/junegunn/fzf.git ~/.oh-my-zsh/custom/plugins/fzf
~/.oh-my-zsh//custom/plugins/fzf/install --bin
git clone https://github.com/Treri/fzf-zsh.git ~/.oh-my-zsh/custom/plugins/fzf-zsh
git clone https://github.com/lukechilds/zsh-better-npm-completion ~/.oh-my-zsh/custom/plugins/zsh-better-npm-completion



##
echo ""
echo "${bold}Get custom setup${normal}"
echo ""
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/.zshrc -O ~/.zshrc
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/.p10k.zsh -O ~/.p10k.zsh
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/.docker_aliases -O ~/.docker_aliases

##
echo ""
echo "${bold}Symlink to root${normal}"
echo ""
sudo rm /root/.oh-my-zsh
sudo rm /root/.zshrc
sudo ln -s $HOME/.oh-my-zsh /root/
sudo ln -s $HOME/.zshrc /root/
sudo ln -s $HOME/.p10k.zsh /root/
sudo ln -s $HOME/.docker_aliases /root/

##
echo ""
echo "${bold}Set zsh as default shell${normal}"
echo ""
echo "run chsh -s $(which zsh) manually"
