# Fish setup
# 1. > brew install fish
# 2. > curl -L https://get.oh-my.fish | fish
# 3. > omf install chain
# 4. > omf install https://github.com/jhillyerd/plugin-git
# 5. https://starship.rs/guide/#🚀-installation
# 6. Update `~/.config/fish/config.fish`

# User configuration

set -xU EDITOR "code -w"
alias ggpull="ggl"
alias ggpush="ggp"
abbr -a gcmsg git commit -m
abbr -a l ls -la
abbr c code .
abbr yd yarn dev
abbr gr go run .
abbr vpr gh pr view

# https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/14
set -xU LC_ALL "en_US.UTF-8"

# Welcome message

function fish_greeting
	# fortune -a
	# docker info >/dev/null 2>&1; and echo "🐳 docker is running!"
	# echo "✳️  node "(node --version)
	# echo "🔷 "(go version)
	# echo "🔋 Battery at "(battery -p -e)
end

funcsave fish_greeting

# bat, alternative to cat
set -xU BAT_THEME "TwoDark"
alias cat="bat"

# Postgres.app
set -x PATH $PATH /Applications/Postgres.app/Contents/Versions/latest/bin

# Rust
set -x PATH $PATH $HOME/.cargo/bin

# Yarn
set -x PATH $PATH $HOME/.yarn/bin $HOME/.config/yarn/global/node_modules/.bin

# Deno
set -x PATH $PATH /Users/rista/.deno/bin

# Calibre
set -x PATH $PATH /Applications/Calibre.app/Contents/MacOS

# Go
set -xU GOPATH $HOME/Projects/go
set -x PATH $PATH $GOPATH/bin/
set -xU GO111MODULE "on"

# Directory aliases

abbr amo cd "~/Projects/amondo/"
abbr amom cd "~/Projects/amondo/amondo-monorepo/"
abbr amod cd "~/Projects/amondo/dash/"
abbr amog cd "~/Projects/amondo/amondo-graphql-api/"
abbr cirk cd "~/Projects/golang/cirkusfera/"

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
	cp -fR ~/.vim/colors ./.vim/
	brew bundle dump --force
	cp ~/.vimrc .
	cp ~/.config/fish/config.fish .
	cp ~/.config/starship.toml .
	cp ~/Library/Application\ Support/Code/User/settings.json . && mv settings.json vscode_settings.json
	cp ~/Library/Application\ Support/Code/User/keybindings.json . && mv keybindings.json vscode_keybindings.json
end

function jira
	open (string join "" "https://amondo.atlassian.net/browse/" $argv)
end

# Github helpers

function curr_git_branch
	git branch ^/dev/null | grep \* | sed 's/* //'
end

function ghurl
	set repo (git remote get-url origin | cut -d':' -f2 | cut -d'.' -f1)
	echo https://github.com/$repo
end

function ghr
	open (ghurl)
end

function ghms
	open (ghurl)/milestones
end

function ghpr
	open (ghurl)/pulls
end

function ghis
	open (ghurl)/issues
end

function ghisn
	open (ghurl)/issues/new
end

function ghnpr
	open (ghurl)/pull/new/(string escape --style=url (curr_git_branch))
end

starship init fish | source