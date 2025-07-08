alias fd='fdfind'
alias todo='v ~/todo.md'

alias notes='cd ~/Notes/ && v'

alias open-config-nvim='cd ~/.config/nvim && nvim'
alias open-obsidian-notes='cd /mnt/d/notes/ && nvim'

alias v='NVIM_APPNAME=nvim nvim'

alias ll='ls -lha'
alias lld='ls -lha | grep "^d"'
alias llf='ls -lha | grep "^-"'

alias t="tmux"
alias ts="tmuxifier s"

alias dev="pnpm run dev"

# yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
