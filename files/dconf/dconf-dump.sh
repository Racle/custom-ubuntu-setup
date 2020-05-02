#!/bin/sh
BASEDIR=$(dirname "$0")
cd "$BASEDIR"

dconf dump /org/gnome/desktop/wm/keybindings/ > keybindings.dconf
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > custom-keybindings.dconf
dconf dump /org/gnome/terminal/legacy/profiles:/ > terminal-profiles.dconf
dconf dump /com/gexperts/Tilix/ > tilix.dconf
dconf dump /org/gnome/shell/extensions/ > extensions.dconf
dconf dump /org/gnome/desktop/wm/preferences/ > preferences.dconf

sed -i "s/ssh .*$/ssh SSH_URL'/" custom-keybindings.dconf
