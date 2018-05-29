#!/bin/sh

readonly mute=$(amixer get Master | grep '\[on\]')

if [ "$mute" ]; then
  amixer set Master mute
fi

xsecurelock auth_pam_x11 saver_blank

if [ "$mute" ]; then
  amixer set Master unmute
fi
