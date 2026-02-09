#!/bin/bash
url=$(curl -s https://api.github.com/repos/neovim/neovim/releases/tags/nightly |
  grep "browser_download_url" |
  grep "nvim-linux-x86_64.appimage" |
  grep -v "zsync" |
  cut -d '"' -f 4)

# if url is empty, ask user to input it manually
if [ -z "$url" ]; then
  echo "Could not find the Neovim AppImage download URL automatically."
  echo "Please visit the Neovim releases page to find the latest AppImage."
  echo "You can find the latest Neovim AppImage at: https://github.com/neovim/neovim/releases/"
  xdg-open "https://github.com/neovim/neovim/releases/" >/dev/null 2>&1
  read -p -r "Enter the Neovim AppImage download URL: " url
fi

basedir="/tmp/nvim_$(date +%s)"
mkdir -p "$basedir" || {
  echo "Failed to create directory $basedir"
  exit 1
}
cd "$basedir" || {
  echo "Failed to change directory to $basedir"
  exit 1
}

wget "$url" -O nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
cd squashfs-root/usr || {
  echo "Failed to change directory to squashfs-root/usr"
  exit 1
}
sudo cp -r bin/* /usr/local/bin/ || echo "Failed to copy binaries to /usr/local/bin/"
sudo cp -r share/* /usr/local/share/ || echo "Failed to copy share files to /usr/local/share/"
sudo cp -r lib/* /usr/local/lib/ || echo "Failed to copy lib files to /usr/local/lib/"
rm -rf "$basedir"
version=$(/usr/local/bin/nvim -v | head -1)
echo "Neovim ($version) has been updated and installed to /usr/bin/nvim"
