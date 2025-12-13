# dotfiles

## Install dependencies

- [ghostty](https://ghostty.org/): terminal emulator
- [fish](https://fishshell.com/): my shell of choice
- [starship](https://starship.rs/): prompt generator
- [stow](https://www.gnu.org/software/stow/): dotfiles manager
- [git](https://git-scm.com/): version control
- [ripgrep](https://github.com/BurntSushi/ripgrep): search inside files
- [fd](https://github.com/sharkdp/fd): file search
- [vivid](https://github.com/sharkdp/vivid): color generator for ls/fd
- [fzf](https://junegunn.github.io/fzf/): fuzzy finder
- [bat](https://github.com/sharkdp/bat): better cat
- [eza](https://github.com/eza-community/eza): better ls

### MacOS

install [homebrew](https://brew.sh/)

```sh
brew install ghostty fish starship stow git ripgrep fd vivid fzf bat eza gcc
```

### Fedora

add [Terra](https://terra.fyralabs.com/) repo

```sh
sudo dnf install ghostty fish starship stow git ripgrep fd-find fzf bat eza gcc
```

then install [rustup](#rust)

```sh
cargo install vivid
```

### Arch Linux

```sh
sudo pacman -S ghostty fish starship stow git ripgrep fd vivid fzf bat eza gcc
```

```sh
neovim
yazi
tmux
gcc
glow
make
deno
zoxide
lazygit
git-delta
tldr
thefuck
dust https://github.com/bootandy/dust
```

## Change default shell to Fish

```sh
chsh -s $(which fish)
```

## Install dotfiles

```sh
git clone https://github.com/lomraig/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow .
```

## Install SDKs

### rust

use [rustup](https://rustup.rs/)
