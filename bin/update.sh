#!/bin/bash
# ---
# dotfiles update
#
# Update

CURRENTDIR=$(pwd -P)
HOMEDIR=$HOME

BACKUPDIR="$HOMEDIR/.dotfiles.backups"
DOTFILEDIR="$CURRENTDIR/dotfiles"

if [[ $SUDO_USER ]]; then
    echo "Running scripts you find on the internet as root is dangerous. Try again without 'sudo'."
    exit 1
fi

echo ""
echo "Updating repo and submodules..."
git pull
git submodule update --init --remote --merge

#echo ""
#echo "Upgrading Neovim plugins and packages..."
#nvim --headless "+Lazy! update" +qa
#nvim --headless "+MasonUpdate" +qa
#echo ""

echo ""
echo "Upgrading Tmux plugins..."
"$XDG_CONFIG_HOME/tmux/plugins/tpm/bin/install_plugins"
"$XDG_CONFIG_HOME/tmux/plugins/tpm/bin/update_plugins" all
"$XDG_CONFIG_HOME/tmux/plugins/tpm/bin/clean_plugins"
