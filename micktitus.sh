#!/bin/bash

    bash 0-preinstall.sh
    arch-chroot /mnt /root/MickTitus/1-setup.sh
    arch-chroot /mnt /root/MickTitus/3-post-setup.sh
