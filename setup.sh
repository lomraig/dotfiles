# speedup dnf
printf "[main]\nmax_parallel_downloads=15\nfasterstmirror=true\ndefaultyes=true\n" | sudo tee /etc/dnf/dnf.conf

# autologin setup
AUTOLOGIN_COMMAND="[Service]\nExecStart=\nExecStart=-/usr/bin/agetty --autologin $USER --noissue %I $TERM\n"
sudo su -c 'mkdir -p /etc/systemd/system/getty@tty1.service.d/'
printf "%b\n" "$AUTOLOGIN_COMMAND" | sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf
