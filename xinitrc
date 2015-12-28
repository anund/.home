#!/bin/sh

usexmonad=$HOME/.startxmonad
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

if [ -f "$usexmonad" ]; then
# QT relies env vars in 5+ to find settings files
    export XDG_CURRENT_DESKTOP="kde"
# Alternatively qt5ct can be used to run without a full kde or gnome environment
#    export QT_QPA_PLATFORMTHEME="qt5ct"
    exec xmonad
else
    exec startkde
fi
