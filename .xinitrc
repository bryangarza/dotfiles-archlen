#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset +fp /usr/share/fonts/local,/usr/share/fonts/artwiz-fonts
xset fp rehash

. ~/.zshrc
xrdb ~/.Xresources

xbindkeys

xmodmap -e "clear lock"
xmodmap -e "keycode 0x42 = Escape"

urxvtd -q -o -f &
unclutter -idle 10 -jitter 5 &

#xsetroot -solid "#333333"
hsetroot -center ~/images/knife_party2.jpg
#hsetroot -fill ~/images/spaceships.jpg
#~/.screenlayout/2mon.sh

# fix java apps:
# https://wiki.archlinux.org/index.php/Java#Impersonate_Another_Window_Manager
wmname LG3D
exec i3
