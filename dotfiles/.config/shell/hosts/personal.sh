##
# Personal
##

# Includes
source "$XDG_CONFIG_HOME"/shell/hosts/personal.secrets.sh
case $HOSTNAME in
    starlabs*)      source "$XDG_CONFIG_HOME"/shell/arch/linux.sh ;;
    tho-lap-dolly*) source "$XDG_CONFIG_HOME"/shell/arch/mac.sh ;;
esac

# AWS
export SHOW_AWS_PROMPT=false

# Perlbrew
if command -v perlbrew >/dev/null; then
    export PERLBREW_HOME=$XDG_CONFIG_HOME/perlbrew/host-personal
    export PERLBREW_ROOT=$XDG_DATA_HOME/perlbrew/host-personal
    source "${PERLBREW_ROOT}/etc/bashrc"
fi

# pyenv and pyenv-virtualenv
#export PYENV_DEBUG=1
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Rust
source "${XDG_DATA_HOME}/cargo/env"

# Environment
export EMAIL='actionscripted@gmail.com'
