# Custom-~~ubuntu~~pop_os-setup

## Dotfiles
<https://github.com/Racle/dotfiles>

## Installation

```
git clone https://github.com/Racle/custom-ubuntu-setup.git
cd custom-ubuntu-setup
```

## Install all
```
make install
```

## Install seperately
### install defaults + few configs + gnome templates
```
make defaults
```

### install zhs 
```
make zsh
```

### update keybindings + config + dotfiles
```
make update
```
### install vimconfig 
<https://github.com/Racle/vimfiles>
```
wget https://raw.githubusercontent.com/Racle/vimfiles/master/.vimrc -O ~/.vimrc
```
### Gnome extensions

#### Copy from old machine
`~/./local/share/gnome-shell/extensions/`

#### tips
<https://github.com/utkuufuk/ubuntu-on-steroids/blob/master/README.md>