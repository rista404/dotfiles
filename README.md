## dotfiles

managed by [chezmoi](https://www.chezmoi.io/).

## New machine setup

1. Set your machine name first:

```sh
sudo scutil --set HostName your-macbook-name
sudo scutil --set LocalHostName your-macbook-name
sudo scutil --set ComputerName your-macbook-name
```

2. Run:

```sh
curl -fsSL https://raw.githubusercontent.com/rista404/dotfiles/main/bootstrap.sh | bash
```

This will:
- Install Homebrew and gnupg
- Import your GPG public key from GitHub
- Prompt you to plug in your YubiKey
- Generate a new SSH key and pause so you can add it to GitHub
- Install chezmoi and apply all dotfiles
- Run the post-install script (brew bundle, fish shell, rust, node)
