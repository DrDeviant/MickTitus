#!/bin/bash

    bash 0-preinstall.sh
    arch-chroot /mnt /root/NickTitus/1-setup.sh
    arch-chroot /mnt /usr/bin/runuser -u $username -- /home/$username/MickTItus/2-user.sh
    arch-chroot /mnt /root/MickTitus/3-post-setup.sh