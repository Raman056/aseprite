#!/usr/bin/env bash
set -e

APP_NAME="aseprite"
INSTALL_DIR="$HOME/.local/share/$APP_NAME"
BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"

echo "Installing $APP_NAME to $INSTALL_DIR ..."
mkdir -p "$INSTALL_DIR" "$BIN_DIR" "$DESKTOP_DIR"

ARCHIVE_LINE=$(awk '/^__PAYLOAD_BELOW__/ {print NR + 1; exit 0}' "$0")
tail -n +"$ARCHIVE_LINE" "$0" | tar xz -C "$INSTALL_DIR"

chmod +x "$INSTALL_DIR/aseprite"
ln -sf "$INSTALL_DIR/aseprite" "$BIN_DIR/aseprite"

cat > "$DESKTOP_DIR/aseprite.desktop" << DESKTOP
[Desktop Entry]
Name=Aseprite
Comment=Animated sprite editor & pixel art tool
Exec=$BIN_DIR/aseprite %f
Terminal=false
Type=Application
Categories=Graphics;2DGraphics;RasterGraphics;
DESKTOP

echo ""
echo "Done."
echo "Make sure \$HOME/.local/bin is in your PATH (add to ~/.bashrc or ~/.zshrc if not):"
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
echo "Launch it from your Hyprland launcher (wofi/rofi/fuzzel) as 'Aseprite', or run 'aseprite' in a terminal."

exit 0
__PAYLOAD_BELOW__
