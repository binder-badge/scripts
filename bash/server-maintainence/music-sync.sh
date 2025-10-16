#! /bin/bash
curl "https://gotify.server/message?token=<token>" -F "title=Music Sync" -F "message=$(hostname) has started the music sync" -F "priority=5"
currentDate=$(date)
rsync -r -h -z -c --delete --rsh="ssh -p <port>" --exclude=desktop.ini --exclude=sync.ffs_db --exclude=".ndignore" --log-file=$HOME/scripts/logs/music-sync.log /Music destination@server2:/home/destination
rsync -r -h -z -c --delete --rsh="ssh -p <port>" --exclude=cache/ $HOME/navidrome/data/ destination@server2:/home/destination/navidrome/
curl "https://gotify.server/message?token=<token>" -F "title=Music Sync" -F "message=$(hostname) has completed the music sync" -F "priority=5"
