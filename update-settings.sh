#!/bin/bash
set -eu

# Colors and styles
BOLD=$(tput bold)
RESET=$(tput sgr0)
BLUE=$(tput setaf 4)
GREEN=$(tput setaf 2)

print_title() {
  echo ""
  echo "${BLUE}==>${RESET} ${BOLD}${GREEN}$1${RESET}"
  echo ""
}

##
print_title "Update settings/keybindings"
bash ./files/dconf/dconf-load.sh

##
print_title "Install custom dotfiles"
if [ ! -d "$HOME/.dotfiles" ]; then
  git clone https://github.com/Racle/dotfiles.git ~/.dotfiles
  cd ~/.dotfiles || exit 1
  make link-root
  make stow
else
  echo "Dotfiles already installed."
fi
