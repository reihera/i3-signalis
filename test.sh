#!/bin/bash
# if this file was left in the repo, it was on accident, do not run.
#
pm="pacman"


dependancy_install() {
    echo "1"
    read -p "Do you wish to install dependancies with their assosiated configuration files? (existing configuration files will be backed up into -backup folders, i.e, ~/.config/polybar-backup) " yesno
      case $yesno in
          [Yy]* ) 
              echo "You answered yes"
              sudo $pm -Syu
          ;;
          [Nn]* ) 
            echo "You answered no, exiting"
            exit 1
          ;;
          * ) echo "Answer either yes or no!";;
    esac
 

}

dependancy_install
