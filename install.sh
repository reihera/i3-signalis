#!/bin/bash
echo "$BASH_VERSION"
echo "SIGNALISOS Install script version 0.01-indev"

# Move fonts
#sudo cp -a ./fonts/. /usr/share/fonts/ 


if [ -d "$HOME/.config/polybar/" ]; then
    echo "Polybar directory exists."
    mv $HOME/.config/polybar/. $HOME/.config/polybar-backup
    cp -a ./polybar/. $HOME/.config/polybar
else
    echo "Polybar directory does not exist, creating and moving files."
    mkdir $HOME/.config/polybar
fi

if [ -d "$HOME/.config/neofetch" ]; then 
  echo "Neofetch directory exists, moving files"
  mv $HOME/.config/neofetch/. $HOME/.config/neofetch-backup
  cp -a ./neofetch/. $HOME/.config/neofetch

else 
  echo "Neofetch directory does not exist, creating and moving files."
  mkdir $HOME/.config/neofetch
  cp -a ./neofetch/. $HOME/.config/neofetch
fi 
if [ -d "$HOME/.icons" ]; then 
  echo "icon theme directory exists, moving files"
  cp -a ./icons/. $HOME/.icons
else 
  echo "icon theme directory does not exist, creating and moving files."
  mkdir $HOME/.icons
  cp -a ./icons/. $HOME/.icons
fi 
if [ -d "$HOME/.themes" ]; then 
  echo "gtk theme directory exists, moving files"
  cp -a ./themes/. $HOME/.themes
else 
  echo "gtk theme directory does not exist, creating and moving files."
  mkdir $HOME/.themes
  cp -a ./themes/. $HOME/.themes
fi 

if [ -d "$HOME/.config/i3" ]; then 
  echo "i3 directory exists, moving files"
  mv $HOME/.config/i3/. $HOME/.config/i3-backup
  cp -a ./i3/. $HOME/.config/i3

else 
  echo "i3 directory does not exist, creating and moving files."
  mkdir $HOME/.config/i3
  cp -a ./i3/. $HOME/.config/i3
fi 






distro="$(source /etc/os-release && echo $NAME)"
echo "Distro identified as $distro"


deps install
if [[ $distro == "Arch Linux" ]]; then
  aur=$(pacman -Qq | grep -m 1 -e yay -e paru -e aurman -e aura -e pikaur -e trizen -e pakku -e pacaur)
  if [ ! "$aur" -a "$aur" != " " ]; then   
    echo "[FATAL] AUR Helper not identified! Please install one!"
    exit 1 
  else 
    echo "$aur AUR helper identified"
    $aur -S polybar picom rofi kitty neofetch dunst i3-wm
  fi
fi 

if [[ $distro == "Ubuntu"||"Debian"||"Linux Mint"||"Deepin"||"Nitrux"||"SolydXK"||"Kaisen"|| ]]; then
 sudo apt install picom i3 rofi kitty dunst git
# git clone https://github.com/dylanaraps/neofetch/releases/latest
fi 







if [ "$distro" == "NixOS"]; then 
  echo "I do not know NixOS package management, and I'm not about to learn. Good luck." 
  exit 1 
fi 

