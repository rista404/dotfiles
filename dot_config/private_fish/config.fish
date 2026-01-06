#
# Fish setup
#
# 1. > brew install fish
# 2. set fish as a shell and set to default shell
# 3. install manually https://github.com/jhillyerd/plugin-git
#    git clone git@github.com:jhillyerd/plugin-git.git
#    cd plugin-git/
#    cp -r ./functions/ ~/.config/fish/functions/
#    cp -r ./conf.d/ ~/.config/fish/conf.d/
# 4. https://starship.rs/
# 5. Update `~/.config/fish/config.fish`
#


#
# Keybindings
#

# remove word instead of argument on alt-backspace
bind alt-backspace backward-kill-word


#
# User configuration
#

set -xU ADBLOCK 1
set -xU DO_NOT_TRACK 1
set -xU EDITOR "zed -w"

# editor shortcuts
abbr c code .
abbr z zed .

# git helpers
__git.init
abbr -a gcmsg git commit -m
abbr -a ggcpp git push commonprefix (__git.current_branch)

# gh helpers
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

# eza, alternative to ls
alias ls="eza"


#
# PATH configuration
#

# Homebrew
fish_add_path /opt/homebrew/bin

# Postgres.app
fish_add_path /Applications/Postgres.app/Contents/Versions/latest/bin

# Rust
fish_add_path ~/.cargo/bin

# Calibre
fish_add_path /Applications/Calibre.app/Contents/MacOS

# Go
set -xU GOPATH $HOME/Projects/go
fish_add_path $GOPATH/bin/

# Foundry
fish_add_path -a $HOME/.foundry/bin

# risc0
fish_add_path $HOME/.risc0/bin

# sp1
fish_add_path $HOME/.sp1/bin

# Solana
fish_add_path $HOME/.local/share/solana/install/active_release/bin

# llvm
fish_add_path /opt/homebrew/opt/llvm/bin
set -gx LIBCLANG_PATH /opt/homebrew/opt/llvm/lib
set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

# librocksdb-sys fix
set -gx DYLD_FALLBACK_LIBRARY_PATH /opt/homebrew/opt/llvm/lib

# Solana C libs fix
set -gx CPATH /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include

# amp
fish_add_path ~/.local/bin

# fnm
# fnm install 23.7.0
# fnm default 23.7.0
# fnm completions --shell fish | tee ~/.config/fish/completions/fnm.fish
fnm env --shell fish | source


#
# Misc
#

alias rm="echo Use 'trash', or the full path '/bin/rm'"

abbr -a l ls -la
abbr -a lgt ls -la --git --tree

function ip
    ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
end

function take
    mkdir -p $argv && cd $argv
end

function eyeson
    if test (count $argv) -eq 0
        echo "Usage: eyeson <your-command>"
        return 1
    end
    clear
    while true
        tput cup 0 0
        eval (string join ' ' $argv)
        sleep 1
    end
end

# Bitcoin
abbr -a btcmb 'bitcoin-cli generatetoaddress 1 "$(bitcoin-cli -rpcwallet=default getnewaddress)"'

#
# Starship
#

set -g STARSHIP_CONFIG_DEF ~/.config/starship/starship.toml
set -g STARSHIP_CONFIG_ZEN ~/.config/starship/starship-zen.toml
set -x STARSHIP_CONFIG $STARSHIP_CONFIG_DEF

alias ssdef "set -x STARSHIP_CONFIG $STARSHIP_CONFIG_DEF"
alias sszen "set -x STARSHIP_CONFIG $STARSHIP_CONFIG_ZEN"

starship init fish | source
