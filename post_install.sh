#Check for Root
[ "$(id -u)" = "0" ] || exit 1

#Reminder to Enable Multi-Lib

echo "Have you enabled multilib?"
read -r answer
if [ "$answer" = "yes" ]; then
    echo "You are Ready to go"
else
    #echo "You have 300 seconds to go and enable multi lib"
    #echo "Uncomment [Multilib] and /etc/pacman.conf from /etc/pacman.conf"
    #sleep 300
    awk 'f{sub(/^#/,"");f=0} $0=="#[multilib]"{f=1} 1' /etc/pacman.conf #automatically removes it 
fi

echo "Continue-ing with the script in 15 seconds"
sleep 15


#Adding Aur Helper - Yay
git clone https://aur.archlinux.org/yay-git.git
chown -R kuroneko:kuroneko ./yay.git
cd yay-git
makepkg -si

#Adding Chaotic Aur
pacman-key --recv-key 3056513887B78AEB
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-'{keyring,mirrorlist}'.pkg.tar.zst' 
cat >> /etc/pacman.conf << EOF 
[chaotic-aur] 
Include = /etc/pacman.d/chaotic-mirrorlist 
EOF 


#Updating the system
pacman -Syyu

#Adding "Better" Wifi Drivers
yay -S rtl8821ce-dkms-git

#Adding Graphical Stuff (Display server, window manager,X11 drivers)
yay -S  xorg xorg-xinit xorg-apps xorg-xauth xorg-xhost xf8-video-amdgpu bspwm sxhkd polybar deadd-notification-center-bin lightdm lightdm-gtk-greeter kitty rofi xdg-user-dirs picom
#maybe add betterlockscreen
#change the LightDM Greeter later
 install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
 install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
 cp /usr/share/doc/polybar/config ~/.config/polybar/config
 xdg-user-dirs
systemctl enable lightdm.service

#Adding Graphics Driver Stuff and Cpu stuff
yay -S mesa lib32-mesa mesa-vdpau opencl-amd corectrl zenmonitor

#Adding Sound stuff and Bluetooth
yay -S alsa-utils pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer bluez bluez-utils pavucontrol 

amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute
speaker-test -c 2
systemctl enable bluetooth.service 
#add <confdir:pcm/dca.conf> to /etc/asound.conf to enable dts sound / audio codecs
touch /etc/asound.conf
echo "<confdir:pcm/dca.conf>" >> /etc/asound.conf

#Utility programs
yay -S discord firefox tuf-manager flameshot zoom libreoffice-still gparted thunar ranger polkit polkit-gnome openssh blender vlc code copyq zram-generator ananicy-git nohang-git telegram-desktop deadbeeef-git 

systemctl enable --now nohang-desktop.service
systemctl enable ananicy
systemctl start ananicy

#Customizationlike Fonts,new shell etc
yay -S steam-fonts ttf-liberation wqy-zenhei 

#Gaming (wine steam etc)
yay -S wine-staging wine-gecko wine-mono lutris lib32-libpulse lib32-openal lib32-mpg123 samba lib32-gnutls lib32-giflib lib32-libpng lib32-gst-plugins-base lib32-gst-plugins-good lib32-gst-plugins-bad lib32-gst-plugins-ugly winetricks-git dxvk-bin wine-nine lib32-libxrandr lib32-libxinerama steam gamemode lib32-gamemode

#VFIO virtual machine  
yay -S qemu libvirt edk2-ovmf virt-manager iptables-nft dnsmasq linux-zen-headers 

systemctl enable libvirtd.service
systemctl enable virtlogd.socket 
virsh net-autostart default
virsh net-start default


grub-mkconfig -o /boot/grub/grub.cfg #Added to detect new kernels 


