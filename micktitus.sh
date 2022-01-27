#!/bin/bash

# Find the name of the folder the scripts are in
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo -ne "
--------------------------------------------------------------------
███╗░░░███╗██╗░█████╗░██╗░░██╗████████╗██╗████████╗██╗░░░██╗░██████╗
████╗░████║██║██╔══██╗██║░██╔╝╚══██╔══╝██║╚══██╔══╝██║░░░██║██╔════╝
██╔████╔██║██║██║░░╚═╝█████═╝░░░░██║░░░██║░░░██║░░░██║░░░██║╚█████╗░
██║╚██╔╝██║██║██║░░██╗██╔═██╗░░░░██║░░░██║░░░██║░░░██║░░░██║░╚═══██╗
██║░╚═╝░██║██║╚█████╔╝██║░╚██╗░░░██║░░░██║░░░██║░░░╚██████╔╝██████╔╝
╚═╝░░░░░╚═╝╚═╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░╚═╝░░░░╚═════╝░╚═════╝░
--------------------------------------------------------------------  
                    Automated Arch Linux Installer
-------------------------------------------------------------------------
                Scripts are in directory named MickTitus
"
    bash startup.sh
    source $SCRIPT_DIR/setup.conf
    bash 0-preinstall.sh
    arch-chroot /mnt /root/MickTitus/1-setup.sh
    arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/MickTitus/2-user.sh
    arch-chroot /mnt /root/MickTitus/3-post-setup.sh

echo -ne "
--------------------------------------------------------------------
███╗░░░███╗██╗░█████╗░██╗░░██╗████████╗██╗████████╗██╗░░░██╗░██████╗
████╗░████║██║██╔══██╗██║░██╔╝╚══██╔══╝██║╚══██╔══╝██║░░░██║██╔════╝
██╔████╔██║██║██║░░╚═╝█████═╝░░░░██║░░░██║░░░██║░░░██║░░░██║╚█████╗░
██║╚██╔╝██║██║██║░░██╗██╔═██╗░░░░██║░░░██║░░░██║░░░██║░░░██║░╚═══██╗
██║░╚═╝░██║██║╚█████╔╝██║░╚██╗░░░██║░░░██║░░░██║░░░╚██████╔╝██████╔╝
╚═╝░░░░░╚═╝╚═╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░╚═╝░░░░╚═════╝░╚═════╝░
--------------------------------------------------------------------  
                    Automated Arch Linux Installer
-------------------------------------------------------------------------
                Done - Please Eject Install Media and Reboot
"
