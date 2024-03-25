# ZSH Config

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
- Downloads all plugins via `git clone`.
- Doesn't actually install ZSH nor does it set ZSH as a login shell.
- Doesn't install any programs mentioned in the *aliases.zsh* file.
- Doesn't restore backups, nor clean up after failure (yet).

### zshenv

- Is a file that points to the configuration in *~/.config*.
- Should be copied to *~/.zshenv*.

### zsh

- Is a directory that contains all configuration and plugin sources.
- Should be copied to *~/.config/zsh/*.

## Manual Install

- Copy *zshenv* and *zsh* to the places specified above.
- Then run:
```bash
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git "$HOME/.config/zsh/plugins/zsh-auto-notify"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.config/zsh/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-history-substring-search.git "$HOME/.config/zsh/plugins/zsh-history-substring-search"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.config/zsh/plugins/zsh-syntax-highlighting"
```
