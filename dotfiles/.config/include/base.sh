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
if command -v dircolors  > /dev/null; then DIRCOLORS_CMD='dircolors' ; fi
if command -v gdircolors > /dev/null; then DIRCOLORS_CMD='gdircolors'; fi
[[ ! -z "$DIRCOLORS_CMD" ]] && eval $($DIRCOLORS_CMD ~/.config/include/dircolors/dircolors.solarized-256-dark)

# ESLint (NOTE: ESLint HATES a global config, YMMV)
#alias eslint='eslint -c ~/.config/eslint/eslintrc.js --resolve-plugins-relative-to=$(npm prefix -g)/lib/node_modules'

# Go
export GOPATH=$HOME/.go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# History and (sym)links
if [[ -n ${ZSH_VERSION-} ]]; then set -w; else set -P; fi

# readline
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc


# Commands
alias dc="docker-compose"
alias ex="echo NOBODY WANTS THIS COMMAND \(but if you actually do, unalias 'ex'\)"
alias greg="grep"
alias py='python'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias tmuxa='tmux a -t'
alias tree='tree -C'
alias vim="nvim"


# Use diff-so-fancy (and git) for non-git diffs
function dsf() {
  git diff --no-index "$@"
}


# Echo stuff I forget often
function iforgot {
  python3 "${HOME}/.local/bin/iforgot.py" "${@}"
}


# Fix shell on legacy hosts
function legacy-mode {
  export EDITOR=vim
  export VISUAL=vim
  unalias vim
}


# Check statuses for third-party services.
function statuspage {
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
  )

  for statuspage_service in "${statuspage_services[@]}"; do
    json=$(curl -s "$statuspage_service$statuspage_api_path")
    ind=$(echo $json | jq -r '.status.indicator')
    dsc=$(echo $json | jq -r '.status.description')
    echo "$statuspage_service: $ind ($dsc)"
  done
}


# Update personal configs
function update-dotfiles {
  dir_current=$PWD
  dir_dotfiles="$HOME/.dotfiles/"

  cd $dir_dotfiles
  make update

  cd $dir_current
}


# Helpful stuff
function weird {
  printf '\n%s\n' '-----------------------------------------------------'
  printf "Things are weird, eh? Maybe this'll help."
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
  (SOI-LP50*) source "$XDG_CONFIG_HOME"/include/hosts/strata.sh ;;
esac
