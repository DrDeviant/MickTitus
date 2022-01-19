#!/usr/bin/env bash
echo -ne "
------------------------------------------------------------------------------------------------------------------------------------------
██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
█░░░░░░██████████░░░░░░█░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░█░░░░░░░░░░░░░░█
█░░▄▀░░░░░░░░░░░░░░▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
█░░▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀░░█░░░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░░░█░░░░░░▄▀░░░░░░█░░░░▄▀░░░░█░░░░░░▄▀░░░░░░█░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░░░█
█░░▄▀░░░░░░▄▀░░░░░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░██░░▄▀░░███████░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░█████████
█░░▄▀░░██░░▄▀░░██░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░░░░░▄▀░░███████░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░░░█
█░░▄▀░░██░░▄▀░░██░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀▄▀▄▀▄▀▄▀░░███████░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
█░░▄▀░░██░░░░░░██░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░░░░░▄▀░░███████░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░░░░░░░░░▄▀░░█
█░░▄▀░░██████████░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░██░░▄▀░░███████░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████░░▄▀░░██░░▄▀░░█████████░░▄▀░░█
█░░▄▀░░██████████░░▄▀░░█░░░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░░░█████░░▄▀░░█████░░░░▄▀░░░░█████░░▄▀░░█████░░▄▀░░░░░░▄▀░░█░░░░░░░░░░▄▀░░█
█░░▄▀░░██████████░░▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀▄▀░░█████░░▄▀░░█████░░▄▀▄▀▄▀░░█████░░▄▀░░█████░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
█░░░░░░██████████░░░░░░█░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░░░█████░░░░░░█████░░░░░░░░░░█████░░░░░░█████░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█
██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
------------------------------------------------------------------------------------------------------------------------------------------�
                    Automated Arch Linux Installer
                        SCRIPTHOME: MickTitus
-------------------------------------------------------------------------

Installing AUR Softwares
"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.
source $HOME/MickTitus/setup.conf

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd $HOME/yay
makepkg -si --noconfirm
cd $HOME
mkdir -p $HOME/.local/plugin_managers
git clone "https://github.com/ohmyzsh/ohmyzsh" $HOME/.local/plugin_managers/ohmyzsh
mkdir -p $HOME/.config/kitty/
ln -sf "$HOME/MickTitus/misc/dotfiles/.zshrc" "$HOME/.zshrc" 
ln -sf "$HOME/MickTitus/misc/configs/kitty.conf" "$HOME/.config/kitty/kitty.conf"
ln -sf "$HOME/MickTitus/misc/configs/awesome" "$HOME/.config/"
mkdir -p $HOME/.config/rofi
cp $HOME/.config/awesome/theme/config.rasi $HOME/.config/rofi/config.rasi
sed -i '/@theme/c\@theme "'$HOME'/.config/awesome/theme/sidebar.rasi"' ~/.config/rofi/config.rasi

nitrogen --set-auto $HOME/MickTitus/misc/wall.jpg


sh $HOME/MickTitus/LunarVim.sh
ln -sf $HOME/MickTitus/misc/configs/config.lua $HOME/.config/lvim/config.lua
lvim -c PackerSync

yay -S --noconfirm --needed - < ~/MickTitus/pkg-files/aur-pkgs.txt

export PATH=$PATH:~/.local/bin
cp -r ~/ArchTitus/dotfiles/* ~/.config/
pip install black isort

echo -ne "
-------------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
-------------------------------------------------------------------------
"
exit
