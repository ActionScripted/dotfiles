#
# Mac OS X
##

# Host name change? Want to (re) set it?
# > sudo scutil --set HostName <somehostname>

export _ZO_DATA_DIR=$XDG_DATA_HOME

# Commands
alias cat="bat"
alias f="fzf --preview 'bat --color=always --style=header,grid --line-range :500 {}' --bind 'enter:become(nvim {+})'"
alias idea="open -na 'IntelliJ IDEA.app'"
alias ldocker="lazydocker"
alias lgit="lazygit"
alias ls="eza"

# Docker / Compose
export COMPOSE_BAKE=true

# Git xargs fix
#git config  --global alias.bc "!bc() { git branch --no-color --merged | egrep -v \"(^\\*|master|dev)\" | gxargs -r git branch -d; }; bc"

# Homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
if command -v brew >/dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion.d ]; then
        . $(brew --pefix)/etc/bash_completion.d
    fi
fi

# Zoxide
# if command -v zoxide >/dev/null; then
#     eval "$(zoxide init zsh --cmd z)"
# fi

# RBENV (again; see shell/base.sh)
#if command -v rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Starship
#eval "$(starship init zsh)"

# ssh-agent: start and add keys
ssh_agent_start() {
    local host=$(hostname)
    local ssh_env_file="$HOME/.ssh/agent_env_${host}"

    # Check if the SSH agent environment file exists and source it
    if [ -f "$ssh_env_file" ]; then
        source "$ssh_env_file" >/dev/null
    fi

    # Check if the agent is running by looking for its socket
    if [ ! -S "$SSH_AUTH_SOCK" ]; then
        # Start a new agent and save the environment info
        eval "$(ssh-agent -s)" >/dev/null
        echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SSH_AUTH_SOCK;" >"$ssh_env_file"
        echo "SSH_AGENT_PID=$SSH_AGENT_PID; export SSH_AGENT_PID;" >>"$ssh_env_file"
        echo "ssh-agent: started new agent"
    else
        echo "ssh-agent: reusing existing agent"
    fi

    # Always try to add keys to the agent
    if [ -f ~/.ssh/id_ed25519 ]; then ssh-add --apple-use-keychain ~/.ssh/id_ed25519; fi
    if [ -f ~/.ssh/id_rsa ]; then     ssh-add --apple-use-keychain ~/.ssh/id_rsa;     fi
}

# ssh-agent: stop and clean up
ssh_agent_stop() {
    if [ -S "$SSH_AUTH_SOCK" ]; then
        if ssh-add -l | grep -q "$(ssh-keygen -lf ~/.ssh/id_rsa | awk '{print $2}')"; then
            ssh-add -d ~/.ssh/id_rsa
        fi
        if ssh-add -l | grep -q "$(ssh-keygen -lf ~/.ssh/id_ed25519 | awk '{print $2}')"; then
            ssh-add -d ~/.ssh/id_ed25519
        fi
    else
        echo "ssh-agent: No active SSH agent found."
    fi
}

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
# TODO: clean this up, FFS
function mac_suspicious() {

    function echo_sorted_items() {
        local color="$1"
        local items=("${@:2}") # Get all arguments starting from the second one

        IFS=$'\n' items=($(sort <<<"${items[*]}"))
        unset IFS

        for item in "${items[@]}"; do
            echo_color "    $item" "$color"
        done
    }

    if ! command -v kextstat &>/dev/null || ! command -v kextutil &>/dev/null || ! command -v launchctl &>/dev/null; then
        echo_color "Required command(s) not available." red bold
        return
    fi

    echo_color "Kernel Extensions (non-Apple)" blue bold
    echo_color "(\"No variant specified\" and no output means none found.)" blue

    kextstat -k -l | grep -v com.apple | awk '{print $6 "@" $3}' | while read -r k_info; do
        echo "$k_info"
        kextutil -a "$k_info"
    done
    echo ""

    echo_color "👻 Daemons (non-Apple)" blue bold
    daemons_inactive=()
    daemons_active=()
    while read -r pid daemon_id; do
        if [[ $pid != "-" ]]; then
            daemons_active+=("$daemon_id (PID: $pid)")
        else
            daemons_inactive+=("$daemon_id")
        fi
    done < <(launchctl list | grep -v com.apple | grep -v Label | awk '{print $1, $3}')

    echo_color "  Active" yellow bold
    echo_sorted_items yellow "${daemons_active[@]}"

    echo_color "  Inactive" white bold
    echo_sorted_items white "${daemons_inactive[@]}"
    echo ""

    echo_color "🚀 Launch Agents and Extensions (non-Apple)" blue bold
    directories=(
        "$HOME/Library/Application Support/LaunchAgents"
        "$HOME/Library/Application Support/LaunchDaemons"
        "$HOME/Library/LaunchAgents"
        "$HOME/Library/LaunchDaemons"
        "/Library/Extensions"
        "/Library/LaunchAgents"
        "/Library/LaunchDaemons"
    )

    for dir in "${directories[@]}"; do
        found_files=$(find "$dir" -maxdepth 1 \
                \( -name "*.kext" -o -name "*.plist" \) \
                ! -name "Apple*" \
            2>/dev/null)

        if [ -z "$found_files" ]; then
            echo_color "  $dir"
            echo "    (none)"
        else
            echo_color "  $dir" yellow
            echo "$found_files" | sed -E 's/^/    /'
        fi
    done
    echo_color "  /System/Library/Extensions" yellow bold
    echo "    (Automatic checking disabled. Manual review only.)"
    echo ""

    echo_color "📄 Files to Audit (non-root, non-wheel)" blue bold
    additional_directories=(
        "/usr/local/sbin"
        "/usr/bin"
        "/sbin"
        "/usr/sbin"
    )

    for dir in "${additional_directories[@]}"; do
        found_files=$(find "$dir" -maxdepth 1 ! -type d ! -user root ! -group wheel -exec realpath {} +)

        if [ -z "$found_files" ]; then
            echo_color "  $dir"
            echo "    (none)"
        else
            echo_color "  $dir" yellow
            echo "$found_files" | sed -E 's/^/    /'
        fi
    done
    echo_color "  /usr/local/bin" yellow bold
    echo "    (Automatic checking disabled. Manual review only.)"
}

# Update dev stuff
function update_dev_stuff() {
    cmds=(
        "brew update"
        "brew upgrade"
        "brew cleanup --prune 0"
        "brew doctor"
        # "gem update"
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
