#!/usr/bin/env bash

# Путь к папке с конфигами
VPN_CONFIG_DIR="/etc/openvpn/config"

# Проверяем, существует ли папка
if [[ ! -d "$VPN_CONFIG_DIR" ]]; then
  echo "❌ Папка $VPN_CONFIG_DIR не найдена!"
  exit 1
fi

# Получаем список .ovpn файлов
configs=()
while IFS= read -r -d $'\0' file; do
  configs+=("$file")
done < <(find "$VPN_CONFIG_DIR" -maxdepth 1 -name "*.ovpn" -print0)

if [[ ${#configs[@]} -eq 0 ]]; then
  echo "❌ В папке $VPN_CONFIG_DIR нет .ovpn файлов!"
  exit 1
fi

# Выводим меню выбора
echo "Доступные конфиги OpenVPN:"
for i in "${!configs[@]}"; do
  echo "$((i+1)). $(basename "${configs[$i]}")"
done

# Запрашиваем выбор
read -p "Выберите номер конфига: " choice

# Проверяем корректность выбора
if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#configs[@]} )); then
  echo "❌ Неверный выбор!"
  exit 1
fi

# Запускаем OpenVPN
selected_config="${configs[$((choice-1))]}"
echo "Запускаю OpenVPN с конфигом: $(basename "$selected_config")"
sudo openvpn --config "$selected_config"
