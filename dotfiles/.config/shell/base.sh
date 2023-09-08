# General
export CLICOLOR=1
export EDITOR=nvim
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LSCOLORS='exfxcxdxbxegedabagacad'
export VISUAL=nvim

# XDG (wiki.archlinux.org/index.php/XDG_Base_Directory_support)
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# Ansible
export ANSIBLE_NOCOWS=1

# Composer
export PATH=$PATH:~/.composer/vendor/bin

# Dad Joke
alias dadjoke='curl -s https://fatherhood.gov/jsonapi/node/dad_jokes | jq ".data[$(( $RANDOM % 50 ))] | .attributes.field_joke_opener, .attributes.field_joke_response" | cowsay | lolcat'

# dircolors
DIRCOLORS_CMD=''
if command -v dircolors  >/dev/null; then  DIRCOLORS_CMD='dircolors';  fi
if command -v gdircolors >/dev/null; then  DIRCOLORS_CMD='gdircolors'; fi
[[ ! -z "$DIRCOLORS_CMD" ]] && eval $($DIRCOLORS_CMD ~/.config/shell/dircolors/dircolors.solarized-256-dark)

# ESLint
alias eslint='eslint -c ~/.config/eslint/eslintrc.js --resolve-plugins-relative-to=$(npm prefix -g)/lib/node_modules'

# Go
export GOPATH=$HOME/.go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# GPG
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# History and (sym)links
if [[ -n ${ZSH_VERSION-} ]]; then set -w; else set -P; fi

# Midnight Commander
export MC_SKIN=$XDG_CONFIG_HOME/mc/lib/mc-solarized/solarized.ini
alias mc="mc -x "

# readline
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc

# RBENV
# NOTE: you may need to install ruby-build manually
export RBENV_ROOT=$XDG_DATA_HOME/rbenv
export PATH=$XDG_DATA_HOME/rbenv/bin:$PATH
if command -v rbenv >/dev/null; then  eval "$(rbenv init -)"; fi

# Ruby and Gems
#export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem

# Rust
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup

# Oracle Database
export SQLPATH=$XDG_CONFIG_HOME/oracle

# TaskWarrior/TimeWarrior (XDG)
export TASKDATA=$XDG_DATA_HOME/task
export TASKRC=$XDG_CONFIG_HOME/task/taskrc
export TIMEWARRIORDB=$XDG_DATA_HOME/timewarrior

# Yarn
if command -v yarn >/dev/null; then  export PATH="$(yarn global bin):$PATH"; fi

# Commands
alias dc="docker-compose"
alias ex="echo NOBODY WANTS THIS COMMAND \(but if you actually do, unalias 'ex'\)"
alias greg="grep"
alias irssi="irssi --config='$XDG_CONFIG_HOME'/irssi/config --home='$XDG_DATA_HOME'/irssi"
alias pip3_upgrade_all="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U"
alias pip_upgrade_all="pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 sudo -H pip install -U"
alias py='python'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias rsync_pretty="rsync -azP"
alias rsync_remote="echo rsync -azP -e ssh you@server.com:some/path/file.zip ~/Desktop/"
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias tmuxa='tmux a -t'
alias tree='tree -C'
alias vim="nvim"
alias wget_folder="wget -np -r "
alias wget_site="wget -r -p -U Mozilla "
alias wget_site_fancy="echo wget -r -p --convert-links -U Mozilla -E -D \"www.site.com,site.com\" -H www.site.com"

# Echo tasks (for stand-ups)
function asana() {
    python3 "${HOME}/.local/bin/asana.py" "${@}"
}

# autossh
function autossh_start() {
    autossh -M 0 "$@"
}

function autossh_stop() {
    pkill autossh
}

# Automatically load .env or .env.* file by name
# https://gist.github.com/mihow/9c7f559807069a03e302605691f85572#gistcomment-3225272
function envup() {
    local file=$([ -z "$1" ] && echo ".env" || echo ".env.$1")

    if [ -f $file ]; then
        set -a
        source $file
        set +a
    else
        echo "No $file file found" 1>&2
        return 1
    fi
}

