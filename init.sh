
timedatectl set-ntp true


#file system stuff

echo "enter the block device for root filesystem"
read $rootfs
mkfs.btrfs $rootfs
mount $rootfs /mnt

echo "enter the block device for swap"
read $swapfs
mkswap $swapfs
swapon $swapfs

echo "enter block device for ESP"
read $ESP
mkfs.fat -F32 $ESP


pacstrap /mnt base sudo linux-zen linux-zen-headers linux-firmware dkms ntfs-3g git base-devel grub efibootmgr dosfstools os-prober mtools bc nvim amd-ucode NetworkManager
genfstab -U /mnt >> /mnt/etc/fstab

touch chroot.sh
curl https://raw.githubusercontent.com/skinatro/arch-autoinstall/main/init.sh > chroot.sh
chmod +x chroot.sh
mv chroot.sh /mnt 

#chroot
arch-chroot /mnt 

