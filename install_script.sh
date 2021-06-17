sudo timedatectl set-ntp true
sudo mkfs.btrfs /dev/nvme0n1p6
sudo mkswap /dev/nvme0n1p5
sudo mount /dev/nvme0n1p6 /mnt
sudo swapon /dev/nvme0n1p5 
sudo mkfs.ext4 /dev/nvme0n1p4

echo " manage sudoers thingy"

sudo pacstrap /mnt base linux linux-firmware linux-headers dkms ntfs-3g git base-devel grub efibootmgr dosfstools os-prober mtools bc nvim amd-ucode
sudo genfstab -U /mnt >> /mnt/etc/fstab
sudo arch-chroot /mnt 
sudo ln -sf /usr/share/zoneinfo/Asia/Calcutta /etc/localtime
sudo hwclock --systohc

echo "edit /etc/locale.gen then run locale-gen"

sudo touch /etc/hostname 
sudo echo kuroneko >> /etc/hostname
sudo cat /etc/hostname
sudo echo "127.0.0.1		localhost" >> /etc/hosts
sudo echo "::1		locathost" >> /etc/hosts
sudo echo "127.0.1.1		kuroneko.localdomain kuroneko" >> /etc/hosts
sudo cat /etc/hosts


#mkinitcpio -P
passwd root
sudo useradd -m kuroneko
passwd kuroneko
sudo usermod -aG wheel,audio,video,optical,storage kuroneko

sudo mkdir /boot/EFI
sudo mount /dev/nvme0n1p4 /boot/EFI
sudo grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck
sudo grub-mkconfig -o /boot/grub/grub.cfg



echo "do the sudoers file stuff and the locale-gen thingy"
echo "will automate this stuff in the future"
echo "also exit chroot by typing 'exit' and unmount /mnt by 'umount /mnt' then reboot"
