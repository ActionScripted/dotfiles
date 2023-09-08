#!/usr/bin/env bash
#
# TODO: Title
#
# TODO: Description (can be multi-line)
#
# Author:    Michael Thompson <actionscripted@gmail.com>
# License:   MIT
# Requires:  TODO: requirements
# Usage:     TODO: usage
# Version:   0.0.1

function confirm() {
  read -p "Are you sure? [$1] " -n 1 -r

  # If enter pressed, use default.
  if [ -z $REPLY ]; then REPLY=$2; fi

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo 1
  else
    echo 0
  fi
}

function confirm_no() {
  confirm "y/N" "n"
}

function confirm_yes() {
  confirm "Y/n" "y"
}

function prompt() {
  read -p "$1 " -r
  echo "$REPLY"
}

confirm_no
confirm_no
confirm_no
confirm_no
confirm_no

echo "---"

confirm_yes
confirm_yes
confirm_yes
confirm_yes
confirm_yes

prompt "what's your name?"
