##
# Personal
##


# Includes
case $HOSTNAME in
  (tho-lap-dolly*) source "$XDG_CONFIG_HOME"/include/arch/mac.sh   ;;
  (starlabs*)      source "$XDG_CONFIG_HOME"/include/arch/linux.sh ;;
esac

# AWS
export SHOW_AWS_PROMPT=false

# Environment
export EMAIL='actionscripted@gmail.com'


# Commands
alias cat="bat"
alias ls="exa"
