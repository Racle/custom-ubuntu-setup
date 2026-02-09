set -e
bold=$(tput bold)
normal=$(tput sgr0)

##
echo "${bold}Install zsh and patched nerd fonts${normal}"
echo ""
if ! command -v zsh >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y zsh
else
  echo "zsh is already installed. Skipping."
fi

# Install Nerd Fonts from latest release tar.xz files if not already present
FONT_BASE="$HOME/.local/share/fonts/NerdFonts"
mkdir -p "$FONT_BASE"
LATEST_VERSION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep tag_name | head -n1 | cut -d '"' -f4)
for FONT in Hack FiraCode FiraMono Ubuntu UbuntuMono JetBrainsMono RobotoMono; do
  DEST="$FONT_BASE/$FONT"
  if [ -d "$DEST" ] && [ "$(ls -A "$DEST" 2>/dev/null)" ]; then
    echo "$FONT Nerd Font already installed. Skipping."
  else
    URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${LATEST_VERSION}/${FONT}.tar.xz"
    echo "Downloading $FONT Nerd Font from $URL ..."
    mkdir -p "$DEST"
    CURDIR=$(pwd)
    cd /tmp
    curl -fLO "$URL"
    if [ -f "${FONT}.tar.xz" ]; then
      tar -xf "${FONT}.tar.xz" -C "$DEST"
      rm -f "${FONT}.tar.xz"
      echo "$FONT Nerd Font installed."
    else
      echo "Failed to download $FONT Nerd Font."
    fi
    cd "$CURDIR"
    # Refresh font cache after each font (safe for idempotency)
    fc-cache -fv "$DEST"
  fi
done

# Install Roboto Slab from Google Fonts if not already present
mkdir -p ~/.local/share/fonts && wget -O ~/.local/share/fonts/RobotoSlab.ttf "https://github.com/google/fonts/raw/main/apache/robotoslab/RobotoSlab%5Bwght%5D.ttf" && fc-cache -fv

##
echo ""
echo "${bold}Install oh-my-zsh and theme+plugins${normal}"
echo ""
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed. Skipping."
fi

# Powerlevel10k theme
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
else
  echo "Powerlevel10k already installed. Skipping."
fi

# Plugins
PLUGINS=(
  "zsh-users/zsh-autosuggestions:$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
  "zsh-users/zsh-syntax-highlighting:$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
  "junegunn/fzf:$HOME/.oh-my-zsh/custom/plugins/fzf"
  "Treri/fzf-zsh:$HOME/.oh-my-zsh/custom/plugins/fzf-zsh"
  "lukechilds/zsh-better-npm-completion:$HOME/.oh-my-zsh/custom/plugins/zsh-better-npm-completion"
  "TamCore/autoupdate-oh-my-zsh-plugins:$HOME/.oh-my-zsh/custom/plugins/autoupdate"
  "macunha1/zsh-terraform:$HOME/.oh-my-zsh/custom/plugins/terraform"
)
for entry in "${PLUGINS[@]}"; do
  REPO="${entry%%:*}"
  DIR="${entry##*:}"
  if [ ! -d "$DIR" ]; then
    git clone "https://github.com/$REPO.git" "$DIR"
  else
    echo "$REPO already installed. Skipping."
  fi
  # Special install for fzf
  if [[ "$REPO" == "junegunn/fzf" ]]; then
    "$DIR/install" --bin
  fi

done

##
echo ""
echo "${bold}Set zsh as default shell${normal}"
echo ""
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "zsh" ]; then
  chsh -s "$(which zsh)"
  sudo su -s /bin/bash -c 'chsh -s $(which zsh)' root
  echo "Default shell changed to zsh."
else
  echo "zsh is already the default shell. Skipping."
fi
