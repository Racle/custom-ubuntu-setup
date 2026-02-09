#!/bin/bash
cd /tmp || exit
rm -rf go*.tar.gz
LATEST_GO_VERSION="$(curl --silent "https://go.dev/VERSION?m=text" | head -n 1)"
LATEST_GO_DOWNLOAD_URL="https://go.dev/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz"
wget "$LATEST_GO_DOWNLOAD_URL"
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go*.tar.gz
rm -rf go*.tar.gz
# Ensure /usr/local/go/bin is in PATH
if ! grep -q '/usr/local/go/bin' "$HOME/.profile"; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >>"$HOME/.profile"
  echo "Added /usr/local/go/bin to PATH in ~/.profile"
fi
