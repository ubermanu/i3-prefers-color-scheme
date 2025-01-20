#!/usr/bin/env bash

set -eu

SCRIPT_URL="https://raw.githubusercontent.com/ubermanu/i3-prefers-color-scheme/main/prefers-color-scheme.bash"
DESTINATION_PATH="$HOME/.local/bin/i3-prefers-color-scheme"

# Check if curl is installed
if ! command -v curl &> /dev/null; then
  echo "Error: 'curl' is not installed. Please install 'curl' and try again."
  exit 1
fi

if curl -s -o "$DESTINATION_PATH" "$SCRIPT_URL"; then
  chmod +x "$DESTINATION_PATH"
  echo "🎉 i3-prefers-color-scheme script installed in $DESTINATION_PATH"
else
  echo "Failed to download and install the i3-prefers-color-scheme script."
fi