function docker_cleanup() {
    cmds=(
        "docker system prune --volumes"
        "docker images prune -a"
    )

    update_confirm_prompt="That cool? [Y/n] "
    update_confirm_timeout=10

    echo "Going to wipe out unused images, volumes and more:"
    for cmd in "${cmds[@]}"; do
        echo -e "\t${cmd}"
    done

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

# Use diff-so-fancy (and git) for non-git diffs
function dsf() {
    git diff --no-index "$@"
}

# Echo find/replace options
function find_and_replace() {
    echo 'OPTION 1'
    echo '---'
    echo 'perl -i -p -e "s/old/new/g;" *.py'
    echo '  -i  in-place editing'
    echo '  -p  assume loop, print'
    echo '  -e  one line of program'
    echo ''
    echo 'OPTION 2'
    echo '---'
    echo 'find . -name "*.py" -print0 | xargs -0 sed -i"" -e "s/old/new/g"'
    echo '  find   standard find, NUL instead of newlines (-print0)'
    echo '  xargs  use NUL for building arguments (-0)'
    echo '  sed    in-place edit (-i), regex (-e)'
    echo ''
    echo 'OPTION 3 (WARNING: GNU/OSX differences)'
    echo '---'
    echo 'find . -name "*.py" -exec sed -i"" -e "s/old/new/g" {} \;   # GNU'
    echo 'find . -name "*.py" -exec sed -i "" -e "s/old/new/g" {} \;  # OSX'
    echo '  find   standard find with exec'
    echo '  sed    in-place edit (-i), regex (-e)'
    echo ''
}

# Echo stuff I forget often
function iforgot() {
    python3 "${HOME}/.local/bin/iforgot.py" "${@}"
}

# Fix shell on legacy hosts
function legacy_mode() {
    export EDITOR=vim
    export VISUAL=vim
    unalias vim
}

# Check statuses for third-party services.
function statuspage() {
    # TODO: check for curl, jq, etc.
    # TODO: support beyond statuspage
    # TODO: install yq, use for Slack and XML
    statuspage_api_path="/api/v2/status.json"
    statuspage_services=(
        "https://confluence.status.atlassian.com/"
        "https://jira-software.status.atlassian.com/"
        "https://status.circleci.com/"
        "https://status.duo.com/"
        "https://status.fury.co/"
        "https://status.npmjs.org/"
        "https://status.python.org/"
        #"https://status.slack.com/"
        "https://status.splashtop.com/"
        "https://www.githubstatus.com/"
        "https://lucidsoftware.statuspage.io/"
        "https://status.hashicorp.com/"
        "https://status.figma.com/"
        "https://status.openai.com/"
    )

    for statuspage_service in "${statuspage_services[@]}"; do
        json=$(curl -s "$statuspage_service$statuspage_api_path")
        ind=$(echo $json | jq -r '.status.indicator')
        dsc=$(echo $json | jq -r '.status.description')
        echo "$statuspage_service: $ind ($dsc)"
    done
}

function sso_tho() {
    sso-login "tho"
}

function sso_tho_admin() {
    sso-login "tho-admin"
}

function sso_logout() {
    sso-logout "tho"
    sso-logout "tho-admin"
}

function sso_logout_tho() {
    sso-logout "tho"
}

function sso_logout_tho_admin() {
    sso-logout "tho-admin"
}

function sso_login() {
    export AWS_DEFAULT_PROFILE=$1
    export AWS_PROFILE=$1
    export AWS_EB_PROFILE=$1
    asp "${1}"
    aws sso login
}

function sso_logout() {
    aws sso logout
    unset AWS_DEFAULT_PROFILE
    unset AWS_PROFILE
    unset AWS_EB_PROFILE

}

# SSH agent up/down (TODO: broken)
function ssh_agent_init() {
    if [ ! -S ~/.ssh/ssh_auth_sock ]; then
        eval $(ssh-agent)
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi

    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    ssh-add
}

function ssh_agent_deinit() {
    if [ -n "$SSH_AUTH_SOCK" ]; then
        eval $(ssh-agent -k)
    fi
}

# Update personal configs
function update_dotfiles() {
    dir_current=$PWD
    dir_dotfiles="$HOME/.dotfiles/"

    cd "$dir_dotfiles" || exit
    make update

    cd "$dir_current" || e exit
}

# Helpful stuff
function weird() {
    printf '\n%s\n' '-----------------------------------------------------'
    printf "Shit's weird, eh? Maybe this'll help."
    printf '\n%s\n' '-----------------------------------------------------'
    printf "\n"
    printf "Terminal:\n"
    printf '    ^j    : line feed, helps with "stuck" terms\n'
    printf '    reset : reset/init strings\n'
    printf "\n"
    printf '\n%s\n' '-----------------------------------------------------'
}

# Host-specific Profiles
case $HOSTNAME in
    EngineeringsMBP*) source "$XDG_CONFIG_HOME"/shell/hosts/strata.sh   ;;
    SOI-LP50*)        source "$XDG_CONFIG_HOME"/shell/hosts/strata.sh   ;;
    starlabs*)        source "$XDG_CONFIG_HOME"/shell/hosts/personal.sh ;;
    tho-lap-dolly*)   source "$XDG_CONFIG_HOME"/shell/hosts/personal.sh ;;
esac
