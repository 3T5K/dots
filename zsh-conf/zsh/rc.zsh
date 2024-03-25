# nitch
# colorscript -r

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' ignore-parents parent directory
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename '/home/ivan/.zshrc'

autoload -Uz compinit
compinit
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=20000
setopt autocd nomatch
unsetopt beep 
bindkey -e
