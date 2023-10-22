#
# Mac OS X
##

# Host name change? Want to (re) set it?
# > sudo scutil --set HostName <somehostname>

# Commands
alias cat="bat"
alias idea="open -na 'IntelliJ IDEA.app'"
alias ldocker="lazydocker"
alias lgit="lazygit"
alias ls="eza"
#if command -v gls >/dev/null; then alias ls='gls --color=auto'; fi
if command -v gxargs >/dev/null; then alias xargs='gxargs'; fi

# Git xargs fix
#git config  --global alias.bc "!bc() { git branch --no-color --merged | egrep -v \"(^\\*|master|dev)\" | gxargs -r git branch -d; }; bc"

# Homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
if command -v brew >/dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion.d ]; then
        . $(brew --pefix)/etc/bash_completion.d
    fi
fi

# RBENV (again; see shell/base.sh)
#if command -v rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Starship
#eval "$(starship init zsh)"

function nvminit() {
    export NVM_DIR="$HOME/.config/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
}

function homebrew_search_local_only() {
    # Homebrew searches GitHub if it has a valid API (token)
    # and if you're reasonably up-to-date locally, why? It's
    # why searches feel "slow".
    #
    # Source at:
    # https://github.com/Homebrew/brew/blob/master/Library/Homebrew/search.rb#L39
    #
    # Speed things up by temporarily removing API access and
    # searching local only.

    previous_token="${HOMEBREW_GITHUB_API_TOKEN:-}"

    unset HOMEBREW_GITHUB_API_TOKEN
    brew search "$@"
    export HOMEBREW_GITHUB_API_TOKEN=${previous_token}
}

# List (suspicious?) extensions, daemons etc.
function mac_suspicious() {

    echo "Kernel extensions:"
    kextstat -k -l | grep -v com.apple | while read -r line; do
        k_id=$(echo $line | awk '{print $6}')
        k_address=$(echo $line | awk '{print $3}')
        echo $k_id@$k_address
        kextutil -a $k_id@$k_address
    done
    echo "==="

    echo "Daemons"
    launchctl list | grep -v com.apple | grep -v Label | while read -r line; do
        d_id=$(echo $line | awk '{print $3}')
        echo $d_id
    done
    echo "==="

    echo "(TODO) Check these paths for *.kext, *plist, etc.:"
    echo "  /Library/Extensions/"
    echo "  /Library/LaunchAgents"
    echo "  /Library/LaunchDaemons"
    echo "  /System/Library/Extensions/"
    echo "  ~/Library/ApplicationSupport/LaunchAgents"
    echo "  ~/Library/ApplicationSupport/LaunchDaemons"
    echo "  ~/Library/LaunchAgents/"
    echo "  ~/Library/LaunchDaemons/"

}

# Update dev stuff
function update_dev_stuff() {
    cmds=(
        "brew update"
        "brew upgrade"
        "brew cleanup --prune 0"
        "brew doctor"
        "gem update"
        "npm update --location=global"
        "rustup update"
    )

    update_confirm_prompt="That cool? [Y/n] "
    update_confirm_timeout=10

    echo "Going to update Homebrew, Node, Ruby Gems, Pip and their friends:"
    for cmd in "${cmds[@]}"; do
        echo -e "\t${cmd}"
    done

    echo
    if [[ -n ${ZSH_VERSION-} ]]; then
        # Zsh: -r: safe backslashes, -k: return after X chars, -t: timeout
        read -r -k 1 -t $update_confirm_timeout "?$update_confirm_prompt"
    else
        # Bash: -r: safe backslashes, -k: return after X chars, -t: timeout, -p: prompt
        read -r -n 1 -t $update_confirm_timeout -p "$update_confirm_prompt"
    fi
    echo

    # $REPLY comes from the read command a few lines up, when you don't supply a name
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "Okay, nevermind. I was, uh, just kidding anyways."
    else
        # See ~/Edification/bash/arrays.sh for more
        for cmd in "${cmds[@]}"; do
            echo -e "\n==> ${cmd}"
            eval $cmd
            echo "---"
        done
        echo
    fi
}
