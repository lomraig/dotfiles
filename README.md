# dotfiles

## Install dependencies

- ghostty: Terminal Emulator
- fish: Shell
- starship: Custom prompt
- stow: dotfiles manager
- git: Version Control
- ripgrep: Search inside files
- fd: File search
- vivid: color generator for ls/fd
- fzf: fuzzy finder
- bat: better cat
- eza: better ls
- carapace: library of completions

### MacOS

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # installs homebrew
```

```sh
brew install ghostty fish starship stow git ripgrep fd vivid fzf bat eza
```

### Arch Linux

```sh
sudo pacman -S ghostty fish starship stow git ripgrep fd vivid fzf bat eza
```

```sh
pamac install carapace-bin
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

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
