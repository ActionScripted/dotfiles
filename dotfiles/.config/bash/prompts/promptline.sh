# Solar Flare
# ---
#
# Solarized prompt.
# Heavily modified from Promptline (Vim).

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


# (maybe) show last exit code
function __sf_last_exit_code {
  [[ $last_exit_code -gt 0 ]] || return 1;
  printf "%s" "$last_exit_code"
}

# (maybe) show git branch
function __sf_vcs_branch {
  local branch
  local branch_symbol=" "

  # git
  if hash git 2>/dev/null; then
    if branch=$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null ); then
      branch=${branch##*/}
      printf "%s" "${branch_symbol}${branch:-unknown}"
      return
    fi
  fi
  return 1
}

# (maybe) wrap 1 with 2 and 3
function __sf_wrapper {
  [[ -n "$1" ]] || return 1
  printf "%s" "${2}${1}${3}"
}


# generate status line(s)
function __sf_ps1 {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix

  # Section A
  slice_prefix="\n${a_fg}${a_bg}${space}"
  slice_suffix="$space${a_sep_fg}"
  slice_joiner="${a_fg}${a_bg}${alt_sep}${space}"
  #slice_prefix="\n${warn_fg}${warn_bg}${space}"
  #slice_suffix="$space${warn_sep_fg}"
  __sf_wrapper \
    "\u${wrap}38;5;12${end_wrap}@${a_fg}\H" \
    "$slice_prefix" \
    "$slice_suffix"

  # Section B
  slice_prefix="${b_bg}${sep}${b_fg}${b_bg}${space}"
  slice_suffix="$space${b_sep_fg}"
  slice_joiner="${b_fg}${b_bg}${alt_sep}${space}"
  __sf_wrapper \
    "$(__sf_vcs_branch)" \
    "$slice_prefix" \
    "$slice_suffix"

  # Section C
  slice_prefix="${c_bg}${sep}${c_fg}${c_bg}${space}"
  slice_suffix="$space${c_sep_fg}"
  slice_joiner="${c_fg}${c_bg}${alt_sep}${space}"
  __sf_wrapper \
    "\w" \
    "$slice_prefix" \
    "$slice_suffix"

  # Section Warn
  slice_prefix="${warn_bg}${sep}${warn_fg}${warn_bg}${space}"
  slice_suffix="$space${warn_sep_fg}"
  slice_joiner="${warn_fg}${warn_bg}${alt_sep}${space}"
  __sf_wrapper \
    "$(__sf_last_exit_code)" \
    "$slice_prefix" \
    "$slice_suffix"

  # Close sections, print newline
  printf "%s" "${reset_bg}${sep}$reset$space"

  # Section D
  slice_prefix="\n${d_fg}${d_bg}${space}"
  slice_suffix="$reset${d_bg}${d_fg}$space${d_sep_fg}"
  slice_joiner="${d_fg}${d_bg}${alt_sep}${space}"
  __sf_wrapper \
    "\\$" \
    "$slice_prefix" \
    "$slice_suffix"

  # close sections
  #printf "%s" "${reset_bg}${sep}$reset$space${cmd_bg}${cmd_fg}"
  printf "%s" "${reset_bg}${sep}$reset$space"
}



# Primary prompt command (function)
function __sf {
  local last_exit_code="${SF_LAST_EXIT_CODE:-$?}"

  local esc=$'[' end_esc=m
  local noprint='\[' end_noprint='\]'

  local wrap="$noprint$esc" end_wrap="$end_esc$end_noprint"
  local space=" "

  local sep=""
  local rsep=""
  local alt_sep=""
  local alt_rsep=""

  local reset="${wrap}0${end_wrap}"
  local reset_bg="${wrap}49${end_wrap}"

  # Use the "16" values from the color table above
  # 256-color ANSI codes (38 = fg, 48 = bg)
  #   e.g.: 38;5;33 = 38 fg, 5 (256 color table), 33 (color)
  local a_bg="${wrap}48;5;10${end_wrap}"
  local a_fg="${wrap}38;5;7${end_wrap}"
  local a_sep_fg="${wrap}38;5;10${end_wrap}"

  local b_bg="${wrap}48;5;12${end_wrap}"
  local b_fg="${wrap}38;5;7${end_wrap}"
  local b_sep_fg="${wrap}38;5;12${end_wrap}"

  local c_bg="${wrap}48;5;0${end_wrap}"
  local c_fg="${wrap}38;5;14${end_wrap}"
  local c_sep_fg="${wrap}38;5;0${end_wrap}"

  local d_bg="${wrap}48;5;0${end_wrap}"
  local d_fg="${wrap}38;5;14${end_wrap}"
  local d_sep_fg="${wrap}38;5;0${end_wrap}"

  local cmd_bg="${wrap}48;5;8${end_wrap}"
  local cmd_fg="${wrap}38;5;2${end_wrap}"

  local warn_bg="${wrap}48;5;9${end_wrap}"
  local warn_fg="${wrap}38;5;15${end_wrap}"
  local warn_sep_fg="${wrap}38;5;9${end_wrap}"

  PS1="$(__sf_ps1)"

  # We're setting a color for command text (super white)
  # that we don't want applied to output, so we reset using
  # a "debug trap" in bash that runs before output
  #trap '[[ -t 1 ]] && tput sgr0' DEBUG
}


# Start the show
if [[ ! "$PROMPT_COMMAND" == *__sf* ]]; then
  PROMPT_COMMAND='__sf;'$'\n'"$PROMPT_COMMAND"
fi
