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

fish_add_path $HOME/.cargo/bin

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

# fix 'clear' command in ssh for ghostty
set -gx TERM xterm-256color

alias python "python3"
alias pip "pip3"

alias nv "nvim"
alias lg "lazygit"
alias lzd "lazydocker"
alias cat "bat"

alias fzv 'fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" --bind "enter:become(nvim {})"'

alias ls 'eza'
alias l 'eza -lbF --git'
alias la 'eza -lbhHigUmuSa --time-style=long-iso --git'

set -x BAT_THEME "oxocarbon-dark"

# Use bat for man
set -gx MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

################################################## Set up fzf ##################################################

set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:#ffffff,bg:#161616,hl:#08bdba --color=fg+:#f2f4f8,bg+:#262626,hl+:#3ddbd9 --color=info:#78a9ff,prompt:#33b1ff,pointer:#42be65 --color=marker:#ee5396,spinner:#ff7eb6,header:#be95ff"

function ff
    fd --hidden --follow --exclude .git --color=always \
    | fzf --ansi \
        --header "Search Files > " \
        --preview 'bat --style=numbers --color=always {}' \
        --preview-window '~3' \
        --bind 'enter:execute(nvim {})'
end

# firstly load serach results into ram and then search
function fc
    rg --column --line-number --no-heading --color=never --smart-case \
       --hidden \
       --glob '!.git' \
       --glob '!node_modules' \
       --glob '!venv' \
       --glob '!target' \
       --glob '!dist' \
       -- '' \
    | fzf --ansi \
        --delimiter : \
        --nth 4.. \
        --header "Search Content > " \
        --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
        --preview-window '~3,+{2}+3/3' \
        --bind 'enter:execute(nvim {1} +{2})'
end

# search on every type
function fcl
    set RG_PREFIX "rg --column --line-number --no-heading --color=never --smart-case --hidden --glob '!.git' --glob '!node_modules' --glob '!venv' --glob '!target' --glob '!dist'"

    fzf --disabled --ansi \
        --bind "start:reload:$RG_PREFIX -- ''" \
        --bind "change:reload:$RG_PREFIX -- {q} || true" \
        --delimiter : \
        --header "Search Content (Live) > " \
        --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
        --preview-window '~3,+{2}+3/3' \
        --bind 'enter:execute(nvim {1} +{2})'
end

################################################## PATHs ##################################################

# golang
set -x GOPATH $HOME/.go
fish_add_path $GOPATH

# fish_add_path "~/.local/bin"
# register-python-argcomplete --shell fish pipx >~/.config/fish/completions/pipx.fish

################################################## Some stuff ##################################################

fzf --fish | source
zoxide init --cmd cd fish | source
starship init fish | source
