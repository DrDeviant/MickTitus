#!/bin/bash

    bash 0-preinstall.sh
    arch-chroot /mnt /root/MickTitus/1-setup.sh
    source /mnt/root/MickTitus/install.conf
    arch-chroot /mnt /usr/bin/runuser -u $username -- /home/$username/ArchTitus/2-user.sh
    arch-chroot /mnt /root/MickTitus/3-post-setup.sh
e
