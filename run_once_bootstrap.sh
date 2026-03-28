#!/bin/bash
set -e

# ── Xcode CLI Tools ──────────────────────────────────────────────────────────
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  # Wait for installation to complete
  until xcode-select -p &>/dev/null; do sleep 5; done
fi

# ── Homebrew ─────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for the rest of this script (Apple Silicon)
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ── Brew Bundle ───────────────────────────────────────────────────────────────
echo "Installing packages from Brewfile..."
brew bundle install --global --no-lock

# ── Fish shell ────────────────────────────────────────────────────────────────
FISH_PATH="$(command -v fish)"

if ! grep -qF "$FISH_PATH" /etc/shells; then
  echo "Adding fish to /etc/shells..."
  echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

if [ "$SHELL" != "$FISH_PATH" ]; then
  echo "Setting fish as default shell..."
  chsh -s "$FISH_PATH"
fi

# ── Node.js via fnm ───────────────────────────────────────────────────────────
if command -v fnm &>/dev/null; then
  echo "Installing latest Node.js LTS via fnm..."
  fnm install --lts
  fnm default lts-latest
  fnm completions --shell fish > ~/.config/fish/completions/fnm.fish
fi

echo "Bootstrap complete. Open a new terminal to start using fish."
