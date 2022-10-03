#!/usr/bin/env bash

# This script is used to set the `prefers-color-scheme` media query
# to the value of the `PREFERS_COLOR_SCHEME` environment variable.

# Get the value from the argument or the environment variable.
if [[ -z "$1" ]]; then
  value="$PREFERS_COLOR_SCHEME"
else
  value="$1"
fi

# Check that the value is either "dark" or "light".
if [[ "$value" != "dark" && "$value" != "light" ]]; then
  echo "Invalid value: $value"
  exit 1
fi

# Configure GTK 3
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-$value"

# Configure GTK 4
# https://wiki.archlinux.org/title/GTK#Dark_theme_variant
gsettings set org.gnome.desktop.interface color-scheme prefer-$value
