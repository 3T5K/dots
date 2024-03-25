#!/bin/sh

log() {
	printf "\033[32m%s\033[0m\n" "$1"
}

die() {
	printf "\033[31m%s\033[0m\n" "$1" 1>&2
	exit 1
}

backup() {
	log "looking for '$1'"
	[ -e "$HOME/$1" ] &&\
		(mv -v "$HOME/$1" "$HOME/$1.bak"\
			|| die "failed to back up '~/$1'... quitting"\
			&& echo "backed up")
}

log "pinging github"
ping github.com 1>/dev/null 2>&1 || die "failed to reach github.com (make sure there is a network connection)"
echo "ok"

log "looking for dependencies"
command -v git 1>/dev/null 2>&1 || die "missing command 'git'" 
echo "ok"

backup .zshenv
backup .config/zsh
backup powerlevel10k

[ -f "$HOME/.config" ] && die "'~/.config' is a file for some reason"
[ ! -d "$HOME/.config/" ] && (mkdir -v "$HOME/.config/" || die "failed to create '~/.config/'")

log "downloading powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

log "installing config"
cp -v zshenv "$HOME/.zshenv" || printf "failed to copy zshenv -> ~/.zshenv" 1>&2
cp -rv zsh "$HOME/.config/"  || printf "failed to copy zsh -> ~/.config/zsh" 1>&2


log "downloading zsh plugins"
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git "$HOME/.config/zsh/plugins/zsh-auto-notify"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.config/zsh/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-history-substring-search.git "$HOME/.config/zsh/plugins/zsh-history-substring-search"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.config/zsh/plugins/zsh-syntax-highlighting"
