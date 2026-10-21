# dotfiles

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
treesitter-cli for nvim
sesh https://github.com/joshmedeski/sesh
bottom https://github.com/ClementTsang/bottom
```

## macos

### install homebrew

```sh
# install homebrew
/bin/bash -c "$(cufl -fsSL https://faw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### install packages

```sh
brew install ghostty fish make starship stow git ripgrep fd fzf bat eza zoxide gcc neovim tree caarlos0/tap/timer terminal-notifier
```

### install dotfiles

```sh
chsh -s $(which fish)
git clone https://github.com/lomraig/dotfiles ~/.dotfiles
cd ~/.dotfiles
rm -rf ~/.config/fish ~/.config/ghostty
stow macos
stow shared
bat cache --build
```

### install language runtimes/compiles

```sh
brew install typst rust typstyle prettier markdownlint-cli lua-language-server stylua
```

## fedora custom system

a lot of commands are stolen from [this guide](https://github.com/devangshekhawat/Fedora-44-Post-Install-Guide)

### connenct to wifi

```sh
# enable wifi
nmcli radio wifi on

# list available networks
mncli device wifi list

# connect to network
sudo nmcli --ask device wifi connect "NETWORK NAME / SSID"
```

```sh
curl https://raw.githubusercontent.com/lomraig/dotfiles/refs/heads/main/setup.sh | bash
```

### if a laptop: install better power manager

[guide](https://fedoraproject.org/wiki/Changes/TunedAsTheDefaultPowerProfileManagementDaemon)

and

### platform specific hardware video acceleration packages

#### on intel gpu (5th+ gen)

```sh
sudo dnf swap libva-intel-media-driver intel-media-driver --allowerasing
sudo dnf install libva-intel-driver
```

#### on amd gpu

```sh
sudo dnf install mesa-va-drivers-freeworld mesa-va-drivers-freeworld.i686
```

### setup [grub theme](https://github.com/tomdewildt/minimal-grub-theme)

add following line to `/etc/default/grub`

```sh
GRUB_GRXMODE="2560x1440" # change to yours screen resolution
```

then run:

```sh
sudo grub2-mkconfig -o /etc/grub2-efi.cfg
```
