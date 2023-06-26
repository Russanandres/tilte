<sub>Tilte working with music files</sub>
![Then the music beat up](https://github.com/Russanandres/tilte/blob/4cdbd0213f7ccdae84d919253d7c4dc70f22812b/tilte%20in%20work.png)

## Depencies
· ffmpeg (ffprobe is part of ffmpeg)  
· bash  
· mp3 files  

## Usage
Run script with path after like `bash tilte.sh /home/$USER/music/`  
Tilte automaticaly renames all your mp3 files in directory by `$Artist - $Title.mp3`  
Warning! Use only absolute path! Relative path will not work at all!  

## Known bugs
· mv cannot rename files with `/` or `\` in name, so tilte cannot rename them.  
· tilte can't accsess to folders. Please use it in one folder with all files.  
  
WIP  
