##
echo install zsh
sudo apt-get install zsh

##
echo install oh-my-zsh and theme+plugin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions

##
echo get custom setup
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/.zshrc -O ~/.zshrc

##
echo symlink to root
sudo rm /root/.oh-my-zsh
sudo rm /root/.zshrc
sudo ln -s $HOME/.oh-my-zsh /root/
sudo ln -s $HOME/.zshrc /root/

##
echo set zsh as default shell
chsh -s $(which zsh)
