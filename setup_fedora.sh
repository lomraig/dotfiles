# dnf speedup
printf "[main]\nmax_parallel_downloads=15\nfastestmirror=true\ndefaultyes=true\n" | sudo tee /etc/dnf/dnf.conf

# updates firmware
fwupdmgr refresh --force
fwupdmgr get-updates
fwupdmgr update

# installs rpmfusion
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data

# installing packages
sudo dnf copr enable -y lionheartp/Hyprland
sudo dnf copr enable -y scottames/ghostty
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y imput/helium
sudo dnf copr enable -y claaj/typst
sudo dnf copr enable -y dejan/lazygit

# full version of ffmpeg
sudo dnf swap -y 'ffmpeg-free' 'ffmpeg' --allowerasing

sudo dnf group install -y sound-and-video

# hardware video acceleration packages
sudo dnf install -y ffmpeg-libs libva libva-utils

sudo dnf install --exclude=kitty -y hyprland hyprpaper hyprland-guiutils hyprlock hypridle \
                                    fish ghostty starship zoxide stow ripgrep fd fzf bat eza neovim lazygit \
                                    make git gcc which flatpak fuse-libs firewalld typst rust cargo \
                                    helium-bin google-noto-emoji-fonts gdouros-symbola-fonts \
                                    plymouth plymouth-system-theme greetd \
                                    mesa-va-drivers-freeworld mesa-va-drivers-freeworld.i686 ffmpeg-libs libva libva-utils \
                                    dolphin

# autologin setup
sudo systemctl mask kmsconvt@tty1
sudo systemctl set-default graphical.target
GREETD_CONFIG=/etc/greetd/config.toml
sudo sed -i 's/^vt = .*/vt = 1/' "$GREETD_CONFIG"
grep -q '^\[initial_session\]' "$GREETD_CONFIG" ||
    printf '\n[initial_session]\ncommand = "start-hyprland"\nuser = "%s"\n' "$USER" | sudo tee -a "$GREETD_CONFIG"
sudo systemctl enable greetd

# flathub + appimages
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo 2> /dev/null
sudo flatpak remote-modify --disable fedora
sudo flatpak install -y --noninteractive it.mijorus.gearlever org.localsend.localsend_app < /dev/null 2> /dev/null

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

# localsend fix
sudo firewall-cmd --add-port=53317/tcp --permanent
sudo firewall-cmd --reload
flatpak override org.localsend.localsend_app --filesystem=home --user

# plymouth theme setup
echo 'force_drivers+=" amdgpu "' | sudo tee /etc/dracut.conf.d/amdgpu.conf
sudo dracut -f
unzip ~/.dotfiles/fedora-mac-style-plymouth-theme.zip -d ~/.dotfiles/
sudo mkdir -p /usr/share/plymouth/themes/
sudo cp -r ~/.dotfiles/fedora-mac-style/ /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R fedora-mac-style
rm -rf ~/.dotfiles/fedora-mac-style

# minimalistic grub theme setup
RES=$(cat /sys/class/drm/card*-*/modes 2>/dev/null | head -n1)  # gets resolution of main screen
git clone https://github.com/tomdewildt/minimal-grub-theme ~/.grub-theme
sudo mkdir -p /boot/grub2/themes
sudo cp -r ~/.grub-theme/minimal /boot/grub2/themes/
sudo chown -R root:root /boot/grub2/themes/minimal
sudo sed -i '/^GRUB_TERMINAL_OUTPUT/d;/^GRUB_GFXPAYLOAD_LINUX/d;/^GRUB_THEME/d;/^GRUB_GFXMODE/d' /etc/default/grub
printf '\nGRUB_TERMINAL_OUTPUT="gfxterm"\nGRUB_GFXPAYLOAD_LINUX=keep\nGRUB_THEME="/boot/grub2/themes/minimal/theme.txt"\nGRUB_GFXMODE="%s,auto"\n' "$RES" | sudo tee -a /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2-efi.cfg
sudo grubby --update-kernel=ALL --args="rhgb quiet"
rm -rf ~/.grub-theme

# installs fonts
curl -fL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz | tar -xJ -C ~/.local/share/fonts/JetBrainsMonoNerd
fc-cache -f

reboot
