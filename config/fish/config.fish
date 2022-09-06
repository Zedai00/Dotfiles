## Set values
set SDL_VIDEODRIVER wayland
set _JAVA_AWT_WM_NONREPARENTING 1
set QT_QPA_PLATFORM wayland
set XDG_CURRENT_DESKTOP sway
set XDG_SESSION_DESKTOP sway

# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low


## Environment setup
# Apply .profile
source ~/.profile

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
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

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# # Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# # Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# ## Import colorscheme from 'wal' asynchronously
if type wal >>/dev/null 2>&1
    cat ~/.cache/wal/sequences
end

## Useful aliases
# Replace ls with exa
alias l='exa -al --color=always --group-directories-first --icons'
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons' # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'" # show only dotfiles

# Replace some more things with better alternatives
alias cat='bat --style header --style rules --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru --bottomup'

# Common use
alias aup="pamac upgrade --aur"
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias upd='sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && sudo pacman -Syu && fish_update_completions && sudo updatedb'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short' # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Help people new to Arch
alias apt='man pacman'
alias apt-get='man pacman'
alias helpme='cht.sh --shell'
alias please='sudo'
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Zed Functions
if pgrep yt-dlp >/dev/null
    set -U playing true
else
    set -U playing false
end

# Zed Alias and Variables
alias s="sudo"
alias pkg="paru --bottomup"
alias yay="paru --bottomup"
alias paru="paru --bottomup"
alias yt4='cd /Zed/Music/4KVideoDownloader
 yt-dlp  --no-playlist --extract-audio --audio-format mp3 -o "%(title)s - %(artist)s.%(ext)s" --embed-subs --embed-thumbnail --add-metadata  '
alias yth='cd /Zed/Music/Hindi
 yt-dlp  --no-playlist --extract-audio --audio-format mp3 -o "%(title)s - %(artist)s.%(ext)s" --embed-subs --embed-thumbnail --add-metadata  '
alias ytk='cd /Zed/Music/Korean
 yt-dlp  --no-playlist --extract-audio --audio-format mp3 -o "%(title)s - %(artist)s.%(ext)s" --embed-subs --embed-thumbnail --add-metadata  '
alias zed="cd /Zed"
alias yt='yt-dlp'
alias ac='git add -A && git commit -m'
alias sys='sudo systemctl'
alias syse="sudo systemctl enable"
alias syss="sudo systemctl start"
alias sysp="sudo systemctl stop"
alias sysr="sudo systemctl restart"
alias sysd="sudo systemctl disable"
alias syst="sudo systemctl status"
alias less="less -r"
alias syncm="rsync -avu --delete --inplace --verbose --progress --recursive --omit-dir-times --no-perms /Zed/Music/ /run/user/1000/34eb2e6729677fec/C507-19E8/Music"
alias syncmr="rsync -avu --delete --inplace --verbose --progress --recursive --omit-dir-times --no-perms /run/user/1000/34eb2e6729677fec/C507-19E8/Music/ /Zed/Music"
alias su="su -m"
alias logout="kill -9 -1"
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -x fish ~/.config/fish/config.fish
set -x EDITOR nano
alias nv="nvim"
alias cls="clear"
alias py="python"
alias cmd="command"
alias nd="neovide"
