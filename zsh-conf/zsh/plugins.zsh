source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=("history" "completion")
bindkey '^ ' autosuggest-accept

source $HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='default'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='default'
bindkey '^[p' history-substring-search-up
bindkey '^[n' history-substring-search-down 

source $HOME/.config/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh
export AUTO_NOTIFY_THRESHOLD=10
export AUTO_NOTIFY_TITLE="finished: \"%command\""
export AUTO_NOTIFY_BODY="took: %elapsed seconds\nexit: %exit_code"
export AUTO_NOTIFY_EXPIRE_TIME=4000
export AUTO_NOTIFY_WHITELIST=("pacman" "git" "yay" "mirupd")
