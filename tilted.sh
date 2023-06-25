#!/bin/bash

IFS=$'\n'
dir="$1"

Green='\033[0;32m'
BIRed='\033[1;91m'
BIBlue='\033[1;94m'
No_color='\033[0m'

function exitscr(){
 clear
 echo "Tilte $VER - 2022-$(date +%Y). Russanandres"
 date
 exit
}

# Okay, so "reduction - meaning"
# ar - artist
# ti - title
# al - album
# ye - album year
# an - album number
# sn - side number






clear
echo -e "${Green}Hello. Our mission is ${BIBlue}$dir ${Green}?

${BIRed}(Yes/No?)${No_color}"
read ch
case "$ch" in
"Yes"|"yes" )

clear
for file in $dir/*.mp3
do
artist=$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 $file)
title=$(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 $file)
echo -e "${Green} Processing $file. Renamed to $artist - $title.mp3${No_color}"
mv $file $dir/"$artist - $title.mp3"
done
;;

* ) exitscr;;
esac
echo "Rename Complete!"
echo "Exiting..."
exit
