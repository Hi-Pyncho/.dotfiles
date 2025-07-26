#!/bin/sh

# Получаем статус громкости и mute через wpctl
status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2, $3}')
vol=$(echo "$status" | awk '{print $1 * 100}' | cut -d. -f1)
# muted=$(echo "$status" | awk '{print $2}')

# case $BLOCK_BUTTON in
	# 1) wpctl set-volume @DEFAULT_AUDIO_SINK@ 0% ;;
	# 5) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
# esac

if [ "$vol" -gt 100 ]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
    vol=100
fi

echo "$vol%"
# if [ "$muted" = "[MUTED]" ]; then
#     echo "🔇 Muted"
# else
#     echo "🔊 $vol%"
# fi
