#!/bin/bash
# if this file was left in the repo, it was on accident, do not run.
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
  esac

}

checkdir() {
  echo "Select current profile. If you do not know what it is, navigate to about:profiles in your browser and check which one is active! [1-x]: "

  select browserdir in $HOME/.$browser/*; do 
    if [[ -d "$browserdir" ]]; then 
      echo "$browserdir selected"
      break 
    else 
      echo "invalid"
    fi 
  done  

}

firefoxchrome

echo "$HOME/.$browser/$browserdir/chrome-backup"
