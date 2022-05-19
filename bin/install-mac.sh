#!/bin/bash
# ---
# dotfiles install (mac)
#
# Install and setup software for a Mac environment

# NOTE: DO NOT RUN THIS FILE
# NOTE: DO NOT RUN THIS FILE
# NOTE: DO NOT RUN THIS FILE
# NOTE: DO NOT RUN THIS FILE
# NOTE: DO NOT RUN THIS FILE
# NOTE: DO NOT RUN THIS FILE
# NOTE: ...it's more a log of stuff at this point and should
# NOTE: ...not be run, but rather copied/pasted from until it
# NTOE: ...is vetted and cleaned up.

HOMEDIR=$HOME
BACKUPDIR="$HOMEDIR/.dotfiles.backups"
CURRENTDIR=$(pwd -P)
DOTFILEDIR="$CURRENTDIR/dotfiles"

mkdir -p ~/.local/share/zsh/

# homebrew
# python/pip
# ruby/gems

brew install node

# brew install ack composer coreutils findutils fzy mariadb neovim nginx node php python python@2 rbenv rename ripgrep ruby sqlite task the_silver_searcher tidy-html5 timewarrior tmux trash tree wget yarn

ln -s ~/.config/vscode/settings.json $HOME/Library/Application Support/Code/User/settings.json
cat ~/.config/vscode/extensions.txt | xargs -L 1 code --install-extension

# Change shell
# Manually:
#   *  chsh -s /bin/{bash,zsh}
#   *  System Preferences > Users & Groups > (you) > (right-click) > Advanced Options > Login shell > /bin/{bash, zsh}
#   * FIX YOUR TERMINAL, USE A NON-STANDARD SHELL:
#     * iTerm2 > Prefs > Profiles > (profile) > General > Command > "/usr/local/bin/zsh -i"
#     * https://apple.stackexchange.com/a/71930/74321
if hash chsh >/dev/null 2>&1; then
  chsh -s /usr/local/bin/zsh
  mkdir -p $HOME/.local/share/zsh
else
  echo "You wanna use ZSH, you need to install it."
fi

python3 -m pip install --upgrade jedi

brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install diff-so-fancy

python3 -m pip install --upgrade neovim
#python3 -m pip install --upgrade pynvim

brew install neovim
brew install exa
brew install trash
brew install bat
brew install tree
brew install findutils

# vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# pyenv
brew install pyenv pyenv-virtualenv
# install versions from system defaults
#   * python --version
#   * python3 --version
pyenv install 3.9.7
pyenv install 2.7.16

# Common packages
pip_common="black cookiecutter flake8 jedi ipython mypy numpy"

# setup shell environments
pyenv virtualenv 3.9.7 shell3
pyenv activate shell3
pip install -U "$(pip_common)"

pyenv virtualenv 2.7.16 shell2
pyenv activate shell2
pip install -U "$(pip_common)"

# setup vim environments
pyenv virtualenv 3.9.7 neovim3
pyenv activate neovim3
pip install -U "$(pip_common)"
pip install -U neovim

pyenv virtualenv 2.7.16 neovim2
pyenv activate neovim2
pip install -U "$(pip_common)"
pip install -U pynvim

# For VIM stuff, install ALE and then ":ALEInfo"

# sure
brew install cowsay lolcat fortune

# helpers
brew install jq yq multitail
