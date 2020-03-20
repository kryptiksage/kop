#/bin/sh/

# Creating directory and cloning repo 
mkdir -p $HOME/.scripts/kop 2>/dev/null

# Cloning kop to .scripts
if [ -d $HOME/.scripts/kop ]
then
	cd $HOME/.scripts/kop 
	git pull
else
	git clone https://github.com/kryptiksage/kop.git $HOME/.scripts/kop
fi

# Execute permission to kop
chmod +x $HOME/.scripts/kop/kop

# Installing jq
[ $(pacman -Qq jq 2>/dev/null | wc -l) -eq 0 ] && sudo pacman -S jq

# Export path of kop
echo export PATH="$HOME/.scripts/kop:$PATH" >> $HOME/.zshrc
