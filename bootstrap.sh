#!/bin/bash
set -euo pipefail
trap 'echo "Bootstrap failed at line $LINENO"' ERR

# ── Homebrew ──────────────────────────────────────────────────────────────────
BREW_PREFIX="$([ "$(uname -m)" = "arm64" ] && echo /opt/homebrew || echo /usr/local)"

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$("$BREW_PREFIX/bin/brew" shellenv)"

# ── GPG + YubiKey ─────────────────────────────────────────────────────────────
brew install gnupg

echo "Importing GPG public key from GitHub..."
curl -fsSL https://github.com/rista404.gpg -o /tmp/rista404.gpg
gpg --import /tmp/rista404.gpg
rm /tmp/rista404.gpg

echo "Make sure your YubiKey is plugged in, then press Enter..."
read -r < /dev/tty
gpg --card-status < /dev/tty

# ── SSH key ───────────────────────────────────────────────────────────────────
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "Generating SSH key..."
  ssh-keygen -t ed25519 -C "$(hostname)" < /dev/tty
  ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519"
fi

echo ""
echo "Add this SSH key to GitHub (https://github.com/settings/ssh/new), then press Enter:"
echo ""
cat "$HOME/.ssh/id_ed25519.pub"
echo ""
read -r < /dev/tty

# ── chezmoi ───────────────────────────────────────────────────────────────────
gpgconf --kill all
export GPG_TTY=/dev/tty

brew install chezmoi
chezmoi init --apply rista404
