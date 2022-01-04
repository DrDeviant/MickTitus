#!/bin/bash

    bash 0-preinstall.sh
    arch-chroot /mnt /root/MickTitus/1-setup.sh
    arch-chroot /mnt /usr/bin/runuser -u $username -- /home/$username/MickTitus/2-user.sh
    arch-chroot /mnt /root/MickTitus/3-post-setup.sh
