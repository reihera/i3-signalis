#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "$BASH_VERSION"
echo "SIGNALISOS Install script version 0.62"


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


#determines arguement to use for pm 
if [[ $pm ]]

 if [[ $distro == "NixOS"]]; then 
  echo "nixos package management scares me, and i'm not about to learn it, sorry nix users"
    read -p "Do you wish to install configs without checking for dependancy installation? " yesno
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


deps="kitty polybar picom python nitrogen cava playerctl"

if [[ $pm == "pacman" ]]; then
  aur=$(pacman -Qq | grep -m 1 -e yay -e paru -e aurman -e aura -e pikaur -e trizen -e pakku -e pacaur)
  if [ ! "$aur" -a "$aur" != " " ]; then   
    $aurpresent="false"
  else 
    $aurpresent="true"
  fi 
fi 


# FUCKKKKKKKKK

dependancy_install() {
    if [[ $pm == "pacman" && $aurpresent == "true" ]]; then
      read -p "Do you wish to install dependancies with their assosiated configuration files? (existing configuration files will be backed up into -backup folders, i.e, ~/.config/polybar-backup) " yesno
        case $yesno in 
            [Yy]* ) 
                echo "You answered yes"
                $aur -S zscroll polybar picom rofi kitty neofetch dunst i3 python nitrogen playerctl
                install_config() 
            ;;
            [Nn]* ) 
              echo "You answered no, exiting"
            ;;
              * ) echo "Answer either yes or no!";
            esac
    else if [[ $pm == "pacman" && $aurpresent "false" ]]; then
        echo "[FATAL] AUR Helper not identified! Please install one!"
        exit 1
      fi
    fi
    if [[ $pm == "zypper" || "dnf" || "yum" ]]; then 
      read -p "Do you wish to install dependancies with their assosiated configuration files? (existing configuration files will be backed up into -backup folders, i.e, ~/.config/polybar-backup) " yesno
        case $yesno in 
          [Yy]* )
            echo "You answered yes"
            sudo $pm install $deps
            git clone https://github.com/dylanaraps/neofetch
            cd neofetch 
            make install
            cd $SCRIPT_DIR
            git clone https://github.com/noctuid/zscroll
            cd zscroll 
            sudo python3 setup.py install
          ;;
        [Nn]* )
          echo "operation cancelled"
          ;;
            * ) echo "Yes or no answer!";
          esac 
    fi
 }







install_config () {
# Moves fonts to directory
  read -p "Do you wish to move configuration files, fonts, gtk themes and icons to their respective directories? Existing configuration files will be backed up to a -backup directory (i.e, ~/.config/polybar-backup/)." yesno
    case $yesno in
        [Yy]* )
            echo "You answered yes"
            sudo mv -a ./fonts/. /usr/share/fonts/ 
            echo "Fonts moved to /usr/share/fonts/"
          if [ -d "$HOME/.config/polybar/" ]; then
            echo "Polybar directory exists."
            mv $HOME/.config/polybar/. $HOME/.config/polybar-backup
            mv -a ./polybar/. $HOME/.config/polybar
          else
            echo "Polybar directory does not exist, creating and moving files."
            mkdir $HOME/.config/polybar
            mv -a ./polybar/. $HOME/.config/polybar
          fi

          if [ -d "$HOME/.config/neofetch" ]; then 
            echo "Neofetch directory exists, moving files"
            mv $HOME/.config/neofetch/. $HOME/.config/neofetch-backup
            mv -a ./neofetch/. $HOME/.config/neofetch

          else 
            echo "Neofetch directory does not exist, creating and moving files."
            mkdir $HOME/.config/neofetch
            mv -a ./neofetch/. $HOME/.config/neofetch
          fi 
          if [ -d "$HOME/.icons" ]; then 
            echo "icon theme directory exists, moving files"
            mv -a ./icons/. $HOME/.icons
          else 
            echo "icon theme directory does not exist, creating and moving files."
            mkdir $HOME/.icons
            mv -a ./icons/. $HOME/.icons
          fi 
          if [ -d "$HOME/.themes" ]; then 
            echo "gtk theme directory exists, moving files"
            mv -a ./themes/. $HOME/.themes
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
         ;;
        [Nn]* ) 
            echo "You answered no, exiting"
            break
        ;;
        * ) echo "Answer either yes or no!";;
    esac
     
}

browsers=("firefox" "floorp" "Quit")

firefoxchrome() {
  read -p "Do you wish to go through the Firefox/Firefox based browser (librewolf, floorp, zen(may not work correctly), etc) userChrome installation? [y/n]: " yesno 
  case $yesno in
    [Yy]* )
      PS3="Please select your Firefox-based browser! WARNING! If you have the Flatpak version of your browser installed, the installation will fail! Configuration files must be located in home directory! (i.e, ~/.firefox) [1-3]: "
      select opt in "${browsers[@]}"
      do 
        case $opt in 
          "firefox")
          browser=firefox
          echo "Firefox browser selected"
          checkdir
          break
        ;;
          "floorp")
          browser=floorp
          checkdir
          echo "Floorp browser selected"
          break
        ;;
        "Quit")
          echo "exiting firefox userChrome installation."
          break
        ;; 
      esac
      done
      ;;
  [Nn]* )
    echo "operation cancelled"
    break 
  esac

}

checkdir() {
  PS3="Select current profile. If you do not know what it is, navigate to about:profiles in your browser and check which one is active! [1-x]: "

  select browserdir in $HOME/.$browser/*; do 
    if [[ -d "$browserdir" ]]; then 
      echo "$browserdir selected"
      read -p "Proceed with userChrome installation to $HOME/.$browser/$browserdir/chrome? existing configuration files will be backed up to $HOME/.$browser/$browserdir/chrome-backup! [y/n]: " yesno 
      case $yesno in 
        [Yy]* )
          mkdir $HOME/.$browser/$browserdir/chrome-backup 
          mv $HOME/.$browser/$browserdir/chrome/. $HOME/.$browser/$browserdir/chrome-backup/
          mv ./geckochrome/chrome/. $HOME/.$browser/$browserdir/chrome/
        ;;
        [Nn]* )
          echo "operation cancelled."
          break 
        esac 
    else 
      echo "Invalid option"
    fi 
  done  

}

firefoxchrome
dependancy_install
install_config
echo "please restart computer for changes to take effect!"



