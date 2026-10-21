# dnf speedup
printf "[main]\nmax_parallel_downloads=15\nfastestmirror=true\ndefaultyes=true\n" | sudo tee /etc/dnf/dnf.conf

# autologin setup
AUTOLOGIN_COMMAND="[Service]\nExecStart=\nExecStart=-/usr/bin/agetty --autologin $USER --noissue %I $TERM\n"
sudo su -c 'mkdir -p /etc/systemd/system/getty@tty1.service.d/'
printf "%b\n" "$AUTOLOGIN_COMMAND" | sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf
sudo systemctl daemon-reload

# installs rpmfusion
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data

# installing packages
sudo dnf copr enable -y lionheartp/Hyprland
sudo dnf copr enable -y scottames/ghostty
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y imput/helium
sudo dnf copr enable -y claaj/typst

sudo dnf install --exclude=kitty -y hyprland hyprpaper hyprland-guiutils hyprlock hypridle fish ghostty starship make zoxide stow git ripgrep fd fzf bat eza gcc neovim helium-bin google-noto-emoji-fonts gdouros-symbola-fonts plymouth plymouth-system-theme which flatpak fuse-libs firewall-cmd typst rust cargo

# full version of ffmpeg
sudo dnf swap -y 'ffmpeg-free' 'ffmpeg' --allowerasing

# hardware video acceleration packages
sudo dnf install -y ffmpeg-libs libva libva-utils

vendors=$(cat /sys/class/drm/card*/device/vendor)

if echo "$vendors" | grep -q "0x8086"; then
  sudo dnf swap libva-intel-media-driver intel-media-driver --allowerasing
  sudo dnf install libva-intel-driver
fi

if echo "$vendors" | grep -q "0x1002"; then
  sudo dnf install mesa-va-drivers-freeworld mesa-va-drivers-freeworld.i686
fi

# flathub + appimages
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo 2> /dev/null
sudo flatpak install -y it.mijorus.gearlever 2> /dev/null

# installs dotfiles
sudo chsh -s $(which fish) $USER
rm -rf ~/.dotfiles
git clone https://github.com/lomraig/dotfiles ~/.dotfiles
cd ~/.dotfiles
rm -rf ~/.config/* ~/.gitconfig
stow linux
stow shared
bat cache --build
cd ~

# updates firmware
fwupdmgr refresh --force
fwupdmgr update

# localsend fix
sudo firewall-cmd --add-port=53317/tcp --permanent
sudo firewall-cmd --reload
flatpak override org.localsend.localsend_app --filesystem=home --user

# plymouth theme setup
unzip ~/.dotfiles/fedora-mac-style-plymouth-theme.zip -d ~/.dotfiles/
sudo mkdir -p /usr/share/plymouth/themes/
sudo cp -r ~/.dotfiles/fedora-mac-style/ /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R fedora-mac-style
rm -rf ~/.dotfiles/fedora-mac-style

# minimalistic grub theme setup
git clone https://github.com/tomdewildt/minimal-grub-theme ~/.grub-theme
sudo mv ~/.grub-theme/minimal/ /boot/grub2/themes/
printf '\n\n\n\n\nGRUB_TERMINAL_OUTPUT="gfxterm"\nGRUB_GFXPLAYLOAD_LINUX=keep\nGRUB_THEME="/boot/grub2/themes/minimal/theme.txt"\nGRUB_GRXMODE="2560x1440"' | sudo tee /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2-efi.cfg
sudo grubby --update-kernel=ALL --args="rhgb quiet" # needed by plymouth
rm -rf ~/.grub-theme

# installs fonts
curl -fL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz | tar -xJ -C ~/.local/share/fonts/JetBrainsMonoNerd
fc-cache -f

reboot
