#!/bin/sh

aur_pkg () {
	curl -s -X GET "https://aur.archlinux.org/rpc/?v=5&type=search&arg=$2" | jq -r '.results [] .Name'
}

off_pkg () {
curl -s -X GET "https://www.archlinux.org/packages/search/json/?$1=$2" | jq -r '.results [] .pkgname'
}

case $1 in
	-S)

	;;
esac
