#!/bin/bash
MusicFolder=/folder
myPlaylists=("list of playlists here")
# Input: $1 is the playlist name in navidrome
# $2 is the output playlist file name.
find "$MusicFolder/Playlists/" -name '*.m3u' -type f -delete
getNavidromePlaylist () {
    OutputFile="$MusicFolder/Playlists/$2"
    docker exec navidrome /app/navidrome pls -n -p "$1" |&
        sed 's/^\/music\//\.\.\//g;
            /^#.*$/d; 
            /^$/d' > "$OutputFile" || (rm "$OutputFile" || true; echo "error: playlist $1 may not exist on Navidrome"; return)
}

for ((i = 0; i < ${#myPlaylists[@]}; i++))
do
    #echo "${myPlaylists[$i]}.mp3"
    getNavidromePlaylist "${myPlaylists[$i]}" "${myPlaylists[$i]}.m3u"
done
find "$MusicFolder/Playlists/"  -type f -exec chmod 664 {} \;
find "$MusicFolder/Playlists/"  -type f -exec chown smbuser:smbgroup {} \;

