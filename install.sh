#!/usr/bin/env bash
# termainal installer: curl -fsSL https://raw.githubusercontent.com/Ezmanw/termainal/main/install.sh | bash
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/Ezmanw/termainal/main"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"

say() { printf '\033[1;36m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*"; }

command -v python3 >/dev/null 2>&1 || { echo "termainal needs python3. Install it first (e.g. sudo apt install python3)." >&2; exit 1; }

mkdir -p "$BIN_DIR"
say "Downloading termainal to $BIN_DIR/termainal"
curl -fsSL "$REPO_RAW/termainal" -o "$BIN_DIR/termainal"
chmod +x "$BIN_DIR/termainal"

if ! command -v ollama >/dev/null 2>&1; then
  warn "Ollama isn't installed. Get it with:"
  echo "    curl -fsSL https://ollama.com/install.sh | sh"
  echo "    ollama pull qwen2.5:3b"
fi

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) warn "$BIN_DIR is not on your PATH. Add this to your ~/.bashrc:"
     echo "    export PATH=\"$BIN_DIR:\$PATH\"" ;;
esac

say "Done! Run: termainal"
