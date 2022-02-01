#!/usr/bin/env bash
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
                        SCRIPTHOME: MickTitus
--------------------------------------------------------------------
Installing AUR Softwares"
source $HOME/MickTitus/setup.conf

cd $HOME
git clone "https://aur.archlinux.org/yay.git"
cd $HOME/yay
makepkg -si --noconfirm
cd $HOME
git clone https://github.com/ohmyzsh/ohmyzsh.git 
mkdir -p $HOME/.config/kitty/
ln -sf "$HOME/MickTitus/misc/dotfiles/.zshrc" "$HOME/.zshrc" 
ln -sf "$HOME/MickTitus/misc/configs/kitty.conf" "$HOME/.config/kitty/kitty.conf"
ln -sf "$HOME/MickTitus/misc/configs/awesome" "$HOME/.config/"

mkdir -p $HOME/.config/rofi
cp $HOME/.config/awesome/theme/config.rasi $HOME/.config/rofi/config.rasi
sed -i '/@theme/c\@theme "'$HOME'/.config/awesome/theme/sidebar.rasi"' ~/.config/rofi/config.rasi

mkdir $HOME/.ssh/
chmod 700 $HOME/.ssh
echo -ne "
Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/external
  IdentityFile ~/.ssh/github
" >> $HOME/.ssh/config

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
source $HOME/.zshrc

sh $HOME/MickTitus/LunarVim.sh
ln -sf $HOME/MickTitus/misc/configs/config.lua $HOME/.config/lvim/config.lua
$HOME/.local/bin/lvim -c PackerSync
yay -S --noconfirm --needed - < ~/MickTitus/pkg-files/aur-pkgs.txt
pip install black isort

echo -ne "
----------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
----------------------------------------------------------------------
"
exit
