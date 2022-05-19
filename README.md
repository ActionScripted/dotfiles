# dotfiles

Automatically symlink (and backup) configuration files.


# Overview

Files:

* **`dotfiles-manual`**: configuration items manually moved
* **`dotfiles`**: configuration items
* `setup.sh`: non-desctructive setup
* `update.sh`: update dotfiles and submodules

Philosophy:

* Non-destructive; versioned backups in `~/dotfiles.backups`.
* Use XDG Base Directory specifications when possible.


# Setup

**NOTE:** setup backs up existing files and symlinks to `~/.dotfiles.backups`

```bash
# Copy base repo to ~/.dotfiles
git clone --recurse-submodules git@github.com:ActionScripted/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run setup
make setup
```

# Setup: Manual

* Fonts:
  * `brew tap homebrew/cask-fonts`
  * `brew install font-fira-code`
  * `brew install font-fira-code-nerd-font`
  * iTerm2: Preferences > Text > Font
    * Make sure the font and the non-ascii font are set correctly.
    * Enable ligatures.


# Updating

Update core and dependencies:

* `cd ~/.dotfiles && make update`

Add/edit files:

* Create/edit file(s)
* Manually symlink or run `setup.sh`
* `git commit && git push`



# Nvim and Plugins

Init:

```bash
:PlugInstall
```

Upgrade/update:

```bash
:PlugUpgrade
:PlugUpdate
```

Clean (remove/uninstall unlisted):
```bash
:PlugClean
```


# Tmux and Plugins

Init:

```bash
<prefix> + I
```

Upgrade/update:

```bash
<prefix> + U
```

Clean (remove/uninstall unlisted):
```bash
<prefix> + alt + u
```


# VS Code

Setup:

```bash
# This is for macOS; change as needed
# https://code.visualstudio.com/docs/getstarted/settings#_settings-file-locations
ln -s ~/.config/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
cat ~/.config/vscode/extensions.txt | xargs -L 1 code --install-extension
```

Export Extensions:

```bash
code --list-extensions > ~/.config/vscode/extensions.txt
```
