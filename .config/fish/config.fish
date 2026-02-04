# remove greeting
if status is-interactive
    set fish_greeting
end

set -l os (uname)

if test "$os" = Darwin
    eval "$(/opt/homebrew/bin/brew shellenv)"
else if test "$os" = Linux
    # stuff for linux
end

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

################################################## Some Colors ##################################################

set -gx BAT_THEME "xcode-light"
set -gx LS_COLORS "di=1;34:ln=36:ex=1;32:fi=0:mi=31:pi=33:so=35:bd=33;01:cd=33;01:or=31:ow=34;42"

if type -q eza
    alias ls='eza --icons --group-directories-first --color=always'
    alias la='eza -a --icons --group-directories-first'
    alias ll='eza -lh --icons --group-directories-first --git'
    alias lla='eza -la --icons --group-directories-first --git'
    alias lt='eza --tree --level=2 --icons'
else
    alias ls='ls -G'
    alias la='ls -aG'
    alias ll='ls -lhG'
    alias lla='ls -laG'

    if type -q tree
        alias lt='tree -C -L 2'
    else
        alias lt='find . -maxdepth 2 -not -path "*/.*"'
    end
end

# Use bat for man
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -U fish_color_normal normal
set -U fish_color_command 9b2393 --bold   
set -U fish_color_keyword 9b2393 --bold   
set -U fish_color_quote c41a16             
set -U fish_color_redirection 326d74       
set -U fish_color_end 5d6c79              
set -U fish_color_error ff0000
set -U fish_color_param 000000          
set -U fish_color_comment 5d6c79           
set -U fish_color_selection --background=b2d7ff
set -U fish_color_search_match --background=b2d7ff
set -U fish_color_operator 326d74
set -U fish_color_escape 1c00cf
set -U fish_color_autosuggestion 5d6c79 --italics

################################################## Setup fzf ##################################################

set -gx FZF_DEFAULT_OPTS '--color=light --color=fg:#000000,bg:#ffffff,hl:#9b2393 --color=fg+:#000000,bg+:#f4f4f4,hl+:#9b2393 --color=info:#5d6c79,prompt:#1c00cf,pointer:#1c00cf --color=marker:#c41a16,spinner:#326d74,header:#5d6c79'

function ff
    fd --hidden --follow --exclude .git --color=always \
    | fzf --ansi \
        --header "Search Files > " \
        --preview 'bat --style=numbers --color=always {}' \
        --preview-window '~3' \
        --bind 'enter:execute(nvim {})'
end

# firstly loads serach results into ram and then searches
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

# searches on every type
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

################################################## Functions ##################################################

function pom
    set split $POMO_SPLIT
    if ! test -n "$split"
        set split $(gum choose "25/5" "50/10" "all done" --header "Choose a pomodoro split.")
    end

    switch $split
        case 25/5
            set work 25m
            set break 5m
        case 50/10
            set work 50m
            set break 10m
        case 'all done'
            return
    end

    timer $work && terminal-notifier -message Pomodoro \
        -title 'Work Timer is up! Take a Break 😊' \
        -sound Crystal

    gum confirm "Ready for a break?" && timer $break && terminal-notifier -message Pomodoro \
            -title 'Break is over! Get back to work 😬' \
        -sound Crystal \
        || pom
end

################################################## PATHs ##################################################

set -x GOPATH $HOME/.go
fish_add_path $GOPATH/bin

fish_add_path $HOME/.cargo/bin

# fish_add_path "~/.local/bin"
# register-python-argcomplete --shell fish pipx >~/.config/fish/completions/pipx.fish

################################################## Some stuff ##################################################

fzf --fish | source
zoxide init --cmd cd fish | source
starship init fish | source
