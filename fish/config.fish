#                   __ _          __ _     _     
#   ___ ___  _ __  / _(_) __ _   / _(_)___| |__  
#  / __/ _ \| '_ \| |_| |/ _` | | |_| / __| '_ \ 
# | (_| (_) | | | |  _| | (_| |_|  _| \__ \ | | |
#  \___\___/|_| |_|_| |_|\__, (_)_| |_|___/_| |_|
#                        |___/                   

#################
### VARIABLES ###
#################

if status --is-login
    set -x WINIT_X11_SCALE_FACTOR 1
    set -x EDITOR nvim
    set -x QT_QPA_PLATFORMTHEME qt5ct
    set -x XDG_CONFIG_HOME "$HOME/.config"
end

# Removes the initial greeting
set fish_greeting

# Emulates vim's cursor shape behavior
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block
set fish_vi_force_cursor # Ensure the cursor actually changes

set TERM "xterm-256color"
set -g __FISH_DRAW_TRANSIENT__ 0

##############
### PROMPT ###
##############

function maybe_exec
    if ! commandline --paging-mode    \
        && commandline --is-valid     \
        || test -z "$(commandline -b)"
        set -g __FISH_DRAW_TRANSIENT__ 1
        commandline -f repaint
    else
        set -g __FISH_DRAW_TRANSIENT__ 0
    end

    commandline -f execute
end

function os
    grep -Po '(?<=^ID=).*' /etc/os-release
end

function fish_prompt
    set -l last_status $status

    if test $__FISH_DRAW_TRANSIENT__ -eq 1
        string join '' -- (set_color --bold CBA6F7) '-> ' (set_color normal)
        set __FISH_DRAW_TRANSIENT__ 0
        return
    end

    set -l stat
    if test $last_status -ne 0
        set stat (set_color red)" [$last_status]"(set_color normal)
    end

    set -g __fish_git_prompt_color --bold green # CBA6F7
    set -g __fish_git_prompt_color_prefix --bold brcyan
    set -g __fish_git_prompt_color_suffix --bold brcyan

    string join '' --                         \
        (set_color --bold brcyan) '('         \
        (set_color --bold CBA6F7) (prompt_pwd)\
        (set_color --bold brcyan) ')'         \
        (fish_git_prompt | sed 's/ /_/g')     \
        $stat                                 \
        (set_color --bold CBA6F7) ' :3 '      \
        (set_color --bold normal)
end

function fish_right_prompt
    # date +"%H:%M:%S"
end

function fish_mode_prompt
    if test $__FISH_DRAW_TRANSIENT__ -eq 1
        return
    end

    set_color --bold brcyan
    echo '('
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo 'N'
        case insert
            set_color --bold green
            echo 'I'
        case replace_one
            set_color --bold green
            echo 'R'
        case visual
            set_color --bold brmagenta
            echo 'V'
        case '*'
            set_color --bold red
            echo '?'
    end
    set_color --bold brcyan
    echo ')_'
end

###################
### KEYBINDINGS ###
###################

function fish_user_key_bindings
  fish_vi_key_bindings
end

bind -M insert -k nul accept-autosuggestion
bind -M default -m insert -k nul accept-autosuggestion
bind -M insert \r maybe_exec
bind -M default -m insert \r maybe_exec


#########################################
### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
#########################################

