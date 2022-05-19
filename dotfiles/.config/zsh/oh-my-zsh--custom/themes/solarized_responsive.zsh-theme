# Solarized Responsive
# ---
#
# Responsive Solarized prompt trying to avoid screaming colors.
# Might break Solarized best practices, but some colors too loud
# for prompts and/or don't couple well with Tmux, Nvim...
#
# For colors we're using the 16-bit value from the following table.
#   e.g., base03 = 8, violet = 13
#
# SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      RGB         HSB
# --------- ------- ---- -------  ----------- ---------- ----------- -----------
# base03    #002b36  8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21
# base02    #073642  0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26
# base01    #586e75 10/7 brgreen  240 #585858 45 -07 -07  88 110 117 194  25  46
# base00    #657b83 11/7 bryellow 241 #626262 50 -07 -07 101 123 131 195  23  51
# base0     #839496 12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59
# base1     #93a1a1 14/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63
# base2     #eee8d5  7/7 white    254 #e4e4e4 92 -00  10 238 232 213  44  11  93
# base3     #fdf6e3 15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99
# yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
# orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
# red       #d30102  1/1 red      124 #af0000 45  70  60 211   1   2   0  99  83
# magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
# violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
# blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
# cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
# green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60
#
# The "%{...%}" is to help with line length/position
# If you don't do this, auto-complete (tab) will not
# position suggestions properly.
#
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
# https://wiki.archlinux.org/index.php/zsh
#
# Intentionally verbose, variable-ridden and spaced-out to help newcomers.


# START THE SHOW!
# START THE SHOW!
# Assign prompt command (defined below) w/resets.
# If this were a Deathstar, this is this garbage shute.
PROMPT='%{%f%b%k%}$(prompt_build)'

# BSD-friendly directory colors
LSCOLORS='exfxcxdxbxegedabagacad'

# Virtualenv disable outside prompt changes
VIRTUAL_ENV_DISABLE_PROMPT=1

# Directory colors in auto/tab lists
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# Print a newline before the prompt, unless it's the
# first prompt in the process or we cleared.
precmd() {
  local last_cmd="$(fc -l -t "XXX" -1 | sed 's/.*XXX[ ]*//')"

  if [ -z "$PRECMD_NEWLINE" ]; then
    PRECMD_NEWLINE=1
  elif [ $last_cmd != 'clear' ]; then
    echo ''
  fi
}


# Reset (colored command input) before execution/output
preexec () { echo -ne "\e[0m"; }


