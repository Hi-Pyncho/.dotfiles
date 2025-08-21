#!/bin/sh

echo 'Обновление системы...'
sudo pacman -Syu

echo 'Установка yay...'
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

MAIN="nvim stow zig lua5.1 ripgrep luarocks usbutils lshw htop kitty zsh tmux rofi ncdu wireplumber mtpfs gvfs-mtp libmtp brightnessctl"
X11="xkblayout-state xorg-server-xephyr xdg-user-dirs xkb-switch"
VIDEO="vlc"
MUSIC="mpd mpc rmpc"
NOTIFY="dunst libnotify"
OTHER="qbittorrent virtualbox"
BROWSERS="google-chrome firefox"
CLIPBOARD="xcel xclip clipit"
INFO="tealdeer wikiman arch-wiki-docs"
BLUETOOTH="bluez bluez-utils blueman"
AUDIO="pavucontrol"
TERMINAL="yazi"
NETWORK="syncthing"
WAYLAND="slurp swappy wf-recorder grim"
WEB="w3m"
UTILS="plocate lazygit"
VIEWERS="zathura zathura-pdf-poppler"
IMAGE="imagemagick inkscape"

PACKAGES="$MAIN $INFO $TERMINAL $WEB $AUDIO $UTILS $BLUETOOTH $IMAGE $CLIPBOARD $BROWSERS $X11 $VIDEO $MUSIC"
PKG_MANAGER="yay"

install_packages() {
  echo "Установка пакетов для Arch Linux: $PACKAGES"

  for pkg in $PACKAGES; do
    if pacman -Qi "$pkg" >/dev/null 2>&1; then
      echo "[✓] $pkg уже установлен"
    else
      echo "[ ] Установка $pkg..."
      $PKG_MANAGER -S --noconfirm "$pkg" || echo "[✗] Ошибка установки $pkg"
    fi
  done
}

install_packages

echo 'Изменение shell на zsh...'
chsh -s /bin/zsh

echo 'Установка шрифтов...'
# yay nerd-fonts
echo 1 | yay ttf-jetbrains-mono

echo 'Установка xorg и dwm'
sudo pacman -S xf86-video-fbdev xorg xorg-xinit nitrogen picom libx11 libxinerama libxft webkit2gtk
cd ~/.dotfiles/dwm/ & sudo make clean install

echo 'Создание симлинков через stow...'
stow .
