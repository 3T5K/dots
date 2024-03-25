# Zsh Config

## Plugins
1. auto-notify
2. autosuggestion
3. history-substr
4. syntax-highlighting
5. p10k prompt

## Files

### install.sh

- Installs all the configuration files/directories into place.
- Backs up existing config.
- Doesn't actually install Zsh nor does it set Zsh as a login shell.
- Downloads all plugins via `git clone`.

### zshenv

- Is a file that points to the configuration in *~/.config*.
- Should be copied to *~/.zshenv*.

### zsh

- Is a directory that contains all configuration and plugin sources.
- Should be copied to *~/.config/zsh/*.
