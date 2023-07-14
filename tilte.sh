#!/bin/bash

IFS=$'\n'
err="0";total="0";renamed="0";sim="0"
ext="mp3"
# source $USER/.config/tilte.conf

if [ -z $1 ]; then echo "Nothing to do"; exit; else way="$1";fi
way=$(readlink -f $1)

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
# an - song number
# sn - side number

function helpscr(){
echo "tilte.sh. By Russanandres.
Usage: tilte.sh [path] [option]
Availiable options:
    -v | --verbose      >>  Show more output
    -f | --no-verbose   >>  Show less output
    -s | --simulate     >>  Simulate the process
    -h | --help         >>  Show help manual
    -r | --recurse      >>  Rename through subdirectories"; exit
}

while [ "$1" != "" ]; do
    case $1 in
        -v | --verbose) verbose="1";;
        -f | --no-verbose | --fast | --silent ) fast="1";;
        -s | --simulate ) sim="1";;
        -h | --help ) helpscr;;
        -r | --recurse ) rec="1";;
    esac
    shift
done


clear
echo -e "${Green}Hello. Our mission is ${BIBlue}$way ${Green}?

${BIRed}(Yes/No?)${No_color}"

trap "exitscr" SIGINT
read ch
case "$ch" in
"Yes"|"yes"|"Y"|"y" )

function long(){ clear
for file in $way/* ; do
unset title; unset artist
ext=${file##*.}
artist=$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 $file)
title=$(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 $file)
echo -e "${Green} Processing $file. Renamed to${BIBlue} $artist - $title.$ext${No_color}"
if [[ ! -z "$title" ]] && [[ ! -z "$artist" ]] && [[ ! -z "$ext" ]] && [ "$sim" == "0" ]; then mv -f "$file" "$way"/"$artist - $title.$ext"; fi
if [ "$?" == 1 ]; then let err=$err+1; else let renamed=$renamed+1; fi
let total=$total+1
trap "break" SIGINT
done
}




function verbose(){ clear
for file in $way/* ; do
echo -e "${Green}------------------------------------------------------${No_color}"
echo -e "Processing${BIBlue} $file${No_color}"
unset title; unset artist
ext=${file##*.}
echo -e "Extension is:${BIBlue} $ext${No_color}"
artist=$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 $file)
echo -e "Artist is:${BIBlue} $artist${No_color}"
title=$(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 $file)
echo -e "Title is:${BIBlue} $title${No_color}"
if [[ ! -z "$title" ]] && [[ ! -z "$artist" ]] && [[ ! -z "$ext" ]] && [ "$sim" == "0" ]; then mv -v -f "$file" "$way"/"$artist - $title.$ext"; fi
if [ "$?" == 1 ]; then let err=$err+1; else let renamed=$renamed+1; fi
echo -e "Renamed to${BIBlue} $artist - $title.$ext${No_color}"
let total=$total+1
trap "echo; break" SIGINT
done
}




function rec(){ clear
for file in $(find $way); do
echo -e "${Green}------------------------------------------------------${No_color}"
echo -e "Processing${BIBlue} $file${No_color}"
unset title; unset artist
ext=${file##*.}
echo -e "Extension is:${BIBlue} $ext${No_color}"
artist=$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 $file)
echo -e "Artist is:${BIBlue} $artist${No_color}"
title=$(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 $file)
echo -e "Title is:${BIBlue} $title${No_color}"
if [[ ! -z "$title" ]] && [[ ! -z "$artist" ]] && [[ ! -z "$ext" ]] && [ "$sim" == "0" ]; then mv -v -f "$file" "$way"/"$artist - $title.$ext"; fi
if [ "$?" == 1 ]; then let err=$err+1; else let renamed=$renamed+1; fi
echo -e "Renamed to${BIBlue} $artist - $title.$ext${No_color}"
let total=$total+1
trap "echo; break" SIGINT
done
}




function fast(){
renamed=X;err=X
for file in $way/* ; do
ext=${file##*.};mv "$file" $way/"$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 $file) - $(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 $file).$ext"
let total=$total+1
trap "echo;break" SIGINT
done
}

if [ "$fast" == "1" ]; then fast
elif [ "$rec" == "1" ]; then rec
elif [ "$verbose" == "1" ]; then verbose
else long
fi

;;
* ) exitscr;;
esac
echo -e "
Total tracks: ${BIRed}$total${No_color} | Total renamed: ${BIRed}$renamed${No_color} | Total errors: ${BIRed}$err${No_color}"
exit
