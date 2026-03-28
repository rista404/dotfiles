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
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply rista404
```

This will:
- Install chezmoi via its own installer
- Clone this repo, apply all dotfiles, and run the bootstrap script
- Bootstrap script installs Homebrew, all packages from Brewfile (including chezmoi itself, taking over from the curl install), and sets fish as default shell
