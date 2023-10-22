##
# Strata
##

# Includes
source "$XDG_CONFIG_HOME"/shell/arch/mac.sh
source "$XDG_CONFIG_HOME"/shell/hosts/strata.secrets.sh

# Aliases
alias vpn="/opt/cisco/secureclient/bin/vpn"

# Defaults
export EMAIL='CHANGEME@strataoncology.com'

# GitHub
export GITHUB_USER='CHANGEME'

# Homebrew (M1)
[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv and pyenv-virtualenv
#export PYENV_DEBUG=1
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

# Pathology Review (local) fix
export DEV_ARCHIVE_PATH=./archive

# Poetry
export PATH="$HOME/.local/bin:$PATH"

# Rust
[[ -f "$XDG_DATA_HOME/cargo/env" ]] && source "$XDG_DATA_HOME/cargo/env"

# VPN
export VPN_PATH="/opt/cisco/secureclient/bin/vpn"
export VPN_STATUS_FILE="$XDG_CACHE_HOME/cisco-secureclient-connected"

# Zsh
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

function vpndown() {
    vpn disconnect

    # we use this because an actual status check is slow af rigth now
    rm -f "$VPN_STATUS_FILE"
}

function vpnstatus() {
    vpn status
}

function vpnstatusfile() {
    if [[ -f "$VPN_PATH" ]]; then
        # TOD0: status checks are now super f'n slow
        #if /opt/cisco/secureclient/bin/vpn status | grep -q "Connected"; then
        if [[ -f "$VPN_STATUS_FILE" ]]; then
            return 0
        fi
    fi

    return 1
}

function vpnup() {
    # we use this because an actual status check is slow af rigth now
    touch "$VPN_STATUS_FILE"

    PSWD=$(security find-generic-password -a "${USER}" -s StrataVPN -w)
    printf '%s\n%s\npush' "${USER}" "${PSWD}" | vpn -s connect sslvpn.strataoncology.com
}
