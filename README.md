# dotfiles

## Install dependencies

- [ghostty](https://ghostty.org/): Terminal Emulator
- [fish](https://fishshell.com/): Shell
- [starship](https://starship.rs/): Custom prompt
- [stow](https://www.gnu.org/software/stow/): dotfiles manager
- [git](https://git-scm.com/): Version Control
- [ripgrep](https://github.com/BurntSushi/ripgrep): Search inside files
- [fd](https://github.com/sharkdp/fd): File search
- [vivid](https://github.com/sharkdp/vivid): color generator for ls/fd
- [fzf](https://junegunn.github.io/fzf/): fuzzy finder
- [bat](https://github.com/sharkdp/bat): better cat
- [eza](https://github.com/eza-community/eza): better ls

### MacOS

install [homebrew](https://brew.sh/)

```sh
brew install ghostty fish starship stow git ripgrep fd vivid fzf bat eza
```

### Arch Linux

```sh
sudo pacman -S ghostty fish starship stow git ripgrep fd vivid fzf bat eza
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
echo /usr/local/bin/fish | sudo tee -a /etc/shells

chsh -s /usr/local/bin/fish
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
