#/bin/sh/

# Creating directory and cloning repo 
mkdir $HOME/.scripts/ 2>/dev/null

# Cloning kop to .scripts
curl -s https://raw.githubusercontent.com/kryptiksage/kop/master/kop > $HOME/.scripts/kop
# Execute permission to kop
chmod +x $HOME/.scripts/kop

# Installing jq
[ -z $(pacman -Qq jq 2>/dev/null) ] && sudo pacman -S jq

# Export path of kop
[ -f $HOME/.zshenv ] || touch $HOME/.zshenv && sed -i '/export PATH*/d' $HOME/.zshenv
export PATH="$(echo $PATH | sed "s/\/home\/$USER\/.scripts\/\://g")"
echo export PATH="$HOME/.scripts/:$PATH" >> $HOME/.zshenv
source ~/.zshenv

echo "Done"
