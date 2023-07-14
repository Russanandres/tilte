<sub>Tilte working with music files (with bugs of course)</sub>
![Then the music beat up](https://github.com/Russanandres/tilte/blob/d5e17030529a01cc31d00a940d46af99bd624e3d/image.png)

## What is that?
This script trying to receive ID3v* tags of artist and song name and renames file to `$Artist - $Title.*`  pattern.  
Tilte tries to rename **ALL** your music files in one directory and sadly can't move through folders at now.

## Depencies
· ffmpeg (ffprobe is part of ffmpeg)  
· bash  
· music files in one directory  

## Usage
***1st argument is always your path***, so run script as `bash tilte.sh /home/$USER/Music/`.  
To check help manual, run `bash tilte.sh -h`  
To use tilte in current directory, run `bash tilte.sh .`  
To show all log while running, run script with `-v` or `--verbose`.  
To simulate all process, run tilte with `-s` or `--simulate`.  
You can run **EXPEREMENTAL** recurse renaming by `-r` argument, all your files will be moved in start folder.

## Known bugs
· mv cannot rename files with `/` or `\` in name, so tilte cannot rename them.  
· ~~tilte can't accsess to folders. Please use it in single folder with all your music files or rerun for every folder.~~  
· tilte tries to rename photos and videos in your folder, so try to not store other type of media with music.

## Tests results
| Input data  | Normal mode time | Silent mode time |
| ----------- | ---------------- | ---------------- |
| 498 files   | 44.8 seconds     | 43.8 seconds     |
| 3820 files  | 5m 38 sec        | 5m 27 sec        |
| 15252 files | 26m 55 sec       | 27m 20 sec (WTH) |
 

WIP
