#!/bin/sh

MAIN="nvim git stow zig lua5.1 ripgrep luarocks xdg-user-dirs usbutils lshw htop kitty"
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

PACKAGES="$MAIN $INFO $TERMINAL $WAYLAND $WEB $AUDIO $UTILS $BLUETOOTH $IMAGE"

install_packages() {
  if command -v yay >/dev/null 2>&1; then
    PKG_MANAGER="yay"
  else
    PKG_MANAGER="sudo pacman"
  fi

  echo "Установка пакетов для Arch Linux: $PACKAGES"
  
  for pkg in $PACKAGES; do
    if pacman -Qi "$pkg" >/dev/null 2>&1; then
      echo "[✓] $pkg уже установлен"
    else
      echo "[ ] Установка $pkg..."
      $PKG_MANAGER -S --noconfirm "$pkg" || echo "[✗] Ошибка установки $pkg"
    fi
  done
  ;;
}

install_packages
