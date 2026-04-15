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
- [neovim](https://neovim.io/): text editor
- [make](https://www.gnu.org/software/make/): is required to compile [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) plugin for neovim
- [gum](https://github.com/charmbracelet/gum), [terminal-notifier](https://github.com/julienXX/terminal-notifier) and [timer](https://github.com/caarlos0/timer): [pom](https://gist.github.com/bashbunni/e311f07e100d51a883ab0414b46755fa) dependencies

### macos

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # installs homebrew

brew install ghostty fish make starship stow git ripgrep fd fzf bat eza gcc neovim caarlos0/tap/timer terminal-notifier
```

```sh
// TODO
tmux
zoxide
delta
glow
faker
lazygit
lazydocker
delta
tldr
thefuck
jq
dust https://github.com/bootandy/dust
```

## install dotfiles

```sh
chsh -s $(which fish)
git clone https://github.com/lomraig/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow .
bat cache --build
```

## install language runtimes/compiles/pacmans

```sh
# macos
brew install go typst rust uv node oven-sh/bun/bun
```

## install language servers, formatters and linters

```sh
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/charmbracelet/gum@latest

# macos
brew install marksman typstyle prettier markdownlint-cli lua-language-server stylua clang-format ruff basedpyright
```

## hide last login message on terminal startup on macos

```
touch ~/.hushlogin
```
