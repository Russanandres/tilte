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

function exitscr(){ clear;echo "Tilte. By Russanandres";date;exit
 }

# Okay, so "reduction - meaning"
# ar - artist
# ti - title
# al - album
# ye - album year
# an - album number
# sn - side number




way=$(readlink -f $1)

clear
echo -e "${Green}Hello. Our mission is ${BIBlue}$way ${Green}?

${BIRed}(Yes/No?)${No_color}"

read ch
case "$ch" in
"Yes"|"yes"|"Y"|"y" )

function long(){ clear
for file in $way/* ; do
unset title; unset artist
ext=${file#*.}
artist=$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 $file)
title=$(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 $file)
echo -e "${Green} Processing $file. Renamed to${BIBlue} $artist - $title.$ext${No_color}"
if [[ ! -z "$title" ]] && [[ ! -z "$artist" ]] && [[ ! -z "$ext" ]]; then mv -f "$file" "$way"/"$artist - $title.$ext"; fi
if [ "$?" == 1 ]; then let err=$err+1; else let renamed=$renamed+1; fi
let total=$total+1
done
}


function verbose(){ clear
for file in $way/* ; do
echo -e "${Green}------------------------------------------------------${No_color}"
echo -e "Processing${BIBlue} $file${No_color}"
unset title; unset artist
ext=${file#*.}
echo -e "Extension is:${BIBlue} $ext${No_color}"
artist=$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 $file)
echo -e "Artist is:${BIBlue} $artist${No_color}"
title=$(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 $file)
echo -e "Title is:${BIBlue} $title${No_color}"
if [[ ! -z "$title" ]] && [[ ! -z "$artist" ]] && [[ ! -z "$ext" ]]; then mv -v -f "$file" "$way"/"$artist - $title.$ext"; fi
if [ "$?" == 1 ]; then let err=$err+1; else let renamed=$renamed+1; fi
echo -e "Renamed to${BIBlue} $artist - $title.$ext${No_color}"
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

if [ "$2" == "-f" ] || [ "$2" == "--no-verbose" ]; then fast
elif [ "$2" == "-v" ] || [ "$2" == "--verbose" ]; then verbose; else long; fi

;;
* ) exitscr;;
esac
echo -e "
Total tracks: ${BIRed}$total${No_color} | Total renamed: ${BIRed}$renamed${No_color} | Total errors: ${BIRed}$err${No_color}"
exit
