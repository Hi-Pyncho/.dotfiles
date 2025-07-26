#!/bin/sh

case $BLOCK_BUTTON in
	1) kitty -e zsh -c "cal -ym; exec zsh" ;;
esac

date '+%d %b (%a) %H:%M'
