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
# Set `gtk-application-prefer-dark-theme=true` in the `~/.config/gtk-3.0/settings.ini` file.

if [[ "$value" == "dark" ]]; then
  # If the file doesn't exist, create it.
  if [[ ! -f "$HOME/.config/gtk-3.0/settings.ini" ]]; then
    mkdir -p "$HOME/.config/gtk-3.0"
    echo "[Settings]" > "$HOME/.config/gtk-3.0/settings.ini"
  fi

  # Set the `gtk-application-prefer-dark-theme` key to `true`.
  sed -i -E 's/^gtk-application-prefer-dark-theme=(true|false)$/\gtk-application-prefer-dark-theme=true/' "$HOME/.config/gtk-3.0/settings.ini"

  # If the key doesn't exist, add it.
  if ! grep -q "^gtk-application-prefer-dark-theme=" "$HOME/.config/gtk-3.0/settings.ini"; then
    echo "gtk-application-prefer-dark-theme=true" >> "$HOME/.config/gtk-3.0/settings.ini"
  fi
fi

# It looks like it has been abandoned though
# https://docs.gtk.org/gtk3/property.Settings.gtk-color-scheme.html

if [[ "$value" != "default" ]]; then
  gsettings set org.gnome.desktop.interface color-scheme prefer-$value
else
  gsettings set org.gnome.desktop.interface color-scheme default
fi

# Configure GTK 4
# https://wiki.archlinux.org/title/GTK#Dark_theme_variant

# TODO: Figure out how to set the `prefers-color-scheme` media query to `dark` or `light` in GTK 4.

# Set the flags in the `~/.config/chromium-flags.conf` file.
# https://wiki.archlinux.org/title/Chromium#Dark_mode
# https://bugs.chromium.org/p/chromium/issues/detail?id=998903

# Get the path to the `chromium-flags.conf` file.
chromium_flags_conf="$HOME/.config/chromium-flags.conf"

# Create the file if it doesn't exist.
if [[ ! -f "$chromium_flags_conf" ]]; then
  touch "$chromium_flags_conf"
fi

# Remove the old flags.
sed -i '/^--force-dark-mode/d' "$chromium_flags_conf"
sed -i '/^--enable-features=WebUIDarkMode/d' "$chromium_flags_conf"

# Add the new flags.
if [[ "$value" == "dark" ]]; then
  echo "--force-dark-mode" >> "$chromium_flags_conf"
  echo "--enable-features=WebUIDarkMode" >> "$chromium_flags_conf"
fi
