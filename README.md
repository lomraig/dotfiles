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

### run setup script

```sh
curl https://raw.githubusercontent.com/lomraig/dotfiles/refs/heads/main/setup_mac.sh | bash
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

### run setup script

```sh
curl https://raw.githubusercontent.com/lomraig/dotfiles/refs/heads/main/setup_fedora.sh | bash
```

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
