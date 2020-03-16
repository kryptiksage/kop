#!/bin/sh

# Package keyword
pkg=$1

# Matching list
aur_list=$(curl -s -X GET "https://aur.archlinux.org/rpc/?v=5&type=search&arg=$pkg" | jq -r '.results [] .Name')
off_list=$(curl -s -X GET "https://www.archlinux.org/packages/search/json/?q=$pkg" | jq -r '.results [] .pkgname')
