#!/bin/bash
# ---
# dotfiles install (local)
#
# Install and setup software for a local (unprivileged) environment


# Tmux (example; update version as needed)
wget https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz
mkdir tmux-2.8
tar -xzvf tmux-2.8.tar.gz -C tmux-2.8
cd tmux-2.8/tmux-2.8
./configure --prefix=$HOME/.local
make
make install

# NeoVim
cd ~/.local/bin
wget https://github.com/neovim/neovim/releases/download/v0.3.4/nvim.appimage
ln -s nvim.appimage nvim

## PEAR (lol, this guy...)
## download go-pear.phar from https://github.com/pear/pearweb_phars
#php go-pear.phar
## change config options to ~/.local/share/pear and ~/.config/pear/pearrc
#pear config-set ext_dir ~/.local/share/php/extensions/
#
## PHP 7.x
#sudo add-apt-repository ppa:ondrej/php
#sudo apt-get install php7.x-whatever
