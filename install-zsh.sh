bold=$(tput bold)
normal=$(tput sgr0)

##
sudo echo "${bold}Install zsh and patched nerd fonts${normal}"
echo ""
sudo apt-get install -y zsh
# just to be sure and getting latest fonts, git clone
cd /tmp/
# clone
git clone https://github.com/ryanoasis/nerd-fonts.git --depth=1
# install
cd nerd-fonts
./install.sh Hack
./install.sh FiraCode
./install.sh FiraMono
./install.sh Ubuntu
./install.sh UbuntuMono
./install.sh JetBrainsMono
./install.sh RobotoMono
# clean-up a bit
cd ..
rm -rf nerd-fonts

##
echo ""
echo "${bold}Install oh-my-zsh and theme+plugins${normal}"
echo ""
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/junegunn/fzf.git ~/.oh-my-zsh/custom/plugins/fzf
~/.oh-my-zsh//custom/plugins/fzf/install --bin
git clone https://github.com/Treri/fzf-zsh.git ~/.oh-my-zsh/custom/plugins/fzf-zsh
git clone https://github.com/lukechilds/zsh-better-npm-completion ~/.oh-my-zsh/custom/plugins/zsh-better-npm-completion
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ~/.oh-my-zsh/custom/plugins/autoupdate
git clone https://github.com/macunha1/zsh-terraform ~/.oh-my-zsh/custom/plugins/terraform

##
echo ""
echo "${bold}Set zsh as default shell${normal}"
echo ""
chsh -s $(which zsh)
sudo su -s /bin/bash -c 'chsh -s $(which zsh)' root
