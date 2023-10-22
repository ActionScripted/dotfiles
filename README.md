# dotfiles

Automatically symlink (and backup) configuration files.

# Overview

Files:

- **`dotfiles`**: configuration items
- **`dotfiles-manual`**: configuration items manually moved
- `bin/install-*.sh`: install platform-specific deps (only macOS is safe)
- `bin/setup.sh`: non-desctructive setup
- `bin/update.sh`: update dotfiles and submodules

Philosophy:

- Non-destructive; versioned backups in `~/dotfiles.backups`.
- Secrets are intentionally separate/safe from any version control.
- Use XDG Base Directory specifications when possible.

# Setup

> [!IMPORTANT]
> Setup backs up existing files and symlinks to `~/.dotfiles.backups`. It is non-destructive, every run.

```bash
# Clone to ~/.dotfiles
git clone --recurse-submodules git@github.com:ActionScripted/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run setup
make setup
```

## Optional Setup

> [!NOTE]
> These are highly recommended after running the automatic setup but technically optional.

- Fonts:
  - `brew tap caskroom/fonts`
  - `brew install font-fira-code`
  - `brew install font-fira-code-nerd-font`
  - iTerm2: Preferences > Text > Font: make sure the font and the non-ascii font are set correctly.
- Personalization:
  - Find and replace all "CHANGEME" to either a user name or email:
    - `grep -rl "CHANGEME" ~/.dotfiles`
    - Edit at will!
- Secrets:
  - `touch ~/.config/shell/hosts/personal.secrets.sh`
  - `touch ~/.config/shell/hosts/strata.secrets.sh`
  - Put your sensitive stuff here like API keys, etc.
  - Update the corresponding shell files to source these as needed.
- Web Browser:
  - Setup Nginx locally and host your start page and set your browser to use it for new windows and tabs.
    - `brew install nginx`
    - Edit `/usr/local/etc/nginx/nginx.conf` and change default listen to 65432 (to avoid dev conflicts)
    - Symlink start page via `ln -s $XDG_CONFIG_HOME/strata/startpage.html /usr/local/var/www/startpage.html`
    - Open <http://localhost:65432/startpage.html> and verify it loads (adjust above if not)
    - Update browser settings to use <http://localhost:65432/startpage.html> for windows/tabs.

# Personalization

Once you've gotten things setup you can trash `.git` and create/init your own repo. This should be added to your VCS remote in a private repo and never be public. It's really easy to leak sensitive stuff through shell files, wiki docs, etc. You can always pull down changes from this repo into your private repo.

Things you might want to customize:

- Remove the Strata bits, because you don't work there. Instead add your own company shell, start page etc.

# Updating

Update core and dependencies:

- `cd ~/.dotfiles && make update`

Add/edit files:

- Create/edit file(s)
- Manually symlink or run `setup.sh`
- `git commit && git push`

# Nvim and Plugins

Init, upgrade/update, clean:

```bash
:Lazy
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
