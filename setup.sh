#/bin/sh/
git clone https://git.io/JvP8e $HOME/.kop
cd $HOME/.kop

[ $(pacman -Qq jq 2>/dev/null | wc -l) -eq 0 ] && sudo pacman -S jq

echo export PATH="$HOME/.kop:$PATH" >> .zshrc
