#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Set up an icon tray
#trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 --distancefrom right --distance 422 --alpha 0 &

# Zed Scripts 
~/.config/xmobar/brightness.sh &
~/.dotfiles/config/xmobar/player.sh &
echo "" | xmonadpropwrite _XM
~/.dotfiles/autoPush.sh &
~/.dotfiles/autoBrightness.sh &
~/.dotfiles/wallpapers/BingWallpapers.sh

# Set the default X cursor to the usual pointer
xsetroot -cursor_name left_ptr


# Fire up screensaver
xscreensaver -no-splash &


if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

exec $HOME/.cache/xmonad/xmonad-x86_64-linux

#bottles-cli run -b Games -p GTAIV
