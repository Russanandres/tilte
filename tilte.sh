#!/bin/bash

IFS=$'\n'
err=0;total=0;renamed=0
ext=mp3
# source $USER/.config/tilte.conf

if [ -z $1 ]; then echo "Nothing to do"; exit; else way="$1";fi

Green='\033[0;32m'
BIRed='\033[1;91m'
BIBlue='\033[1;94m'
No_color='\033[0m'

function exitscr(){ clear;echo "Tilte $VER - 2022-$(date +%Y). Russanandres";date;exit
 }

# Okay, so "reduction - meaning"
# ar - artist
# ti - title
# al - album
# ye - album year
# an - album number
# sn - side number






clear
echo -e "${Green}Hello. Our mission is ${BIBlue}$way ${Green}?

${BIRed}(Yes/No?)${No_color}"

# read ch
# case "$ch" in
# "Yes"|"yes"|"Y"|"y" )

function long(){ clear
for file in $way/* ; do
ext=${file#*.}
artist=$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 $file); sn=$?
title=$(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 $file); s=$?
echo -e "${Green} Processing $file. Renamed to${BIBlue} $artist - $title.$ext${No_color}"
if [ "$s" == 0 ] && [ "$sn" == 0 ]; then mv "$file" $way/"$artist - $title.$ext"; fi
if [ "$?" == 1 ]; then let err=$err+1; else let renamed=$renamed+1; fi
let total=$total+1
done
}

function fast(){
renamed=X;err=X
for file in $way/* ; do
ext=${file#*.};mv "$file" $way/"$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 $file) - $(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 $file).$ext"
let total=$total+1
done
}

if [ "$2" == "-f" ] || [ "$2" == "--no-verbose" ]; then fast; else long; fi

# ;;
# * ) exitscr;;
# esac
echo -e "
Total tracks: ${BIRed}$total${No_color} | Total renamed: ${BIRed}$renamed${No_color} | Total errors: ${BIRed}$err${No_color}"
exit
