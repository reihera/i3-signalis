#!/bin/bash
echo "$BASH_VERSION"
echo "SIGNALISOS Install script version 0.05-indev"

# Move fonts
sudo cp -a ./fonts/. /usr/share/fonts/ 

if command -v apt > /dev/null 2>&1; then
    echo "apt package manager identified"
    pm="apt"
  elif command -v dnf > /dev/null 2>&1; then
    echo "dnf package manager identified"
    pm="dnf"
  elif command -v yum > /dev/null 2>&1; then
    echo "yum package manager identified"
    pm="yum"
  elif command -v zypper > /dev/null 2>&1; then
    echo "zypper package manager identified"
    pm="yum"
  elif command -v pacman > /dev/null 2>&1; then
    echo "pacman package manager identified"
    pm="pacman"
  else
    echo "No known package manager found, what the fuck are you using?"
    exit 1 

fi






#identifies distro 

distro="$(source /etc/os-release && echo $NAME)"
echo "Distro identified as $distro. This variable is deprecated, please use $pm instead."

# Arch/Arch based dependancy installation
deps install
if [[ $pm == "pacman" ]]; then
  aur=$(pacman -Qq | grep -m 1 -e yay -e paru -e aurman -e aura -e pikaur -e trizen -e pakku -e pacaur)
  if [ ! "$aur" -a "$aur" != " " ]; then   
    echo "[FATAL] AUR Helper not identified! Please install one!"
    read -p "Do you wish to install configs without checking for dependancy installation " yesno
    case $yesno in
        [Yy]* ) 
            echo "You answered yes"
            install_config()
        ;;
        [Nn]* ) 
            echo "You answered no, exiting"
            exit 1
        ;;
        * ) echo "Answer either yes or no!";;
    esac
   
  else 
    echo "$aur AUR helper identified"
    $aur -S git polybar picom rofi kitty neofetch dunst i3-wm
    install_config()
  fi
fi 

# Debian/Debian based installation

#if [[ $pm == "apt"]]; then
# sudo apt install picom i3 rofi kitty dunst git
# git clone https://github.com/dylanaraps/neofetch/releases/latest
# git clone https://github.com/noctuid/zscroll
#fi 



if [[ $pm == "dnf"]]; then 
  echo "dnf package manager not implemented into install script."
    read -p "Do you wish to install configs without checking for dependancy installation " yesno
    case $yesno in
        [Yy]* ) 
            echo "You answered yes"
            install_config()
        ;;
        [Nn]* ) 
            echo "You answered no, exiting"
            exit 1
        ;;
        * ) echo "Answer either yes or no!";;
    esac
fi 
 
if [[ $pm == "apt"]]; then 
  echo "apt package manager not implemented into install script."
    read -p "Do you wish to install configs without checking for dependancy installation " yesno
    case $yesno in
        [Yy]* ) 
            echo "You answered yes"
            install_config()
        ;;
        [Nn]* ) 
            echo "You answered no, exiting"
            exit 1
        ;;
        * ) echo "Answer either yes or no!";;
    esac
fi 
 

if [[ $pm == "yum"]]; then 
  echo "yum package manager not implemented into install script."
    read -p "Do you wish to install configs without checking for dependancy installation " yesno
    case $yesno in
        [Yy]* ) 
            echo "You answered yes"
            install_config()
        ;;
        [Nn]* ) 
            echo "You answered no, exiting"
            exit 1
        ;;
        * ) echo "Answer either yes or no!";;
    esac
    
fi 
 
if [[ $pm == "zypper"]]; then 
  echo "zypper package manager not implemented into install script."
    read -p "Do you wish to install configs without checking for dependancy installation " yesno
    case $yesno in
        [Yy]* ) 
            echo "You answered yes"
            install_config()
        ;;
        [Nn]* ) 
            echo "You answered no, exiting"
            exit 1
        ;;
        * ) echo "Answer either yes or no!";;
    esac
    
fi 
 if [[ $pm == "rpm"]]; then 
  echo "rpm package manager not implemented into install script."
    read -p "Do you wish to install configs without checking for dependancy installation " yesno
    case $yesno in
        [Yy]* ) 
            echo "You answered yes"
            install_config()
        ;;
        [Nn]* ) 
            echo "You answered no, exiting"
            exit 1
        ;;
        * ) echo "Answer either yes or no!";;
    esac
    
fi 






# sorry nix users
if [ "$distro" == "NixOS"]; then 
  echo "I do not know NixOS package management, and I'm not about to learn. Good luck." 
  exit 1 
fi 


install_config () {
# Copies configuration and backs up existing configs
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
}


