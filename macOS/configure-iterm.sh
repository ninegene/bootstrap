#!/bin/bash
set -eo pipefail

THEME_DIR="$HOME/src/iterm-dracula-dark-theme"

echo "Configuring iTerm2..."

if [ -d "$THEME_DIR/.git" ]; then
    echo "Updating Dracula theme repo..."
    git -C "$THEME_DIR" pull --ff-only
else
    echo "Cloning Dracula theme repo..."
    mkdir -p "$(dirname "$THEME_DIR")"
    git clone https://github.com/ninegene/iterm-dracula-dark-theme "$THEME_DIR"
fi

echo "Installing Cascadia Code..."
brew install --cask font-cascadia-code

cat <<EOF

iTerm2 setup steps:
1. Open iTerm2 and go to Settings > Profiles > Colors.
2. Click Color Presets... > Import... and choose:
   $THEME_DIR/Dracula.itermcolors
3. In Profiles > Text, set the font to Cascadia Code.
4. If the font does not appear immediately, quit and reopen iTerm2.

EOF

echo "iTerm2 configuration completed."
