#!/usr/bin/env bash
#-------------------------------------------------------------------------
# 	███╗   ███╗██╗ ██████╗██╗  ██╗██╗██╗   ██╗███╗   ███╗
# 	████╗ ████║██║██╔════╝██║ ██╔╝██║██║   ██║████╗ ████║
# 	██╔████╔██║██║██║     █████╔╝ ██║██║   ██║██╔████╔██║
# 	██║╚██╔╝██║██║██║     ██╔═██╗ ██║██║   ██║██║╚██╔╝██║
# 	██║ ╚═╝ ██║██║╚██████╗██║  ██╗██║╚██████╔╝██║ ╚═╝ ██║
# 	╚═╝     ╚═╝╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝     ╚═╝
#-------------------------------------------------------------------------

echo "CLONING: YAY"
cd $HOME
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd $HOME
rm -rf yay
mkdir $HOME/.local/plugin_managers
git clone "https://github.com/ohmyzsh/ohmyzsh" $HOME/.local/plugin_managers/ohmyzsh
git clone "https://github.com/tmux-plugins/tpm" $HOME/.local/plugin_managers/tpm
ln -s "$HOME/MickTitus/dotfiles/.zshrc" "$HOME/.zshrc" 
ln -s "$HOME/MickTitus/dotfiles/.tmux.conf" "$HOME/.tmux.conf"

mkdir $HOME/.config/npm-global
npm config set prefix '$HOME/.config.npm-global'
source $HOME/.zshrc

sh $HOME/MickTitus/LunarVim.sh
ln -sf $HOME/MickTitus/config.lua $HOME/.config/lvim/config.lua
lvim -c PackerSync

PKGS=(
'ant-dracula-kde-theme-git'
'brave-bin' 
'candy-icons-git'
'dbeaver'
'dracula-gtk-theme'
'dracula-grub-theme-git'
'fastfetch'
'konsole-dracula-git'
'libdbusmenu-glib'
'noto-fonts-emoji'
'ocs-url' 
'plasma-pa'
'rider-eap'
'runelite'
'snap-pac'
'visual-studio-code-bin'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

export PATH=$PATH:~/.local/bin
pip install konsave thefuck black isort
konsave -i "$HOME/MickTitus/kde.knsv"
sleep 1
konsave -a kde

echo -e "\nDone!\n"
exit