# BUILD OUR PROMPT.
# Trying to keep most vars and stuff here for:
#   1) Simplicity. Too many themes make customization a nightmare.
#   2) Environment. Keep the env clear of extraneous vars.
prompt_build() {

  # Grab last action return value (KEEP FIRST)
  local retval=$?

  # Responsive breakpoint (less than triggers small view)
  local breakpoint=100

  # Track previous fg/bg for easier adding
  local prev_bg=''
  local prev_fg=''


  is_breakpoint() {
    # NOTE: 0/1 feels flipped, but it's correct
    if [[ $(tput cols) -le $breakpoint ]]; then return 0; fi
    return 1
  }


  echo_reset() {
    # Default output styles
    echo -n "%{\033[0m%}"
  }


  echo_segment() {
    # Prefix output with color and styles
    # $1 = fg, $2 = bg, $3 = style, $4 = output

    local bg="\033[48;5;$2m"
    local fg="\033[38;5;$1m"
    local style

    prev_bg=$2
    prev_fg=$1

    for s in ${(s.,.)3}; do
      case $s in
        (blink)     style+='\033[5m' ;;
        (bold)      style+='\033[1m' ;;
        (faint)     style+='\033[2m' ;;
        (italic)    style+='\033[3m' ;;
        (normal)    style+='\033[0m' ;;
        (strike)    style+='\033[9m' ;;
        (underline) style+='\033[4m' ;;
      esac
    done

    echo_reset
    echo -n "%{$style$fg$bg%}$4"
  }


  echo_separator() {
    # The fancy arrow thing between items

    local bg="\033[48;5;$2m"
    local fg="\033[38;5;$1m"

    echo_reset
    echo -n "%{$fg$bg%}\ue0b0"
  }


  # user@host.
  # Icon if responsive (aligns with prompt).
  #
  local info_bg=10
  local info_fg=7

  if is_breakpoint ; then
    echo_segment $info_fg $info_bg 'faint' " \U1f310"
  else
    echo_segment $info_fg $info_bg 'normal' ' %n'
    echo_segment $info_fg $info_bg 'faint'  '@'
    echo_segment $info_fg $info_bg 'normal' '%m '
  fi

  # AWS profile.
  # Profile name, or nothing.
  #
  local aws_bg=3
  local aws_fg=7

  if [[ -n $AWS_PROFILE ]]; then
    local aws_prompt_display=$'\u0394' # delta 'Δ'

    echo_separator $prev_bg $aws_bg

    if ! is_breakpoint ; then
      aws_prompt_display="aws:$AWS_PROFILE"
    fi

    echo_segment 7 3 'normal'  " $aws_prompt_display "
  fi

  # Virtual environment.
  # venv folder name, or delta.
  #
  local venv_bg=6
  local venv_fg=7

  if [[ -n $VIRTUAL_ENV ]]; then
    local venv_display=$'\u0394' # delta 'Δ'

    echo_separator $prev_bg $venv_bg

    if ! is_breakpoint ; then
      venv_display=$(basename $VIRTUAL_ENV)
    fi

    echo_segment 7 6 'normal'  " $venv_display "
  fi


  # Jobs.
  # Count of jobs. Jobs, counted.
  #
  local jobs_bg=13
  local jobs_fg=7

  local jobs_count=$(jobs -l | wc -l | tr -d ' ')

  if [[ $jobs_count -gt 0 ]]; then
    echo_separator $prev_bg $jobs_bg
    echo_segment $jobs_fg $jobs_bg 'normal' \
      " $jobs_count "
  fi


  # Return value.
  # Last command exit/return value.
  #
  local retval_bg=9
  local retval_fg=15

  if [[ $retval -ne 0 ]]; then
    echo_separator $prev_bg $retval_bg
    echo_segment $retval_fg $retval_bg 'normal' \
      " $retval "
  fi

  # Git.
  # If we have changes, change colors.
  #
  local git_bg=12
  local git_fg=15
  local git_changed_bg=4
  local git_changed_fg=15

  if (( $+commands[git] )); then
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
      local mode=''
      local ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
      local repo_path=$(git rev-parse --git-dir 2>/dev/null)

      local segment_bg=$git_bg
      local segment_fg=$git_fg

      setopt promptsubst
      autoload -Uz vcs_info

      zstyle ':vcs_info:*' enable git
      zstyle ':vcs_info:*' get-revision true
      zstyle ':vcs_info:*' check-for-changes true
      zstyle ':vcs_info:*' stagedstr $'\u271a' # heavy greek cross '✚'
      zstyle ':vcs_info:*' unstagedstr $'\u25cf' # black circle '●'
      zstyle ':vcs_info:*' formats '%u%c'
      zstyle ':vcs_info:*' actionformats '%u%c'
      vcs_info

      if [[ -e "${repo_path}/BISECT_LOG" ]]; then
        mode=" <B>"
      elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
        mode=" >M<"
      elif [[ -e "${repo_path}/rebase" || \
              -e "${repo_path}/rebase-apply" || \
              -e "${repo_path}/rebase-merge" || \
              -e "${repo_path}/../.dotest" ]]; then
        mode=" >R>"
      fi

      if [[ -n $(parse_git_dirty) ]]; then
        segment_bg=$git_changed_bg;
        segment_fg=$git_changed_fg;
      fi

      echo_separator $prev_bg $segment_bg
      echo_segment $segment_fg $segment_bg 'faint' \
        " \ue0a0 " git/branch symbol ''

      if ! is_breakpoint ; then
        echo_segment $segment_fg $segment_bg 'normal' \
          "${ref/refs\/heads\//}"
        echo_segment $segment_fg $segment_bg 'normal' \
          " ${vcs_info_msg_0_%% }${mode} "
      fi

    fi
  fi


  # Directory.
  # Trim if responsive.
  #
  local dir_bg=0
  local dir_fg=14
  local dir_ellipse_bg=0
  local dir_ellipse_fg=14

  echo_separator $prev_bg $dir_bg

  if is_breakpoint ; then
    if [ $PWD = $HOME ]; then
      echo_segment $dir_fg $dir_bg 'normal'  " ~ "
    else
      local dir_name=$(basename $PWD)
      local dir_name_trim=${dir_name:0:18}

      echo_segment $dir_fg $dir_bg 'normal' \
        " $dir_name_trim "

      if [ $dir_name != $dir_name_trim ]; then
        echo_segment $dir_ellipse_fg $dir_ellipse_bg 'faint' \
          "... "
      fi
    fi
  else
    echo_segment $dir_fg $dir_bg 'normal' \
      ' %~ '
  fi


  # Final/closing right arrow
  echo_separator $prev_bg 8
  echo_reset


  # Newline and prompt
  #
  local prompt_bg=0
  local prompt_fg=14

  echo ''
  echo_segment $prompt_fg $prompt_bg 'normal' ' %(!.#.$) '
  echo_separator $prev_bg 8


  # Blank space before prompt
  #
  echo_segment 0 8 'normal'  ' '
  echo_reset


  # Command input is colored (reset via preexec)
  #
  local cmd_bg=8
  local cmd_fg=2

  echo_segment $cmd_fg $cmd_bg 'normal'  ''
}
