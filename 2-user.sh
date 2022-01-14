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
echo "CLONING: YAY"
cd $HOME
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd $HOME
rm -rf yay
mkdir -p $HOME/.local/plugin_managers
git clone "https://github.com/ohmyzsh/ohmyzsh" $HOME/.local/plugin_managers/ohmyzsh
git clone "https://github.com/tmux-plugins/tpm" $HOME/.local/plugin_managers/tpm
mkdir -p $HOME/.config/kitty/
ln -sf "$HOME/MickTitus/misc/dotfiles/.zshrc" "$HOME/.zshrc" 
ln -sf "$HOME/MickTitus/misc/configs/kitty.conf" "$HOME/.config/kitty/kitty.conf"
mkdir -p $HOME/.config/npm-global
export PATH=~/.config/npm-global/bin:$PATH
npm config set prefix '$HOME/.config/npm-global'
source $HOME/.zshrc

mkdir -p ~/.config/rofi
cp $HOME/.config/awesome/theme/config.rasi ~/.config/rofi/config.rasi
sed -i '/@import/c\@import "'$HOME'/.config/awesome/theme/sidebar.rasi"' ~/.config/rofi/config.rasi

ln -sf $HOME/MickTitus/misc/configs/awesome $HOME/.config/

sh $HOME/MickTitus/LunarVim.sh
ln -sf $HOME/MickTitus/misc/configs/config.lua $HOME/.config/lvim/config.lua
lvim -c PackerSync

PKGS=(
'awesome'
'rofi'
'picom'
'i3lock-fancy'
'xclip'
'polkit-gnome'
'materia-theme'
'lxappearance'
'flameshot' 
'pnmixer' 
'network-manager-applet'
'xfce4-power-manager'
'qt5-styleplugins'
'papirus-icon-theme'

  'brave-bin' 
'candy-icons-git'
'dbeaver'
'dracula-gtk-theme'
'dracula-grub-theme-git'
'noto-fonts-emoji'
'rider'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm --needed $PKG
done

export PATH=$PATH:~/.local/bin
pip install black isort

echo -e "\nDo
