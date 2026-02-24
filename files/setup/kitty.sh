#!/bin/bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
# your PATH)
mkdir -p ~/.local/bin/
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/

# Place the kitty.desktop file somewhere it can be found by the OS
mkdir -p ~/.local/share/applications
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/

# Update the path to the kitty icon in the kitty.desktop file
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
# Update the Exec path to be absolute to ensure it launches correctly from the menu
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/bin/kitty|g" ~/.local/share/applications/kitty.desktop

# Update desktop database to ensure the app appears in the menu
if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database ~/.local/share/applications
fi

# Set kitty as default terminal
# Use absolute path to user's kitty binary to ensure sudo finds it
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /home/$USER/.local/bin/kitty 50
sudo update-alternatives --set x-terminal-emulator /home/$USER/.local/bin/kitty

# install kitty-terminfo package
sudo apt install -y kitty-terminfo
