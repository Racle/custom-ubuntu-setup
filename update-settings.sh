bold=$(tput bold)
normal=$(tput sgr0)

##
sudo echo "${bold}Update settigns/keybindings${normal}"
echo ""

##
echo ""
echo "${bold}Set keybinds${normal}"
echo ""
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/dconf/keybindings.dconf -O ~/keybindings.dconf
dconf load /org/gnome/desktop/wm/keybindings/ < ~/keybindings.dconf
rm ~/keybindings.dconf

wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/dconf/custom-keybindings.dconf -O ~/custom-keybindings.dconf
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/custom-keybindings.dconf
rm ~/custom-keybindings.dconf

wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/dconf/pop_shell.dconf -O ~/pop_shell.dconf
dconf load /org/gnome/shell/extensions/pop-shell/ < ~/pop_shell.dconf
rm ~/pop_shell.dconf

##
echo ""
echo "${bold}Set terminal profiles${normal}"
echo ""
echo "${bold}Set SSH user@url: ${normal}"
read ssh_url
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/dconf/terminal-profiles.dconf -O ~/terminal-profiles.dconf
sed -ri "s/SSH_URL/$ssh_url/" ~/custom-keybindings.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < ~/terminal-profiles.dconf
rm ~/terminal-profiles.dconf

##
echo ""
echo "${bold}Set menu key to super key${normal}"
sudo sed -i 's/Menu/Super_R/' /usr/share/X11/xkb/symbols/pc
echo ""

##
echo ""
echo "${bold}Setup tilix as default and get default config${normal}"
echo ""
sudo update-alternatives --config x-terminal-emulator
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/dconf/tilix.dconf -O ~/tilix.dconf
dconf load /com/gexperts/Tilix/ < ~/tilix.dconf
rm ~/tilix.dconf

##
echo ""
echo "${bold}Get phpstorm default watchers${normal}"
echo ""
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/watchers.xml -O ~/watchers.xml

##
echo ""
echo "${bold}Install PulseEffects and Racle preset${normal}"
echo ""
sudo add-apt-repository ppa:mikhailnov/pulseeffects -y
sudo apt-get install -y pulseeffects pulseaudio --install-recommends
mkdir -p ~/.config/pulse/presets
wget wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/PulseEffectsRacle.preset -O ~/.config/pulse/presets/Racle.preset

##
echo ""
echo "${bold}Install albert config${normal}"
echo ""
mkdir -p ~/.local/share/albert/org.albert.extension.python/modules/
mkdir -p ~/.config/albert
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/window_switcher_plus.py -O ~/.local/share/albert/org.albert.extension.python/modules/window_switcher_plus.py
wget https://raw.githubusercontent.com/Racle/custom-ubuntu-setup/master/files/albert.conf -O ~/.config/albert/albert.conf
