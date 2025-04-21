#!/bin/sh

PACKAGES="git tree stow zig lua5.1 ripgrep luarocks w3m grim slurp swappy tealdeer wikiman arch-wiki-docs"

if [ $# -eq 0 ]; then
    echo "Использование: $0 <дистрибутив>"
    echo "Доступные дистрибутивы: arch, ubuntu"
    exit 1
fi

DISTRO="$1"

install_packages() {
    case "$DISTRO" in
        arch)
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

        ubuntu|debian)
            echo "Установка пакетов для Ubuntu/Debian: $PACKAGES"
            # sudo apt update >/dev/null 2>&1

            for pkg in $PACKAGES; do
                if dpkg -l | grep -q "^ii  $pkg "; then
                    echo "[✓] $pkg уже установлен"
                else
                    echo "[ ] Установка $pkg..."
                    sudo apt install -y "$pkg" || echo "[✗] Ошибка установки $pkg"
                fi
            done
            ;;

        *)
            echo "Неизвестный дистрибутив: $DISTRO"
            echo "Поддерживаемые: arch, ubuntu"
            exit 1
            ;;
    esac
}

install_packages
