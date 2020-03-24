#/bin/sh/

# Creating directory and cloning repo 
mkdir $HOME/.scripts/ 2>/dev/null

# Cloning kop to .scripts
curl -s https://raw.githubusercontent.com/kryptiksage/kop/master/kop > $HOME/.scripts/kop
# Execute permission to kop
chmod +x $HOME/.scripts/kop

# Installing jq
[ $(pacman -Qq jq 2>/dev/null | wc -l) -eq 0 ] && sudo pacman -S jq

# Export path of kop
[ -f $HOME/.zshenv ] || touch $HOME/.zshenv && sed -i '/export PATH*/d' $HOME/.zshenv
echo export PATH="$HOME/.scripts/:$PATH" >> $HOME/.zshenv
source $HOME/.zshenv

echo "Done"
