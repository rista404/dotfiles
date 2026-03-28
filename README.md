# dotfiles

managed by [chezmoi](https://www.chezmoi.io/).

## New machine setup

Run these steps in order.

### 1. Set machine name

```sh
sudo scutil --set HostName your-macbook-name
sudo scutil --set LocalHostName your-macbook-name  # no .local suffix
sudo scutil --set ComputerName your-macbook-name
```

### 2. Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 3. Install dependencies

```sh
brew install gnupg chezmoi
```

### 4. Import GPG key and connect YubiKey

Plug in your YubiKey, then:

```sh
curl -fsSL https://github.com/rista404.gpg -o /tmp/rista404.gpg
gpg --import /tmp/rista404.gpg
rm /tmp/rista404.gpg
# Disable macOS smart card daemon conflict
sudo defaults write /Library/Preferences/com.apple.security.smartcard DisabledTokens -array com.apple.CryptoTokenKit.AppleSmartCardToken
gpgconf --kill all
export GPG_TTY=/dev/tty
gpg --card-status
```

### 5. Generate SSH key

```sh
ssh-keygen -t ed25519 -C "$(hostname)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

Add the printed key to [GitHub SSH keys](https://github.com/settings/ssh/new).

### 6. Apply dotfiles

```sh
chezmoi init --apply rista404
```

This clones the repo and applies all dotfiles. It will also run the post-install script which installs all packages from Brewfile, sets fish as default shell, installs Rust and Node.js.
