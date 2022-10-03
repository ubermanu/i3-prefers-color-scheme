#!/usr/bin/env bash

# This script is used to set the `prefers-color-scheme` media query
# to the value of the `PREFERS_COLOR_SCHEME` environment variable.

# Get the value from the argument or the environment variable.
if [[ -z "$1" ]]; then
  value="$PREFERS_COLOR_SCHEME"
else
  value="$1"
fi

if [[ -z "$value" ]]; then
  value="default"
fi

if [[ "$value" != "default" && "$value" != "dark" && "$value" != "light" ]]; then
  echo "Invalid value: '$value'. Must be 'default', 'dark' or 'light'." >&2
  exit 1
fi

# Configure GTK 3
#gsettings set org.gnome.desktop.interface application-prefer-dark-theme 1
if [[ "$value" == "dark" ]]; then
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
else
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
fi

# Configure GTK 4
# https://wiki.archlinux.org/title/GTK#Dark_theme_variant
if [[ "$value" != "default" ]]; then
  gsettings set org.gnome.desktop.interface color-scheme prefer-$value
else
  gsettings set org.gnome.desktop.interface color-scheme default
fi
