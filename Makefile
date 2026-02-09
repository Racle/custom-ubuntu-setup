install: defaults zsh settings install-so
defaults:
	bash ./install-defaults.sh
zsh:
	bash ./install-zsh.sh
settings:
	bash ./update-settings.sh
install-so:
	curl --proto '=https' --tlsv1.2 -sSf https://samtay.github.io/so/install.sh \
  | bash -s -- --to ~/scripts/ --force
