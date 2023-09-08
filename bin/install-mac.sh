#!/usr/bin/env zsh
# ---
# dotfiles install (mac)
#
# Install and setup software for a Mac environment
#
# Please checkout readme.md for more information

__usage=$(<<EOF
Usage: install-mac (dotfiles!)
  -d  dry run (show run plan)
  -h  help

Example:
  ./install-mac.sh -d
EOF
)

# Vars
dry_run=0

# Requirements
brew_pkgs=(
    "awscli"
    "bat"
    "cowsay"
    "diff-so-fancy"
    "eza"
    "findutils"
    "fortune"
    "gnupg"
    "httpie"
    "jq"
    "lazygit"
    "lazygit"
    "lolcat"
    "lolcat"
    "neovim"
    "nginx"
    "nmap"
    "node"
    "pyenv"
    "pyenv-virtualenv"
    "python"
    "ripgrep"
    "tldr"
    "tmux"
    "trash"
    "tree"
    "tree"
    "wget"
    "yq"
)

# Options
while getopts "dh" opt; do
    case ${opt} in
        d ) dry_run=1 ;;
        h ) echo $__usage; exit 1 ;;
        \?) echo $__usage; exit 1 ;;
    esac
done

# Yeehaw
function yeehaw() {
    # Make dry run the default in case something
    # with variables above got weird.
    if [[ $dry_run -eq 0 ]]; then
        eval "${1}"
    else
        echo "DRY-RUN: ${1}"
    fi
}

# Change shell
# Manually:
#   *  chsh -s /bin/{bash,zsh}
#   *  System Preferences > Users & Groups > (you) > (right-click) > Advanced Options > Login shell > /bin/{bash, zsh}
#   * FIX YOUR TERMINAL, USE A NON-STANDARD SHELL:
#     * iTerm2 > Prefs > Profiles > (profile) > General > Command > "/usr/local/bin/zsh -i"
#     * https://apple.stackexchange.com/a/71930/74321
if [[ "${ZSH_VERSION:-UNDEF}" == "UNDEF" ]]; then
    if hash chsh >/dev/null 2>&1; then
        yeehaw "chsh -s /usr/local/bin/zsh"
        yeehaw "mkdir -p $HOME/.local/share/zsh"
    else
        echo "You wanna use ZSH, you need to install it."
    fi
fi

# Directories
yeehaw "mkdir -p ~/.local/share/zsh/"

# Requirements: Install
for pkg in "${brew_pkgs[@]}"; do
    yeehaw "brew install ${pkg}"
done

exit 1

# brew install ack composer coreutils findutils fzy mariadb neovim nginx node php python python@2 rbenv rename ripgrep ruby sqlite task the_silver_searcher tidy-html5 timewarrior tmux trash tree wget yarn

ln -s ~/.config/vscode/settings.json $HOME/Library/Application Support/Code/User/settings.json
cat ~/.config/vscode/extensions.txt | xargs -L 1 code --install-extension

python3 -m pip install --upgrade jedi
python3 -m pip install --upgrade neovim
#python3 -m pip install --upgrade pynvim

# pyenv
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
brew install jq yq multitail httpie

# gpg
brew install gnupg pinentry-mac

# PERSONAL HOST BITS
brew install youtube-dl ffmpeg
