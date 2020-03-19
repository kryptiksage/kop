#/bin/sh/

# Creating directory and cloning repo 
mkdir $HOME/.scripts 2>/dev/null
git clone https://git.io/JvP8e $HOME/.scripts/.kop

# Installing jq
[ $(pacman -Qq jq 2>/dev/null | wc -l) -eq 0 ] && sudo pacman -S jq

# Export path of .kop
echo export PATH="$HOME/scripts/.kop:$PATH" >> .zshrc
