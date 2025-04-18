# First run silliness
# NOTE: needs to be above P10K's instant prompt
if [[ $(pgrep zsh | wc -l) -le 1 ]]; then
    if [[ $(command -v cowsay fortune lolcat | wc -l) -eq 3 ]]; then
        fortune | cowsay -f llama | lolcat -t
    fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zsh "fixes"
export DISABLE_AUTO_UPDATE=true
export HOSTNAME=$HOST

# All hosts include
source $HOME/.config/shell/base.sh

# History (TODO: drop oh-my-zsh? it overrides EVERYTHING)
export HISTFILE="$XDG_DATA_HOME/zsh/zsh_history"
#export HISTSIZE=1000
#export SAVEHIST=1000
#setopt appendhistory

# Path to oh-my-zsh
export ZSH="$XDG_CONFIG_HOME/zsh/oh-my-zsh"
export ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh/oh-my-zsh--custom"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="solarized_responsive"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to disable prompts for updates.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# ssh-agent (plugin)
#zstyle :omz:plugins:ssh-agent agent-forwarding no
#zstyle :omz:plugins:ssh-agent identities id_rsa id_ed25519
#zstyle :omz:plugins:ssh-agent lazy yes
#zstyle :omz:plugins:ssh-agent quiet yes
#zstyle :omz:plugins:ssh-agent ssh-add-args --apple-load-keychain

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    aws
    direnv
    docker
    httpie
    docker-compose
    git
    #ssh-agent
    zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Lines configured by zsh-newuser-install
# TODO: what do these do?
setopt appendhistory autocd beep extendedglob notify
bindkey -v
#zstyle :compinstall filename '/home/MERIT/mthompson/.config/zsh/.zshrc'

# Changing this path, we're borrowing (overriding) oh-my-zsh
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
#compinit -i -C -d "${ZSH_COMPDUMP}"
#compinit -u -C -d "${ZSH_COMPDUMP}"
#skip_global_compinit=1

setopt no_share_history
unsetopt share_history


# Experimental / Future
# https://github.com/zsh-users/zsh-completions
# https://dougblack.io/words/zsh-vi-mode.html

# Profiling (as needed)
# zmodload zsh/zprof

#export PATH="$HOME/.poetry/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"


ZVM_VI_HIGHLIGHT_BACKGROUND=#414868

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh --cmd z)"
fi

