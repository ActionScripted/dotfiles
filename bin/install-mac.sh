#!/usr/bin/env zsh
# ---
# dotfiles install (mac)
#
# Install and setup software for a Mac environment
#
# Please checkout readme.md for more information

__usage=$(<<EOF
Usage: install-mac (dotfiles!)
  -c  confirm (dry run by default)
  -h  help

Example:
  ./install-mac.sh -c
EOF
)

# Vars
dry_run=1

# Requirements
brew_pkgs=(
    "awscli"
    "bat"
    "coreutils"
    "cowsay"
    "diff-so-fancy"
    "eza"
    "findutils"
    "font-fira-code"
    "font-fira-code-nerd-font"
    "fortune"
    "fzy"
    "git"
    "gnupg"
    "httpie"
    "jq"
    "lazygit"
    "lolcat"
    "multitail"
    "neovim"
    "nginx"
    "nmap"
    "node"
    "pyenv"
    "pyenv-virtualenv"
    "python"
    "rename"
    "ripgrep"
    "tldr"
    "tmux"
    "trash"
    "tree"
    "wget"
    "yarn"
    "yq"
)

# Options
while getopts "ch-:" opt; do
    case ${opt} in
        c ) dry_run=0 ;;
        h ) echo $__usage; exit 1 ;;
        - )
            case "${OPTARG}" in
                commit )
                    dry_run=0
                    ;;
                * )
                    echo "Invalid option: --${OPTARG}"
                    echo "$__usage"
                    exit 1
                    ;;
            esac
            ;;
        \? ) echo $__usage; exit 1 ;;
    esac
done

# Yeehaw (send it)
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
#   * chsh -s /bin/{bash,zsh}
#   * System Preferences > Users & Groups > (you) > (right-click) > Advanced Options > Login shell > /bin/{bash, zsh}
#   * FIX YOUR TERMINAL, USE A NON-STANDARD SHELL:
#     * iTerm2 > Prefs > Profiles > (profile) > General > Command > "/usr/local/bin/zsh -i"
#     * https://apple.stackexchange.com/a/71930/74321
if [[ "${ZSH_VERSION:-UNDEF}" == "UNDEF" ]]; then
    if hash chsh >/dev/null 2>&1; then
        yeehaw "chsh -s /usr/local/bin/zsh"
    else
        echo "You wanna use ZSH, you need to install it."
    fi
fi

# Directories
yeehaw "mkdir -p ~/.local/share/zsh/"

# Requirements: Setup
yeehaw "brew tap earthly/earthly"
yeehaw "brew tap github/gh"
yeehaw "brew tap hashicorp/tap"
yeehaw "brew tap homebrew/cask-fonts"
yeehaw "brew tap oven-sh/bun"

# Requirements: Install
for pkg in "${brew_pkgs[@]}"; do
    yeehaw "brew install ${pkg}"
done

# Python: Environment
python_version=$(python --version 2>&1 | awk '{print $2}')
yeehaw "pyenv install ${python_version}"
yeehaw "pyenv global ${python_version}"

# Python: Packages
yeehaw "pip install --upgrade pip"
yeehaw "pip install --upgrade cookiecutter ipython numpy pandas"

# VS Code: Setup
vscode_target="$HOME/Library/Application Support/Code/User/settings.json"
if [ -e "$vscode_target" ]; then
    yeehaw "rm $vscode_target"
fi
yeehaw "ln -s ~/.config/vscode/settings.json $vscode_target"
yeehaw "cat ~/.config/vscode/extensions.txt | xargs -L 1 code --install-extension"

exit 0