set fish_color_normal white # default color
set fish_color_command --bold brcyan # commands like echo
set fish_color_keyword --bold blue # keywords like if - this falls back on the command color if unset
set fish_color_quote --italics yellow # quoted text like "abc"
set fish_color_redirection --dim brblack # 6B7086 # IO redirections like >/dev/null
set fish_color_end --bold CBA6F7 # process separators like ; and &
set fish_color_error red # C72C36 # syntax errors
set fish_color_param CBA6F7 # 9B59B6 # ordinary command parameters
set fish_color_valid_path --underline CBA6F7 # green # parameters that are filenames (if the file exists)
set fish_color_option --bold CBA6F7 # options starting with “-”, up to the first “--” parameter
set fish_color_comment brblack # comments like ‘# important’
set fish_color_selection --bold --background 45475A 7F849C # selected text in vi visual mode
set fish_color_operator brgreen # parameter expansion operators like * and ~
set fish_color_escape brgreen # character escapes like \n and \x70
set fish_color_autosuggestion 45475a # 7d7d7d # autosuggestions (the proposed rest of a command)
# set fish_color_cwd # the current working directory in the default prompt
# set fish_color_cwd_root # the current working directory in the default prompt for the root user
# set fish_color_user # the username in the default prompt
# set fish_color_host # the hostname in the default prompt
# set fish_color_host_remote # the hostname in the default prompt for remote sessions (like ssh)
# set fish_color_status # the last command’s nonzero exit code in the default prompt
set fish_color_cancel 45475A # the ‘^C’ indicator on a canceled command
set fish_color_search_match --background 45475A # history search matches and selected pager items (background only)
# set fish_color_history_current # the current position in the history for commands like dirh and cdh

set fish_pager_color_progress --bold green # the progress bar at the bottom left corner
set fish_pager_color_background --background none # the background color of a line
set fish_pager_color_prefix --bold brcyan # the prefix string, i.e. the string that is to be completed
set fish_pager_color_completion CBA6F7 # the completion itself, i.e. the proposed rest of the string
set fish_pager_color_description green # the completion description
set fish_pager_color_selected_background --background none # 45475A # background of the selected completion
set fish_pager_color_selected_prefix --underline --bold brcyan # prefix of the selected completion
set fish_pager_color_selected_completion --underline brcyan # CBA6F7 # suffix of the selected completion
set fish_pager_color_selected_description green # description of the selected completion
set fish_pager_color_secondary_background --background none # background of every second unselected completion
set fish_pager_color_secondary_prefix --bold brcyan # prefix of every second unselected completion
set fish_pager_color_secondary_completion CBA6F7 # suffix of every second unselected completion
set fish_pager_color_secondary_description green # description of every second unselected completion

#################
### FUNCTIONS ###
#################

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

###############
### ALIASES ###
###############

# ls
alias ls='exa'
alias ll='exa -l'
alias la='exa -a'
alias lla='exa -la'

# navigation
alias pd='prevd'
alias nd='nextd'
alias dcs='cd $HOME/Documents/'
alias pcs='cd $HOME/Pictures/'
alias dwn='cd $HOME/Downloads/'
alias wps='cd $HOME/Pictures/wallpapers/'
alias dots='cd $HOME/.config'
alias wd='cd $WD'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# misc
alias cl='clear'
alias x='exit'
alias t='touch'
alias sys='sudo systemctl'
alias v='WD="$(pwd)" nvim'
alias sv='sudo vim'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -v'
alias wh='which'
alias se='sudoedit'
alias pt='python'
alias tf='printf "%s-%s" $(date -I | sed "s/-//g") $(date "+%H%M%S")'
alias ob='objdump -dSwCsMaddr64,intel --no-show-raw-insn'
alias cg++='g++ -std=c++23 -Wall -Wextra -Wpedantic -Wshadow -Wconversion -Wunused -O3'
alias cclang++='clang++ -std=c++23 -Wall -Wextra -Wpedantic -Wshadow -Wconversion -Wunused -O3 -stdlib=libc++'
alias ast='clang++ -std=c++23 -Xclang -ast-dump -fsyntax-only'
alias ydl='yt-dlp -x --audio-format best --audio-quality 0'
alias ywav='yt-dlp -x --audio-format wav'
alias ins='instaloader --no-videos --no-video-thumbnails --no-captions --no-metadata-json'
alias smt='objdump -t'
alias sxiv='xrdb -merge ~/.Xresources && command sxiv -b'
alias ns='xrdb -merge ~/.Xresources && command nsxiv -b'
alias cs='sha256sum'
alias db='distrobox'
alias dbe='distrobox enter'

#####################
### FETCH PROGRAM ###
#####################

if status --is-interactive
    # pfetch
    # screenfetch
    # nitch
end
