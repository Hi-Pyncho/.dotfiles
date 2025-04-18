# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="fletcherm"
HYPRSHOT_DIR="~/hyprshot-images"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
# plugins+=(zsh-vi-mode)

# tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# zsh-vi-mode config
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

# oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Aliases
alias ll='ls -lha'
alias lld='ls -lha | grep "^d"'
alias llf='ls -lha | grep "^-"'

# for job
alias open-git-job='cd /mnt/d/git/'
alias open-git-rr='cd /mnt/d/git/RussiaRunning/src/Web/RussiaRunning.Web/'
alias open-git-rr-live='cd /mnt/d/git/RussiaRunning/src/Web/RussiaRunning.Web.Chrono/Content/live-vue'
alias open-git-rr-judge='cd /mnt/d/git/RussiaRunning/src/Web/RussiaRunning.Web.Chrono/Content/judge-page'
alias open-git-rr-app='cd /mnt/d/git/RussiaRunningApp/'
alias open-git-lk='cd /mnt/d/git/LkApp/'
alias rr-backend-account-preprod='cd ~/rr-job/git/RussiaRunning.Registration/src/Account.Host && dotnet run environment=PreprodDev'

alias open-config-nvim='cd ~/.config/nvim && nvim'
alias open-obsidian-notes='cd /mnt/d/notes/ && nvim'
alias open-game-phaser='cd /mnt/d/game-dev/phaser/'

# windows nvim config
alias open-config-nvim-windows='cd /mnt/c/Users/pyncho/AppData/Local/nvim'
alias copy-config-nvim-windows='yes | cp -rf ~/.dotfiles/.config/nvim/* /mnt/c/Users/pyncho/AppData/Local/nvim'

alias vl='NVIM_APPNAME=nvim-lazyvim nvim' # default Neovim config
alias v='NVIM_APPNAME=nvim nvim' # Kickstart

alias phaser-create='npx @phaserjs/create-game@latest'

alias fd='fdfind'

alias wifi='nmtui'

alias todo='v ~/todo.md'

# vpn
alias vpn-italy='sudo openvpn --config /etc/openvpn/other-os/Italy,\ Milan\ S2.ovpn'
alias vpn-rr='cd ~/rr-job/amikaskin/ && openvpn --config tfs.ovpn --askpass pass'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# exports
#
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# nvim
export PATH="$PATH:/opt/nvim-linux64/bin"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="/home/pyncho/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
