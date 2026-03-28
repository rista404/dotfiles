#!/bin/bash
set -euo pipefail
trap 'echo "Bootstrap failed at line $LINENO"' ERR

# ── Xcode CLI Tools ──────────────────────────────────────────────────────────
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "A GUI prompt appeared — complete the Xcode installation, then press Enter to continue."
  read -r
fi

# ── Homebrew ─────────────────────────────────────────────────────────────────
# Homebrew is installed by the bootstrap one-liner in the README before this script runs.
# We just need to ensure it's in PATH.
BREW_PREFIX="$([ "$(uname -m)" = "arm64" ] && echo /opt/homebrew || echo /usr/local)"
eval "$("$BREW_PREFIX/bin/brew" shellenv)"

# ── Rust via rustup ──────────────────────────────────────────────────────────
# Must run before brew bundle so cargo packages can be installed
if ! command -v rustup &>/dev/null; then
  echo "Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  source "$HOME/.cargo/env"
fi

# ── Brew Bundle ───────────────────────────────────────────────────────────────
echo "Installing packages from Brewfile..."
brew bundle install --file ~/Brewfile

# ── Fish shell ────────────────────────────────────────────────────────────────
FISH_PATH="$(command -v fish)"

if [ -n "$FISH_PATH" ]; then
  if ! grep -qF "$FISH_PATH" /etc/shells; then
    echo "Adding fish to /etc/shells..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi

  if [ "$SHELL" != "$FISH_PATH" ]; then
    echo "Setting fish as default shell..."
    chsh -s "$FISH_PATH"
  fi
else
  echo "Warning: fish not found, skipping shell setup."
fi

# ── Node.js via fnm ───────────────────────────────────────────────────────────
if command -v fnm &>/dev/null; then
  echo "Installing latest Node.js LTS via fnm..."
  fnm install --lts
  fnm default lts-latest
  mkdir -p ~/.config/fish/completions
  fnm completions --shell fish > ~/.config/fish/completions/fnm.fish
fi

echo "Bootstrap complete. Open a new terminal to start using fish."
