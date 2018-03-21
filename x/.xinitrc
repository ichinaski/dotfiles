#! /bin/bash
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
eval $(ssh-agent)
ssh-add
xbindkeys
exec i3
