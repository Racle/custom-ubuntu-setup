.DEFAULT_GOAL := help

## Show this help message
help:
	@echo "Usage: make <target>"
	@echo ""
	@awk '/^## /{desc=substr($$0,4); next} /^[a-z-]+:/{sub(/:.*/,""); printf "  %-20s %s\n", $$0, desc; desc=""}' $(MAKEFILE_LIST)

## Run full install (defaults, zsh, settings, so)
install: defaults zsh settings install-so

## Install default packages
defaults:
	bash ./install-defaults.sh

## Install and configure zsh
zsh:
	bash ./install-zsh.sh

## Apply system settings
settings:
	bash ./update-settings.sh

## Dump dconf/GNOME settings to files
dump-config:
	bash ./files/dconf/dconf-dump.sh

## Load dconf/GNOME settings from files
load-config:
	bash ./files/dconf/dconf-load.sh
