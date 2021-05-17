#!/bin/sh
BASEDIR=$(dirname "$0")
cd "$BASEDIR"

echo "${bold}Set SSH user@url: ${normal}"
read ssh_url
sed -ri "s/SSH_URL/$ssh_url/" custom-keybindings.dconf

mkdir -p ~/Pictures/Screenshots

dconf load /org/gnome/desktop/wm/keybindings/ < keybindings.dconf
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < custom-keybindings.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < terminal-profiles.dconf
dconf load /com/gexperts/Tilix/ < tilix.dconf
dconf load /org/gnome/shell/extensions/ < extensions.dconf
dconf load /org/gnome/desktop/wm/preferences/ < preferences.dconf
dconf load /org/gnome/desktop/peripherals/keyboard/ < keyboard.dconf
dconf load /org/gnome/meld/ < meld.dconf

sed -i "s/ssh .*$/ssh SSH_URL'/" custom-keybindings.dconf
