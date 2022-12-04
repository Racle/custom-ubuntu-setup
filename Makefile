install: defaults zsh settings install-so
defaults:
	sh ./install-defaults.sh
zsh:
	sh ./install-zsh.sh
settings:
	sh ./update-settings.sh
install-so:
	curl --proto '=https' --tlsv1.2 -sSf https://samtay.github.io/so/install.sh \
  | bash -s -- --to ~/scripts/ --force
