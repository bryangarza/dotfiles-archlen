# The following lines were added by compinstall
zstyle :compinstall filename '/home/wolf/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

setopt completealiases
setopt prompt_subst
#autoload -U promptinit
#promptinit

export EDITOR=vim
export VISUAL=vim
export TERMINAL=urxvtc
export VIMCLOJURE_SERVER_JAR="$HOME/lib/vimclojure/server-2.3.6.jar"

# For virtualenvwrapper:
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# For skype webcam
export XLIB_SKIP_ARGB_VISUALS=1

pcat() {
    pygmentize -g "$1"
}

sm() {
    sudo mount -U "$1" /mnt/usbstick
}

colorlist() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolour${i}\n"
    done
}

tputcolors() {
    echo
    echo -e "$(tput bold) reg  bld  und   tput-command-colors$(tput sgr0)"

    for i in $(seq 1 7); do
        echo " $(tput setaf $i)Text$(tput sgr0) $(tput bold)$(tput setaf $i)Text$(tput sgr0) $(tput sgr 0 1)$(tput setaf $i)Text$(tput sgr0)  \$(tput setaf $i)"
    done

    echo ' Bold            $(tput bold)'
    echo ' Underline       $(tput sgr 0 1)'
    echo ' Reset           $(tput sgr0)'
    echo
}

echocolors() {
    #   This file echoes a bunch of color codes to the 
    #   terminal to demonstrate what's available.  Each 
    #   line is the color code of one forground color,
    #   out of 17 (default + 16 escapes), followed by a 
    #   test use of that color on all nine background 
    #   colors (default + 8 escapes).

    T='gYw'   # The test text

    echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m"

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m'
    do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
      for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
      done
      echo;
    done
    echo
}

# quiet xev.
xevq() {
    xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'
}

refup() {
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup && echo 'backed up mirrorlist...'
    sudo reflector -l 5 --sort rate --save /etc/pacman.d/mirrorlist && echo 'latest mirror list retrieved.'
}

# core
alias c='clear'
alias ls='ls --color=always'
alias la='ls -AF --group-directories-first'
alias ll='ls -l'
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -v'
alias cr='cp -rv'
alias rr='rm -rv'
alias off='echo sudo systemctl poweroff; sudo systemctl poweroff'
alias offr='echo sudo systemctl reboot; sudo systemctl reboot'
alias l='less'

# mounting
alias lsmount='ls -lF /dev/disk/by-uuid/'
alias smu='sudo umount /mnt/usbstick'

# vim
alias v='vim'
alias vd='vimdiff'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'
alias vimi='vim ~/.i3/config'

# git
alias gs='git status'
alias gb='git branch'

# apps
alias weechat='weechat-curses'
alias enpois='envee -A poison -a g -l w -d r -s WM=dwm -s Font=Artwiz-Lime/Termsyn'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias inst='sudo pacman -Syu --needed'
alias tach='tmux attach -d -t 0'
alias pm='python2 manage.py'
alias pms='python2 manage.py syncdb'
alias pmr='python2 manage.py runserver'

# misc
alias mapcaps='xmodmap -e "clear lock"; xmodmap -e "keycode 0x42 = Escape"'
alias unmapcaps='xmodmap -e "keycode 0x42 = Caps_Lock"; xmodmap -e "add lock = Caps_Lock"'
alias 2mon='xrandr --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 1280x0 --rotate normal --output DP1 --off --output VGA1 --mode 1280x1024 --pos 0x0 --rotate normal'
alias 2monr='xrandr --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output VGA1 --mode 1280x1024 --pos 1366x0 --rotate normal'
alias 1mon='xrandr --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output VGA1 --off'

get_tot() {
    echo "$(($(find . -maxdepth 1 | wc -l)-1))"
}

get_hid() {
    echo "$(($(find . -maxdepth 1 -iname '.*' | wc -l)-1))"
}

#export PROMPT=" %~ \$(get_hid)/\$(get_tot) %% "
export PROMPT=" %~ \$(get_tot) [%h] %% "

bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End

bindkey '^R' history-incremental-search-backward

export PATH="$PATH:$HOME/scripts"
#!/bin/sh
