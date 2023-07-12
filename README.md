<sub>Tilte working with music files (with bugs of course)</sub>
![Then the music beat up](https://github.com/Russanandres/tilte/blob/d5e17030529a01cc31d00a940d46af99bd624e3d/image.png)

## Depencies
· ffmpeg (ffprobe is part of ffmpeg)  
· bash  
· music files in one directory  

## Usage
Run script with path after, like `bash tilte.sh /home/$USER/Music/`  
Tilte automaticaly renames all your music files in directory as `$Artist - $Title.flac`  
Warning! Use only absolute path! Relative path will not work at all!  

## Known bugs
· mv cannot rename files with `/` or `\` in name, so tilte cannot rename them.  
· tilte can't accsess to folders. Please use it in one folder with all files.  
· tilte tries to rename photos and videos in your folder, so try to not store other type of media with music.
  
WIP  

## Tests results
| Input data  | Normal mode time | Silent mode time |
| ----------- | ---------------- | ---------------- |
| 498 files   | 44.8 seconds     | 43.8 seconds     |
| 3820 files  | 5m 38 sec        | 5m 27 sec        |
| 15252 files | 26m 55 sec       | 27m 20 sec (WTH) |
 
