# remove greeting
if status is-interactive
    set fish_greeting
end

set -l os (uname)

if test "$os" = Darwin
    # Homebrew integration
    eval "$(/opt/homebrew/bin/brew shellenv)"
    
    # Add MetalHudEnabler
    fish_add_path $HOME/Games
else if test "$os" = Linux
    # stuff for linux
end

# fix 'clear' command in ssh for ghostty
set -gx TERM xterm-256color

# if test "$TERM_PROGRAM" = ghostty
#     if status is-interactive
#     and not set -q TMUX
#         exec tmux new-session -As home
#     end
# end

# function yy
# 	set tmp (mktemp -t "yazi-cwd.XXXXXX")
# 	yazi $argv --cwd-file="$tmp"
# 	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
# 		cd "$cwd"
# 	end
# 	rm -f -- "$tmp"
# end




set -gx EDITOR nvim
set -g mouse on

alias python "python3"
alias nv "nvim"
alias lg "lazygit"
alias lzd "lazydocker"
# alias cat "bat"
alias fzv 'fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" --bind "enter:become(nvim {})"'
alias fzp "fzf --preview 'fzf-preview.sh {}'"

alias ls='eza'
alias l='eza -lbF --git'
alias la='eza -lbhHigUmuSa --time-style=long-iso --git'

# bat theme
set -x BAT_THEME "base16"

# Use bat for man
set -x MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# Set up fzf
set -x FZF_DEFAULT_COMMAND "fd --type file --strip-cwd-prefix --hidden --follow --exclude .git"

# Generates colors for fd
set -gx LS_COLORS "$(vivid generate ayu)"


######## SDKs

# golang (gobrew)
set -x GOPATH $HOME/.go
fish_add_path $GOPATH

# rust (rustup)
fish_add_path $HOME/.cargo/bin

########

fzf --fish | source
zoxide init --cmd cd fish | source
carapace _carapace | source
starship init fish | source
