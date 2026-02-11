############################
## .zshrc for SIGNALIS-i3 ##
## by Reihera             ##
############################
# https://github.com/reihera/i3-signalis

##########
## Init ##
##########

autoload -U compinit
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

##################################
## Source env vars and aliasses ##
##################################

source ~/.config/zsh/env.zsh
source ~/.config/zsh/aliases.zsh
eval "$(zoxide init --cmd cd zsh)"

######################
## Fzf integration ###
######################
FZF_ALT_C_COMMAND= 
FZF_CTRL_T_COMMAND= 
source <(fzf --zsh)

########################
## oh-my-zsh styling ##
#######################


PROMPT="%B%F{7}[%f%b%B%F{3}%n%f%b%B@%b%B%F{4}%m%f%b%B%F{7}] [%f%b%B%F{11}%~%f%b%B%F{7}]%f%b%B%F{7}
> %f%b"

########################################
## Neofetch with random image + quote ##
########################################

neofetch 

####################
## History config ##
####################
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history


