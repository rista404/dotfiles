# Fish setup
# 1. > brew install fish
# 2. set fish as a shell and set to default shell
# 3. install manually https://github.com/jhillyerd/plugin-git
 # git clone git@github.com:jhillyerd/plugin-git.git
 # cd plugin-git/
 # cp -r ./functions/ ~/.config/fish/functions/
 # cp -r ./conf.d/ ~/.config/fish/conf.d/
# 4. https://starship.rs/
# 5. Update `~/.config/fish/config.fish`

# User configuration

set -xU DO_NOT_TRACK 1
set -xU EDITOR "zed -w"
abbr ggpull git pull origin \(__git.current_branch\)
abbr ggpush git push origin \(__git.current_branch\)
abbr -a gcmsg git commit -m
abbr -a l ls -la
abbr c code .
abbr z zed .
abbr gwr gh repo view -w
abbr ghwpr gh pr view -w
abbr ghnpr gh pr create -w
abbr ghpdd gh pr create -w -B main -H dev -t \"Production deploy \"(date +%d.%m.%Y)

set -g fish_greeting

# https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/14
set -xU LC_ALL "en_US.UTF-8"

set -xU DISABLE_OPENCOLLECTIVE 1
set -xU ADBLOCK 1

# bat, alternative to cat
set -xU BAT_THEME "TwoDark"
alias cat="bat"

# Homebrew
set -x PATH $PATH /opt/homebrew/bin

# Postgres.app
set -x PATH $PATH /Applications/Postgres.app/Contents/Versions/latest/bin

# Rust
set -x PATH $PATH $HOME/.cargo/bin

# Calibre
set -x PATH $PATH /Applications/Calibre.app/Contents/MacOS

# Go
set -xU GOPATH $HOME/Projects/go
set -x PATH $PATH $GOPATH/bin/
set -xU GO111MODULE "on"

# fnm
# fnm install 23.7.0
# fnm default 23.7.0
# fnm completions --shell fish | tee ~/.config/fish/completions/fnm.fish
fnm env --shell fish | source

# Directory aliases

#
# Misc
#

function ip
	ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
end

function take
	mkdir -p $argv && cd $argv
end

function update_dotfiles
	cp ~/.gitconfig .
	brew bundle dump --force
	cp ~/.config/fish/config.fish .
	cp ~/.config/zed/keymap.json ./zed/keymap.json
	cp ~/.config/zed/settings.json ./zed/settings.json
	cp ~/.config/starship.toml .
end

starship init fish | source
