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

### dnf speed up

paste following lines in `/etc/dnf/dnf.conf`

```sh
max_parallel_downloads=15
fasterstmirror=True
defaultyes=True
```

### auto login on startup

```sh
sudo su
cd /etc/systemd/system/
mkdir -p getty@tty1.service.d/
nvim getty@tty1.service.d/override.conf

# add:

[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin YOUR_USER_NAME --noissue %I $TERM

# save then run:

systemctl daemon-reload
```

### install essensial packages

```sh
sudo dnf copr enable lionheartp/Hyprland
sudo dnf copr enable scottames/ghostty
sudo dnf copr enable atim/starship
sudo dnf copr enable imput/helium

sudo dnf install --exclude=kitty hyprland hyprpaper hyprland-guiutils hyprlock hypridle

sudo dnf install fish ghostty starship make zoxide stow git ripgrep fd fzf bat eza gcc neovim helium-bin
sudo dnf install google-noto-emoji-fonts gdouros-symbola-fonts
sudo dnf install plymouth plymouth-system-theme
```

### install dotfiles

```sh
chsh -s $(which fish)
git clone https://github.com/lomraig/dotfiles ~/.dotfiles
cd ~/.dotfiles
rm -rf ~/.config/fish ~/.config/ghostty ~/.config/hypr
stow linux
stow shared
bat cache --build
```

### add rpm-fusion repositories and update system

```sh
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data
```

### check firmware update

```sh
fwupdmgr refresh --force
fwupdmgr update
```

if there were any updates:

```sh
reboot
```

### install flatpak

```sh
sudo dnf install flatpak
```

```sh
flatpak remote-modify --disable fedora
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

### add appimages support

```sh
sudo dnf install fuse-libs
flatpak install it.mijorus.gearlever
```

### if a laptop: install better power manager

[guide](https://fedoraproject.org/wiki/Changes/TunedAsTheDefaultPowerProfileManagementDaemon)

and

```sh
reboot
```

### install media codecs

```sh
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin --exclude=libheif-freeworld --exclude=obs-studio-freeworld # Update multimedia/GStreamer components while excluding currently broken broken packages.
sudo dnf swap 'ffmpeg-free' 'ffmpeg' --allowerasing
```

### hardware video acceleration

```sh
sudo dnf install ffmpeg-libs libva libva-utils
```

#### on intel gpu (5th+ gen)

```sh
sudo dnf swap libva-intel-media-driver intel-media-driver --allowerasing
sudo dnf install libva-intel-driver
```

#### on amd gpu

```sh
sudo dnf install mesa-va-drivers-freeworld mesa-va-drivers-freeworld.i686
```

### plymouth

```sh
unzip ~/.dotfiles/fedora-mac-style-plymouth-theme.zip -d ~/.dotfiles/
sudo mkdir -p /usr/share/plymouth/themes/
sudo cp -r ~/.dotfiles/fedora-mac-style /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R fedora-mac-style

rm -rf ~/.dotfiles/fedora-mac-style
```

### localsend fix

```sh
sudo firewall-cmd --add-port=53317/tcp --permanent
flatpak override org.localsend.localsend_app --filesystem=home --user
```

### install language runtimes/compiles

```sh
sudo dnf copr enable claaj/typst
sudo dnf install typst rust cargo
```

### setup [grub theme](https://github.com/tomdewildt/minimal-grub-theme)

move theme directory to `/boot/grub2/themes`

add following lines to `/etc/default/grub`

```sh
GRUB_TERMINAL_OUTPUT="gfxterm"
GRUB_GRXMODE="2560x1440"
GRUB_GFXPLAYLOAD_LINUX=keep
GRUB_THEME="/boot/grub2/themes/minimal/theme.txt"
```

then run:

```sh
sudo grub2-mkconfig -o /etc/grub2-efi.cfg
```
