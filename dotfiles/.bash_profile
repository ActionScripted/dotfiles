# Some fun bash commands to NEVER forget:
#   !$ -- references the last path used (sort of...)
#   !! -- references the last command used


# All hosts include
source $HOME/.config/include/base.sh

# History file change
export HISTFILE="$XDG_DATA_HOME"/bash/history

# Prompt (default)
export PS1="\h:\W \u\$ "
# Prompt, custom
source ~/.config/bash/prompts/promptline.sh

# First run silliness
if [[ $(pgrep bash | wc -l) -le 0 ]]; then
  if [[ $(command -v cowsay fortune lolcat | wc -l) -eq 3 ]]; then
    fortune | cowsay -f satanic | lolcat -t
  fi
fi

export PATH="$HOME/.poetry/bin:$PATH"
