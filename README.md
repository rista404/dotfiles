## dotfiles

managed by [chezmoi](https://www.chezmoi.io/).

## New machine setup

1. Set your machine name first:

```sh
sudo scutil --set HostName your-macbook-name
sudo scutil --set LocalHostName your-macbook-name
sudo scutil --set ComputerName your-macbook-name
```

2. Make sure your YubiKey is plugged in (needed to decrypt secrets during apply)
3. Run:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
  && eval "$(/opt/homebrew/bin/brew shellenv)" \
  && brew install chezmoi gnupg \
  && gpg --card-status \
  && chezmoi init --apply rista404
```

This will:
- Install Homebrew, chezmoi, and gnupg (gnupg needed to decrypt secrets before the bootstrap script runs)
- Clone this repo, apply all dotfiles, and run the bootstrap script
- Bootstrap script installs all packages from Brewfile and sets fish as default shell
