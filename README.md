# dotfiles

## dependencies

- [ghostty](https://ghostty.org/): terminal emulator
- [fish](https://fishshell.com/): shell
- [starship](https://starship.rs/): prompt generator
- [stow](https://www.gnu.org/software/stow/): dotfiles manager
- [git](https://git-scm.com/): version control
- [ripgrep](https://github.com/BurntSushi/ripgrep): search inside files
- [fd](https://github.com/sharkdp/fd): file search
- [fzf](https://junegunn.github.io/fzf/): fuzzy finder
- [bat](https://github.com/sharkdp/bat): better cat
- [eza](https://github.com/eza-community/eza): better ls
- [neovim](https://neovim.io/) 0.12.0+ is required: the best text editor
- [make](https://www.gnu.org/software/make/): is required to compile [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) plugin for neovim
- [gum](https://github.com/charmbracelet/gum), [terminal-notifier](https://github.com/julienXX/terminal-notifier) and [timer](https://github.com/caarlos0/timer): [pom](https://gist.github.com/bashbunni/e311f07e100d51a883ab0414b46755fa) dependencies

TODO add update my system script

### macos

- installs [homebrew](https://brew.sh/)

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # installs homebrew

brew install ghostty fish make starship stow git ripgrep fd fzf bat eza gcc neovim jq caarlos0/tap/timer terminal-notifier go lua-language-server pipx
```

### opensuse

```sh
sudo zypper install ghostty fish make starship stow git ripgrep fd fzf bat eza gcc neovim jq $(curl -s https://api.github.com/repos/caarlos0/timer/releases/latest | jq -r --arg arch "$(uname -m)" '.assets[] | select(.name | endswith($arch + ".rpm")) | .browser_download_url') go lua-language-server python-pipx
```

```sh
yazi
tmux
zoxide
delta
glow
lazygit
lazydocker
git-delta
tldr
thefuck
jq
dust https://github.com/bootandy/dust
aerospace
sketchybar
```

## install dotfiles

```sh
chsh -s $(which fish)
git clone https://github.com/lomraig/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow .
```

## install language servers, formatters and linters

```sh
go install golang.org/x/tools/gopls@latest github.com/golangci/golangci-lint/cmd/golangci-lint@latest golang.org/x/tools/cmd/goimports@latest github.com/charmbracelet/gum@latest
pipx install ruff
pipx install basedpyright
```
