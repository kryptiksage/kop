#!/bin/sh

aur_pkg () {
	curl -s -X GET "https://aur.archlinux.org/rpc/?v=5&type=search&arg=$1" | jq '.results []'
}

off_pkg () {
curl -s -X GET "https://www.archlinux.org/packages/search/json/?$1=$2" | jq '.results []'
}

case $1 in
	-S)
	[ $# -lt 2 ] && echo "Insuffient number of packages" && exit 1
	for(( i=2; i<=$#; i++ ))
	do
		package=$(off_pkg name $2 | jq -r  '.pkgname')
		if [ -z "$package" ]
		then
			package=$(aur_pkg $2 |jq -r '.Name' | grep "^$2$")
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
	[ $# -lt 2 ] && echo "Insuffient number of packages" && exit 1
	sudo pacman -R $2
	;;
	"")
	sudo pacman -Syu
	echo "Updating AUR packages..."
	aur_installed=$(pacman -Qmq)
	for pkg in $aur_installed
	do
		aur_update=$(aur_pkg $pkg | jq -r 'select(.Name=='\"$pkg\"') | .Version')
		if [ "$aur_update" != "$(pacman -Qm $pkg | awk '{print $2}')" ]
		then
			echo $aur_update
			echo "Updating $pkg.."
			pkg_dir=$HOME/.cache/kop/$pkg
			if [ -d $pkg_dir ]
			then
				cd $pkg_dir
				rm -rf $pkg*
				git pull
			else
				git clone https://aur.archlinux.org/$pkg.git $pkg_dir
				cd $pkg_dir
			fi
			makepkg -si
		fi
	done
	;;
	*)
	[ $# -ne 1 ] && echo "Invalid number of arguments" && exit 1
	off_pkg q $1 | jq -r '"\(.pkgname) \(.pkgver) (\(.repo))\nAbout: \(.pkgdesc)\n"' > $HOME/.cache/kop/.pkg_search
	aur_pkg $1 | jq -r '"\(.Name) \(.Version) (AUR)\nAbout: \(.Description)\n"' >> $HOME/.cache/kop/.pkg_search
	cat $HOME/.cache/kop/.pkg_search
	;;
esac
