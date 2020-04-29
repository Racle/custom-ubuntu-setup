#!/bin/sh
echo "${bold}Set SSH user@url: ${normal}"
read ssh_url
sed -ri "s/SSH_URL/$ssh_url/" custom-keybindings.dconf

dconf load /org/gnome/desktop/wm/keybindings/ < keybindings.dconf
dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ < custom-keybindings.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < terminal-profiles.dconf
dconf load /com/gexperts/Tilix/ < tilix.dconf
dconf load /org/gnome/shell/extensions/pop-shell/ < pop_shell.dconf

sed -i "s/ssh .*$/ssh SSH_URL'/" custom-keybindings.dconf