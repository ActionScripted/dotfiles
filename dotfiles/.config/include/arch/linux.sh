##
# Linux
##


# dircolors
eval $(dircolors ~/.config/include/dircolors/dircolors.solarized-256-dark)

# NPM (global, except...local; like NVM, but just a few path changes)
# https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
export NPM_PACKAGES="$XDG_DATA_HOME/npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"


# Commands
alias ls='ls --color=auto'
alias open='xdg-open'
