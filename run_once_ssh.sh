#!/bin/bash
set -e

KEY="$HOME/.ssh/id_ed25519"

if [ -f "$KEY" ]; then
  echo "SSH key already exists at $KEY, skipping."
  exit 0
fi

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

echo ""
echo "Generating new SSH key..."
echo "You'll be prompted for a passphrase — use a strong one, macOS Keychain will remember it."
echo ""

ssh-keygen -t ed25519 -C "$(hostname)" -f "$KEY"

# Add to macOS Keychain and ssh-agent
ssh-add --apple-use-keychain "$KEY"

echo ""
echo "Your public key (add this to GitHub → Settings → SSH keys):"
echo ""
cat "$KEY.pub"
echo ""
