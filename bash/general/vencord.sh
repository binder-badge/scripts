#!/bin/bash
echo "downloading vencord"
wget https://github.com/Vencord/Installer/releases/latest/download/VencordInstallerCli-linux -O vencord-installer 

echo "\n\nfinished downloading vencord"
chmod +x vencord-installer
clear
sudo ./vencord-installer -install
rm vencord-installer
killall Discord
# flatpak run com.discordapp.Discord
