#!/bin/sh

aur_pkg () {
	curl -s -X GET "https://aur.archlinux.org/rpc/?v=5&type=search&arg=$1" | jq -r '.results [] .Name'
}

off_pkg () {
curl -s -X GET "https://www.archlinux.org/packages/search/json/?$1=$2" | jq -r '.results [] .pkgname'
}

case $1 in
	-S)
	for(( i=2; i<=$#; i++ ))
	do
		package=$(off_pkg name $2)
		if [ -z "$package" ]
		then
			package=$(aur_pkg $2 | grep "^$2$")
			if [ -z "$package" ]
			then
				echo "Invalid package name : $package"
			else
				echo "Cloning aur repo..."
				git clone --depth=1 https://aur.archlinux.org/$package.git $HOME/.cache/kop/$package 2>/dev/null
				cd $HOME/.cache/kop/$package
				makepkg -si
			fi
		else
			sudo pacman -S $package
		fi
	done
	;;
	-R)
	sudo pacman -R $2
	;;
	"")
	# TODO : code for updating all packages
	;;
	*)
	# TODO : code for listing packages
	;;
esac
