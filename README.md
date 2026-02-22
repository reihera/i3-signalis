# i3-Signalis
## i3 dotfiles meant to mimic the UI of the horror game SIGNALIS.


> [!CAUTION]
> Work in progress! Most things will need to be done manually! Install script does not work for anything other than Arch Linux and Debian-based distributions currently! If your package manager is not one of the following, pacman, dnf, apt, yum, zypper, or rpm, support for your package manager is __not__ planned. (i.e, NixOS support is not planned to be implemented. You can still use the install script, it will just not automatically install dependancies for you. Depenancies needed for install are listed below.)


![bar](https://github.com/user-attachments/assets/b778f2aa-c5d2-4c1a-a06d-3269fa754b7b)



|   Objective   |    Status     |
| ------------- | ------------- |
| General i3 Look/Feel  | 100%  |
| Polybar        | 100%  |
| GTK Theme      |   100%  |
| Kvantum Theme | 0%  |  
| Kitty Terminal Theme | 100%  |
| Install Script | 75%  |
| Kitty theming (oh-my-zsh, neofetch, etc) | 70%  |
| Font implementation | 100%  |
| Plymouth Theme  | 0%  |
| Greeter theme  | 0%  |


## Installation instructions 

>[!NOTE]
> Arch Linux installation requires one of the following AUR helpers: yay (reccomended), paru (reccomended), aurman (untested), aura (untested), pikaur (untested), trizen (untested), pakku (untested), pacaur (untested)

- First, clone the repo
```sh
git clone https://github.com/reihera/i3-signalis.git
```

- Then, cd into the directory
```sh
cd i3-signalis
```

- chmod install.sh

```sh
chmod +x install.sh
```

- finally, run install.sh 

```sh
./install.sh 
```

follow the instructions for installing dependancies and moving the configs. If you have existing configuration files within the directories, they will automatically be backed up into .config (i.e, ~/.config/polybar-backup/). 


## Dependancies required (usually handled by install script)

- Polybar
- Picom 
- Zscroll 
- kitty 
- neofetch 
- python3
- nitrogen
- cava
- playerctl



<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b68aaa74-39fa-4526-b3e0-70f64a887a29" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/25397092-2ccf-4965-b331-fc29d654ebb9" />



## Contact

Matrix: @reihera:4d2.org
X/Twitter: reihera_d
Telegram: https://t.me/reihera
