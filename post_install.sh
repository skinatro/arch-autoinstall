sudo pacman -Syu

git clone https://aur.archlinux.org/yay-git.git
sudo chown -R kuroneko:kuroneko ./yay.git
cd yay-git
makepkg -si

yay -S rtl8821ce-dkms-git

yay -S xorg xorg-xinit rxvt-unicode xf86-video-amdgpu mesa tlp firefox tuf-manager polybar sxhkdrc bspwm 
yay -S deadd-notification-center-bin discord spotify flameshot dmenu polkit openssh zoom bitwarden blender zenmonitor 
yay -S gparted pavucontrol alsa-utils pipewire pipewire-alsa lightdm lightdm-gtk-greeter neofetch opencl-amd corectrl mesa-vdpau
yay -S pulseeffects blender pipewire-pulse wpa_supplicant ts-polkitagent ranger sxiv vlc pavucontrol copyq wpgtk-git zsh-completions
yay -S oblogout betterlockscreen amd-ucode xdg-user-dirs noto-fonts noto-fonts-emoji ttf-linux-libertine ttf-dejavu ttf-indic-otf zsh

curl -sLf https://spacevim.org/install.sh | bash

xdg-users-dirs-update

systemctl enable lightdm.service

amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute
speaker-test -c 2

 install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
 install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
 cp /usr/share/doc/polybar/config ~/.config/polybar/config
