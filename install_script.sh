


timedatectl set-ntp true


#file system stuff 
#mkfs.btrfs /dev/nvme0n1p6
#mkswap /dev/nvme0n1p5
#mount /dev/nvme0n1p6 /mnt
#swapon /dev/nvme0n1p5 
#mkfs.fat -F32 /dev/nvme0n1p4




pacstrap /mnt base sudo linux-zen linux-zen-headers linux-firmware dkms ntfs-3g git base-devel grub efibootmgr dosfstools os-prober mtools bc nvim amd-ucode NetworkManager
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt 
ln -sf /usr/share/zoneinfo/Asia/Calcutta /etc/localtime
hwclock --systohc

#uncomment sudoers 
sed -i '/#.*members.*wheel/{n;s/^#//}' /etc/sudoers

echo 'en_US.UTF-8' >> /etc/locale.conf
locale-gen 

touch /etc/hostname 
echo kuroneko >> /etc/hostname
cat /etc/hostname
cat >> /etc/hosts << EOF 

127.0.0.1		localhost
::1		locathost
127.0.1.1		kuroneko.localdomain kuroneko
EOF
cat /etc/hosts


mkinitcpio -p linux-zen
passwd root
useradd -m kuroneko
passwd kuroneko
usermod -aG wheel,audio,video,optical,storage kuroneko

mkdir /boot/EFI
mount /dev/nvme0n1p4 /boot/EFI
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

cd /home/kuroneko
wget https://raw.githubusercontent.com/skinatro/arch-autoinstall/main/post_install.sh
wget https://raw.githubusercontent.com/skinatro/arch-autoinstall/main/config_install.sh
chmod +x post_install.sh
chmod +x config_install.sh

echo "also exit chroot by typing 'exit' and unmount /mnt by 'umount /mnt' then reboot"


