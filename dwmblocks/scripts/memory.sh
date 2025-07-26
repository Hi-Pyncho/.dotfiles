#!/bin/sh

case $BLOCK_BUTTON in
	1) notify-send " Memory hogs" "$(ps axch -o cmd:15,%mem --sort=-%mem | head)" ;;
	2) setsid -f "kitty" -e htop ;;
	3) notify-send " Memory module" "\- Shows Memory Used/Total.
- Click to show memory hogs.
- Middle click to open htop." ;;
esac

# free --mebi | sed -n '2{p;q}' | awk '{printf ("%2.2fGiB/%2.2fGiB", ( $3 / 1024), ($2 / 1024))}'
total_mem=$(free -m | awk '/Mem:/ {print $2}')
used_mem=$(free -m | awk '/Mem:/ {print $3}')  # Память, используемая процессами
buff_cache=$(free -m | awk '/Mem:/ {print $6}')  # Буферы + кэш

used_percent=$(echo "$used_mem * 100 / $total_mem" | bc)

echo ${used_percent}%
