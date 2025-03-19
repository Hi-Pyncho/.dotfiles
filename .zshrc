# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="fletcherm"
HYPRSHOT_DIR="~/hyprshot-images"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
# plugins+=(zsh-vi-mode)

export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# zsh-vi-mode config
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

source $ZSH/oh-my-zsh.sh

# Aliases
alias ll='ls -lha'
alias lld='ls -lha | grep "^d"'
alias llf='ls -lha | grep "^-"'

alias open-git-job='cd /mnt/d/git/'
alias open-git-rr='cd /mnt/d/git/RussiaRunning/src/Web/RussiaRunning.Web/'
alias open-git-rr-live='cd /mnt/d/git/RussiaRunning/src/Web/RussiaRunning.Web.Chrono/Content/live-vue'
alias open-git-rr-judge='cd /mnt/d/git/RussiaRunning/src/Web/RussiaRunning.Web.Chrono/Content/judge-page'
alias open-git-rr-app='cd /mnt/d/git/RussiaRunningApp/'
alias open-git-lk='cd /mnt/d/git/LkApp/'

alias open-config-nvim='cd ~/.config/nvim && nvim'
alias open-obsidian-notes='cd /mnt/d/notes/ && nvim'
alias open-game-phaser='cd /mnt/d/game-dev/phaser/'

# windows nvim config
alias open-config-nvim-windows='cd /mnt/c/Users/pyncho/AppData/Local/nvim'
alias copy-config-nvim-windows='yes | cp -rf ~/.dotfiles/.config/nvim-kickstart/* /mnt/c/Users/pyncho/AppData/Local/nvim'

alias vl='NVIM_APPNAME=nvim-lazyvim nvim' # default Neovim config
alias v='NVIM_APPNAME=nvim nvim' # Kickstart

alias phaser-create='npx @phaserjs/create-game@latest'

alias fd='fdfind'

alias wifi='nmtui'

alias todo='v ~/todo.md'

# vpn
alias vpn-italy='sudo openvpn --config /etc/openvpn/other-os/Italy,\ Milan\ S2.ovpn'
alias vpn-rr='cd ~/rr-job/amikaskin/ && sudo openvpn --config tfs.ovpn --askpass pass'

# The way with select config
vv() {
  select config in lazyvim kickstart 
  do NVIM_APPNAME=nvim-$config nvim $@; break; done
}

# The way with select config with fzf
vvv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/opt/nvim-linux64/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="/home/pyncho/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
