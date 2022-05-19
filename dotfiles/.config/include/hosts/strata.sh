##
# Strata
##

# Includes
source "$XDG_CONFIG_HOME"/include/arch/mac.sh
source "$XDG_CONFIG_HOME"/include/hosts/strata.secrets.sh


# Aliases
alias cat="bat"
alias ls="exa"
alias vpn="/opt/cisco/anyconnect/bin/vpn"


# Defaults
export EMAIL='michael.thompson@strataoncology.com'

#export PYENV_DEBUG=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init - --no-rehash zsh)"
eval "$(pyenv virtualenv-init - zsh)"

# Poetry
export PATH="$HOME/.local/bin:$PATH"

# Zsh
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export SHOW_AWS_PROMPT=false


function vpndown {
  vpn disconnect
}

function vpnup {
  PSWD=$(security find-generic-password -a ${USER} -s StrataVPN -w)
  printf '%s\n%s\npush'  "${USER}" "${PSWD}" | vpn -s connect sslvpn.strataoncology.com
}
