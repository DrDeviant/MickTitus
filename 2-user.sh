#!/usr/bin/env bash
echo -ne "
--------------------------------------------------------------------
真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真
真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真
真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真
真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真
真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真
真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真真
--------------------------------------------------------------------  
                    Automated Arch Linux Installer
                        SCRIPTHOME: MickTitus
--------------------------------------------------------------------
Installing AUR Softwares"
source $HOME/MickTitus/setup.conf

cd $HOME
git clone "https://aur.archlinux.org/yay.git"
cd $HOME/yay
makepkg -si --noconfirm
cd $HOME
mkdir -p $HOME/.config/kitty/
ln -sf "$HOME/MickTitus/misc/dotfiles/.zshrc" "$HOME/.zshrc" 
ln -sf "$HOME/MickTitus/misc/configs/kitty.conf" "$HOME/.config/kitty/kitty.conf"
ln -sf "$HOME/MickTitus/misc/configs/awesome" "$HOME/.config/"

mkdir -p $HOME/.config/rofi
cp $HOME/.config/awesome/theme/config.rasi $HOME/.config/rofi/config.rasi
sed -i '/@theme/c\@theme "'$HOME'/.config/awesome/theme/sidebar.rasi"' ~/.config/rofi/config.rasi


# Figure this out you fat cunt
# sh $HOME/MickTitus/LunarVim.sh
# ln -sf $HOME/MickTitus/misc/configs/config.lua $HOME/.config/lvim/config.lua
# lvim -c PackerSync

yay -S --noconfirm --needed - < ~/MickTitus/pkg-files/aur-pkgs.txt
pip install black isort

echo -ne "
----------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
----------------------------------------------------------------------
"
exit
