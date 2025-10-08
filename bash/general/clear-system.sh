#! /bin/sh
docker system prune --force --all
sudo rm -rf /var/log/*/*
curl "https://gotify.server/message?token=<token>" -F "title=Home Server cleanup" -F "message=$(hostname) ran the cleanup script" -F "priority=5"
