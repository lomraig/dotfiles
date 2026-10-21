echo "dnf speedup"

printf "[main]\nmax_parallel_downloads=15\nfasterstmirror=true\ndefaultyes=true\n" | sudo tee /etc/dnf/dnf.conf > /dev/null


echo "autologin setup"

AUTOLOGIN_COMMAND="[Service]\nExecStart=\nExecStart=-/usr/bin/agetty --autologin $USER --noissue %I $TERM\n"
sudo su -c 'mkdir -p /etc/systemd/system/getty@tty1.service.d/'
printf "%b\n" "$AUTOLOGIN_COMMAND" | sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null
sudo systemctl daemon-reload


echo "installing packages"

sudo dnf copr enable -y lionheartp/hyprland
sudo dnf copr enable -y scottames/ghostty
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y imput/helium

sudo dnf install --exclude=kitty -y hyprland hyprpaper hyprland-guiutils hyprlock hypridle fish ghostty starship make zoxide stow git ripgrep fd fzf bat eza gcc neovim helium-bin google-noto-emoji-fonts gdouros-symbola-fonts plymouth plymouth-system-theme which


echo "install dotfiles"
sudo chsh -s $(which fish) $USER
git clone https://github.com/lomraig/dotfiles ~/.dotfiles
cd ~/.dotfiles
rm -rf ~/.config ~/.gitconfig
stow linux
stow shared
bat cache --build
cd ~

