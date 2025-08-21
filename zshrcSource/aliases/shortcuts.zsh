alias fd='fdfind'
alias todo='v ~/todo.md'

alias notes='cd ~/Notes/ && v'

alias nvim-config='cd ~/.config/nvim && nvim'
alias dotfiles="cd ~/.dotfiles && nvim"
alias playground="cd ~/playground && nvim"

alias v='NVIM_APPNAME=nvim nvim'
alias vs='sudo -E nvim'

alias ll='ls -lha'
alias lld='ls -lha | grep "^d"'
alias llf='ls -lha | grep "^-"'

alias t="tmux"
alias ts="tmuxifier s"

alias dev="pnpm run dev"
alias zshupdate="exec zsh && . ~/.dotfiles/.zshrc"

# yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# dwm
alias cdwm="v ~/.dotfiles/dwm/config.h"
alias mdwm="cd ~/.dotfiles/dwm; sudo make clean install; cd -"
alias mdwmb="cd ~/.dotfiles/dwmblocks; sudo make clean install; cd -"
alias dwm-xephyr="startx -- /usr/bin/Xephyr -screen 800x600 :1"
alias dwm-config="v ~/.dotfiles/dwm/config.h"
alias dwmblocks-config="cd ~/.dotfiles/dwmblocks/ && v config.h"
