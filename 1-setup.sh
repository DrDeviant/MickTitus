#!/usr/bin/env bash
echo -ne "
---------------------------------------------------------------------
███╗░░░███╗██╗░█████╗░██╗░░██╗████████╗██╗████████╗██╗░░░██╗░██████╗
████╗░████║██║██╔══██╗██║░██╔╝╚══██╔══╝██║╚══██╔══╝██║░░░██║██╔════╝
██╔████╔██║██║██║░░╚═╝█████═╝░░░░██║░░░██║░░░██║░░░██║░░░██║╚█████╗░
██║╚██╔╝██║██║██║░░██╗██╔═██╗░░░░██║░░░██║░░░██║░░░██║░░░██║░╚═══██╗
██║░╚═╝░██║██║╚█████╔╝██║░╚██╗░░░██║░░░██║░░░██║░░░╚██████╔╝██████╔╝
╚═╝░░░░░╚═╝╚═╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░╚═╝░░░░╚═════╝░╚═════╝░
--------------------------------------------------------------------  
       
                    Automated Arch Linux Installer
                        SCRIPTHOME: MickTitus 
--------------------------------------------------------------------
"
source /root/MickTitus/setup.conf
echo -ne "
--------------------------------------------------------------------
                    Network Setup 
--------------------------------------------------------------------
"
pacman -S networkmanager dhclient --noconfirm --needed
systemctl enable --now NetworkManager
echo -ne "
----------------------------------------------------------------------
                    Setting up mirrors for optimal download 
----------------------------------------------------------------------
"
pacman -S --noconfirm pacman-contrib curl
pacman -S --noconfirm reflector rsync grub btrfs-progs arch-install-scripts git

nc=$(grep -c ^processor /proc/cpuinfo)
echo -ne "
----------------------------------------------------------------------
                    You have " $nc" cores. And
			changing the makeflags for "$nc" cores. Aswell as
				changing the compression settings.
----------------------------------------------------------------------
"
TOTALMEM=$(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[[:digit:]]*')
if [[  $TOTALMEM -gt 8000000 ]]; then
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf
fi
echo -ne "
----------------------------------------------------------------------
                    Setup Language to US and set locale  
----------------------------------------------------------------------
"
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
timedatectl --no-ask-password set-timezone ${TIMEZONE}
timedatectl --no-ask-password set-ntp 1
localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="en_US.UTF-8"

# Set keymaps
localectl --no-ask-password set-keymap ${KEYMAP}

# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

#Add parallel downloading
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

# Add Color for Pacman
sed -i 's/^#Color/Color' /etc/pacman.conf

#Enable multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Sy --noconfirm

echo -ne "
----------------------------------------------------------------------
                    Installing Base System  
----------------------------------------------------------------------
"
cat /root/MickTitus/pkg-files/pacman-pkgs.txt | while read line 
do
    echo "INSTALLING: ${line}"
   sudo pacman -S --noconfirm --needed ${line}
done
echo -ne "
----------------------------------------------------------------------
                    Installing Microcode
----------------------------------------------------------------------
"
# determine processor type and install microcode
proc_type=$(lscpu)
if grep -E "GenuineIntel" <<< ${proc_type}; then
    echo "Installing Intel microcode"
    pacman -S --noconfirm intel-ucode
    proc_ucode=intel-ucode.img
elif grep -E "AuthenticAMD" <<< ${proc_type}; then
    echo "Installing AMD microcode"
    pacman -S --noconfirm amd-ucode
    proc_ucode=amd-ucode.img
fi

echo -ne "
----------------------------------------------------------------------
                    Installing Graphics Drivers
----------------------------------------------------------------------
"
# Graphics Drivers find and install
gpu_type=$(lspci)
if grep -E "NVIDIA|GeForce" <<< ${gpu_type}; then
    pacman -S nvidia-dkms --noconfirm --needed
	nvidia-xconfig
elif lspci | grep 'VGA' | grep -E "Radeon|AMD"; then
    pacman -S xf86-video-amdgpu --noconfirm --needed
elif grep -E "Integrated Graphics Controller" <<< ${gpu_type}; then
    pacman -S libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa --needed --noconfirm
elif grep -E "Intel Corporation UHD" <<< ${gpu_type}; then
    pacman -S libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa --needed --noconfirm
fi
# convert name to lowercase before saving to setup.conf
#Set Password
passwd $username
echo -ne "
----------------------------------------------------------------------
                    Adding User
----------------------------------------------------------------------
"
if [ $(whoami) = "root"  ]; then
    useradd -m -G wheel,docker -s /bin/zsh $USERNAME 

	cp -R /root/MickTitus /home/$USERNAME/
  chown -R $USERNAME: /home/$USERNAME/MickTitus
# enter $nameofmachine to /etc/hostname
	echo $nameofmachine > /etc/hostname
else
	echo "You are already a user proceed with aur installs"
fi
if [[ ${FS} == "luks" ]]; then
# Making sure to edit mkinitcpio conf if luks is selected
# add encrypt in mkinitcpio.conf before filesystems in hooks
    sed -i 's/filesystems/encrypt filesystems/g' /etc/mkinitcpio.conf
# making mkinitcpio with linux kernel
    mkinitcpio -p linux-zen
fi
echo -ne "
----------------------------------------------------------------------
                    SYSTEM READY FOR 2-user.sh
----------------------------------------------------------------------
"
