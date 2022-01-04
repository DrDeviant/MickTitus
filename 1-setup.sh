#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------------------------------------
# ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
# █░░░░░░██████████░░░░░░█░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░█░░░░░░░░░░░░░░█
# █░░▄▀░░░░░░░░░░░░░░▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
# █░░▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀░░█░░░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░░░█░░░░░░▄▀░░░░░░█░░░░▄▀░░░░█░░░░░░▄▀░░░░░░█░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░░░█
# █░░▄▀░░░░░░▄▀░░░░░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░██░░▄▀░░███████░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░█████████
# █░░▄▀░░██░░▄▀░░██░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░░░░░▄▀░░███████░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░░░█
# █░░▄▀░░██░░▄▀░░██░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀▄▀▄▀▄▀▄▀░░███████░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
# █░░▄▀░░██░░░░░░██░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░░░░░▄▀░░███████░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░░░░░░░░░▄▀░░█
# █░░▄▀░░██████████░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░██░░▄▀░░███████░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████░░▄▀░░██░░▄▀░░█████████░░▄▀░░█
# █░░▄▀░░██████████░░▄▀░░█░░░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░░░█████░░▄▀░░█████░░░░▄▀░░░░█████░░▄▀░░█████░░▄▀░░░░░░▄▀░░█░░░░░░░░░░▄▀░░█
# █░░▄▀░░██████████░░▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀▄▀░░█████░░▄▀░░█████░░▄▀▄▀▄▀░░█████░░▄▀░░█████░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
# █░░░░░░██████████░░░░░░█░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░░░█████░░░░░░█████░░░░░░░░░░█████░░░░░░█████░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█
# ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
#-------------------------------------------------------------------------------------------------------------------------------------------
echo "--------------------------------------"
echo "--          Network Setup           --"
echo "--------------------------------------"
pacman -S networkmanager dhclient --noconfirm --needed
systemctl enable --now NetworkManager
echo "-------------------------------------------------"
echo "Setting up mirrors for optimal download          "
echo "-------------------------------------------------"
pacman -S --noconfirm pacman-contrib curl
pacman -S --noconfirm reflector rsync
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

nc=$(grep -c ^processor /proc/cpuinfo)
echo "You have " $nc" cores."
echo "-------------------------------------------------"
echo "Changing the makeflags for "$nc" cores."
TOTALMEM=$(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[[:digit:]]*')
if [[  $TOTALMEM -gt 8000000 ]]; then
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
echo "Changing the compression settings for "$nc" cores."
sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf
fi
echo "-------------------------------------------------"
echo "       Setup Language to US and set locale       "
echo "-------------------------------------------------"
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
timedatectl --no-ask-password set-timezone America/Denver
timedatectl --no-ask-password set-ntp 1
localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="en_US.UTF-8"

# Set keymaps
localectl --no-ask-password set-keymap us

# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

#Add parallel downloading
sed -i 's/^#Para/Para/' /etc/pacman.conf

#Enable multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Sy --noconfirm
echo "Color" >> /etc/pacman.conf

echo -e "\nInstalling Base System\n"

PKGS=(
'mesa' # Essential Xorg First
'xorg'
'xorg-server'
'xorg-apps'
'xorg-drivers'
'xorg-xkill'
'xorg-xinit'
'plasma-desktop' 
'appmenu-gtk-module'
'ark' 
'aspnet-runtime'
'autoconf' 
'automake' 
'base'
'bind'
'binutils'
'bison'
'breeze'
'btrfs-progs'
'cups'
'discord'
'docker'
'docker-compose'
'dolphin'
'dosfstools'
'dotnet'
'dotnet-sdk'
'dtc'
'efibootmgr' 
'egl-wayland'
'exfat-utils'
'extra-cmake-modules'
'flex'
'fuse2'
'fuse3'
'fuseiso'
'gcc'
'gimp' 
'git'
'gptfdisk'
'grub'
'gst-libav'
'gst-plugins-good'
'gst-plugins-ugly'
'gwenview'
'haveged'
'htop'
'iptables-nft'
'kcodecs'
'kcoreaddons'
'kdeconnect'
'kde-gtk-config'
'kdeplasma-addons'
'kitty'
'khotkeys'
'kscreen'
'kscreen'
'kwin'
'layer-shell-qt'
'libdvdcss'
'libnewt'
'libtool'
'libreoffice-fresh'
'linux-firmware'
'linux-zen'
'linux-zen-headers'
'lollypop'
'lsof'
'm4'
'make'
'milou'
'mono'
'networkmanager'
'neovim'
'nodejs'
'npm'
'ntp'
'openssh'
'os-prober'
'p7zip'
'pacman-contrib'
'patch'
'picard'
'pipewire-alsa'
'pipewire-pulse'
'pkgconf'
'plasma-nm'
'print-manager'
'python-pip'
'rsync'
'rust'
'sddm'
'sddm-kcm'
'sshfs'
'shellcheck'
'snapper'
'spectacle'
'sudo'
'systemsettings'
'ttf-iosevka-nerd'
'unrar'
'unzip'
'usbutils'
'wget'
'which'
'xdg-desktop-portal-kde'
'xdg-user-dirs'
'zip'
'zsh'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

proc_type=$(lscpu | awk '/Vendor ID:/ {print $3}')
case "$proc_type" in
	GenuineIntel)
		print "Installing Intel microcode"
		pacman -S --noconfirm intel-ucode
		proc_ucode=intel-ucode.img
		;;
	AuthenticAMD)
		print "Installing AMD microcode"
		pacman -S --noconfirm amd-ucode
		proc_ucode=amd-ucode.img
		;;
esac	

# Graphics Drivers find and install
if lspci | grep -E "NVIDIA|GeForce"; then
    pacman -S nvidia-dkms --noconfirm --needed
	nvidia-xconfig
elif lspci | grep -E "Radeon"; then
    pacman -S xf86-video-amdgpu --noconfirm --needed
elif lspci | grep -E "Integrated Graphics Controller"; then
    pacman -S libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils --needed --noconfirm
fi

read -p "Please enter username:" username

username=${username,,}


if [ $(whoami) = "root"  ];
then
    useradd -m -G wheel,docker -s /bin/zsh $username 
	passwd $username
	cp -R /root/MickTitus /home/$username/
    chown -R $username: /home/$username/MickTitus
	read -p "Please name your machine:" nameofmachine
	echo $nameofmachine > /etc/hostname
else
	echo "You are already a user proceed with aur installs"
fi

