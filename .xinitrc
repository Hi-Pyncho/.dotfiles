mpd
cp $XAUTHORITY ~/.Xauthority
xkb-switch -W | while read -r event; do
  pkill -RTMIN+3 dwmblocks
done &
~/.dotfiles/scripts/handle-monitors.sh
xsetroot -solid "#111315"
flameshot &
dunst &
clipit &
kitty &
dwmblocks &
exec dwm
