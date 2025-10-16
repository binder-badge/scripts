#! /bin/bash
# user variables
url="music.domain.com"
user="user"
password="password"
salt="123456"
playlistFolder="/Music/Playlists"

subsonic_ver="1.16.1"

hash=$(echo -n $password$salt | md5sum | cut -d " " -f1)

find "$playlistFolder" -name '*.m3u' -type f -delete

curl "https://$url/rest/getPlaylists.view?u=$user&t=$hash&s=$salt&v=$subsonic_ver&c=curl&f=json" -o output.json

playlistCount=$(jq '."subsonic-response".playlists.playlist | length' output.json)

for ((i = 0 ; i < $playlistCount ; i++ ));
do
    playlistName=$(jq -r '."subsonic-response".playlists.playlist['$i'].name' output.json)
    playlistFilePath=$playlistFolder/$playlistName.m3u
    
    # regex line 1: /music/test/test.flac >/../test/test.flac
    # regex line 2: removes lines that start with #
    # regex line 3: removes new lines
        
    docker exec navidrome /app/navidrome pls -n -p $playlistName |& 
        sed 's/^\/music\//\.\.\//g;
            /^#.*$/d; 
            /^$/d' > "$playlistFilePath"
done

rm outut.json