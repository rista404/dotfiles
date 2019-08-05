# Fish setup
# 1. > brew install fish
# 2. > curl -L https://get.oh-my.fish | fish
# 3. > omf install chain
# 4. > omf install https://github.com/jhillyerd/plugin-git
# 5. > brew install fortune
# 6. Update `~/.config/fish/config.fish`

# User configuration

set -xU EDITOR "code -w"
alias ggpull="ggl"
alias ggpush="ggp"
abbr -a gcmsg git commit -m
abbr -a l ls -la

# Alias vim to mvim

alias vim="mvim"

# Welcome message

function fish_greeting
	fortune -a
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

# Go
set -xU GOPATH $HOME/Projects/go
set -x PATH $PATH $GOPATH/bin/
set -xU GO111MODULE "on"

# Racket/Scheme
set -x PATH $PATH /Applications/Racket\ v7.3/bin
# alias scheme="csi" # Chicken Interpreter

# Tiny Care Dashboard
alias dash="tiny-care-terminal"
set -xU TTC_BOTS 'poem_exe,tinycarebot,magicrealismbot'
set -xU TTC_SAY_BOX "parrot"
set -xU TTC_REPOS "/Users/rista/Projects/amondo/curation-dashboard,/Users/rista/Projects/amondo/amondo-front-monorepo,/Users/rista/Projects/amondo/relay.amondo.com,/Users/rista/Projects/amondo/amondo-graphql-api,/Users/rista/Projects/amondo/dash3,/Users/rista/Projects/amondo/amondo-monorepo"
set -xU TTC_WEATHER "Belgrade"
set -xU TTC_APIKEYS false
set -xU TTC_POMODORO 25
set -xU TTC_BREAK 5

# Directory aliases

abbr amo cd "~/Projects/amondo"
abbr gosrc cd "$GOPATH/src/github.com/rista404"

#
# Misc
#

function ip
	ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
end

function wthr
	curl -4 wttr.in/Belgrade
end

function take
	mkdir -p $argv && cd $argv
end

set googleSearch "https://www.google.com/search?q="

function google
	open -a $chrome (string join "" $googleSearch $argv)
end

function update_dotfiles
	cp ~/.gitconfig .
	cp -fR ~/.vim/colors ./.vim/
	brew bundle dump --force
	cp ~/.vimrc .
	cp ~/.config/fish/config.fish .
	cp ~/Library/Application\ Support/Code/User/settings.json . && mv settings.json vscode_settings.json
	cp ~/Library/Application\ Support/Code/User/keybindings.json . && mv keybindings.json vscode_keybindings.json
end

# Heroku Docker Up
# Creates a heroku docker app, and populates heroku.yml manifest file
function hdup
	if "$1" != ""
		heroku apps:create $1 --region eu -s container
		echo "build:\n  docker:\n    web: Dockerfile" > heroku.yml
		touch Dockerfile
	else
		echo "Please provide an app name."
	end
end

# Github helpers

function curr_git_branch
	git branch ^/dev/null | grep \* | sed 's/* //'
end

set chrome "/Applications/Google Chrome.app"

function ghurl
	set repo (git remote get-url origin | cut -d':' -f2 | cut -d'.' -f1)
	echo https://github.com/$repo
end

function gh
	open (ghurl)
end

function ghms
	open -a $chrome (ghurl)/milestones
end

function ghpr
	open -a $chrome (ghurl)/pulls
end

function ghis
	open -a $chrome (ghurl)/issues
end

function ghisn
	open -a $chrome (ghurl)/issues/new
end

function ghnpr
	open -a $chrome (ghurl)/pull/new/(curr_git_branch)
end
