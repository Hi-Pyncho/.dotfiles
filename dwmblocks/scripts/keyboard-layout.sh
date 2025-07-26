#!/bin/sh

get_layout() {
  layout=$(xkblayout-state print "%s")
  case "$layout" in
    "us") echo "EN" ;;
    "ru") echo "RU" ;;
    *) echo "$layout" ;;  # если не обработано, выводим код
  esac
}

get_layout
