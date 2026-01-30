# remove greeting
if status is-interactive
    set fish_greeting
end

set -l os (uname)

if test "$os" = Darwin
    # Homebrew integration
    eval "$(/opt/homebrew/bin/brew shellenv)"
else if test "$os" = Linux
    # stuff for linux
end

# fish_add_path "~/.local/bin"
# register-python-argcomplete --shell fish pipx >~/.config/fish/completions/pipx.fish

fish_add_path $HOME/.cargo/bin

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
alias pip "pip3"

alias nv "nvim"
alias lg "lazygit"
alias lzd "lazydocker"
alias cat "bat"

alias fzv 'fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" --bind "enter:become(nvim {})"'
alias fzp "fzf --preview 'fzf-preview.sh {}'"

alias ls 'eza'
alias l 'eza -lbF --git'
alias la 'eza -lbhHigUmuSa --time-style=long-iso --git'

set -x BAT_THEME "oxocarbon-dark"

# Use bat for man
set -x MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# Set up fzf
set -x FZF_DEFAULT_COMMAND "fd --type file --strip-cwd-prefix --hidden --follow --exclude .git"
set -x FZF_DEFAULT_OPTS {$FZF_DEFAULT_OPTS}' --color=fg:#ffffff,bg:#161616,hl:#08bdba --color=fg+:#f2f4f8,bg+:#262626,hl+:#3ddbd9 --color=info:#78a9ff,prompt:#33b1ff,pointer:#42be65 --color=marker:#ee5396,spinner:#ff7eb6,header:#be95ff'

######## SDKs

# golang
set -x GOPATH $HOME/.go
fish_add_path $GOPATH

########

fzf --fish | source
zoxide init --cmd cd fish | source
starship init fish | source
